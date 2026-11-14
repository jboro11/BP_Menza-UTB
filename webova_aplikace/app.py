import os
import logging
from datetime import datetime, timedelta
from zoneinfo import ZoneInfo

from flask import Flask, render_template, jsonify, request, send_file, abort, make_response
from werkzeug.utils import secure_filename

import menu_collector
import menu_cache
from utils import (
    init_db_pool, get_conn, release_conn,
    parse_allergens, allowed_photo, vyrob_ascii_nazev,
)

logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s [%(levelname)s] %(name)s: %(message)s",
)
logger = logging.getLogger(__name__)

app = Flask(__name__)

SEZNAM_JIDELEN  = menu_collector.SEZNAM_JIDELEN
SKRYTE_JIDELNY_NA_WEBU = {16, 17, 18, 19, 20}

# Pomocná funkce pro vyhledání souboru lokálně i v kontejneru
def najdi_soubor(filename):
    cesta = os.path.join(os.path.dirname(__file__), filename)
    if os.path.isfile(cesta):
        return cesta
    cesta = os.path.join(os.path.dirname(os.path.dirname(__file__)), filename)
    if os.path.isfile(cesta):
        return cesta
    cesta = os.path.join("/", filename)
    if os.path.isfile(cesta):
        return cesta
    return None

NO_PHOTO_PATH = najdi_soubor("no_photo.png") or os.path.join(os.path.dirname(__file__), "no_photo.png")
SIRSI_NO_PHOTO_PATH = najdi_soubor("sirsi_no_photo.png") or os.path.join(os.path.dirname(__file__), "sirsi_no_photo.png")

ZAVARENINY_CANDIDATES = [
    najdi_soubor("zavareniny.png"),
    najdi_soubor("Zavareniny.png"),
    os.path.join(os.path.dirname(__file__), "static", "zavareniny.png"),
    os.path.join(os.path.dirname(__file__), "static", "photos", "zavareniny.png"),
    os.path.join(os.path.dirname(__file__), "static", "photos", "Zavareniny.png"),
]
# Vyčištění neplatných cest
ZAVARENINY_CANDIDATES = [p for p in ZAVARENINY_CANDIDATES if p is not None]

UPLOAD_FOLDER = os.path.join(os.path.dirname(__file__), "static", "uploads")
os.makedirs(UPLOAD_FOLDER, exist_ok=True)
app.config["UPLOAD_FOLDER"] = UPLOAD_FOLDER

PRAGUE_TZ = ZoneInfo("Europe/Prague")


def viditelne_jidelny():
    return [j for j in SEZNAM_JIDELEN if j[0] not in SKRYTE_JIDELNY_NA_WEBU]


def no_cache(response):
    response.headers["Cache-Control"] = "no-store, no-cache, must-revalidate, max-age=0"
    response.headers["Pragma"]  = "no-cache"
    response.headers["Expires"] = "0"
    return response


def add_security_headers(response):
    response.headers["X-Content-Type-Options"] = "nosniff"
    response.headers["X-Frame-Options"]        = "SAMEORIGIN"
    response.headers["Referrer-Policy"]        = "strict-origin-when-cross-origin"
    return response


@app.after_request
def apply_headers(response):
    add_security_headers(response)
    if request.path.startswith("/api/"):
        # Povolení CORS pro přístup z různých síťových segmentů (infopanely a mobilní aplikace)
        response.headers["Access-Control-Allow-Origin"]  = "*"
        response.headers["Access-Control-Allow-Methods"] = "GET, POST, OPTIONS"
        response.headers["Access-Control-Allow-Headers"] = "Content-Type"
    return response


@app.route("/")
def index():
    return render_template("index.html", jidelny=viditelne_jidelny())

@app.route("/test")
@app.route("/dbcheck")
def test_page():
    return render_template("test.html", jidelny=viditelne_jidelny())

@app.route("/no_photo.png")
def no_photo_image():
    if not os.path.isfile(NO_PHOTO_PATH):
        abort(404)
    return send_file(NO_PHOTO_PATH, mimetype="image/png")

@app.route("/sirsi_no_photo.png")
def sirsi_no_photo_image():
    if not os.path.isfile(SIRSI_NO_PHOTO_PATH):
        if os.path.isfile(NO_PHOTO_PATH):
            return send_file(NO_PHOTO_PATH, mimetype="image/png")
        abort(404)
    return send_file(SIRSI_NO_PHOTO_PATH, mimetype="image/png")

@app.route("/zavareniny.png")
def zavareniny_image():
    for path in ZAVARENINY_CANDIDATES:
        if os.path.isfile(path):
            return send_file(path, mimetype="image/png")
    if os.path.isfile(SIRSI_NO_PHOTO_PATH):
        return send_file(SIRSI_NO_PHOTO_PATH, mimetype="image/png")
    if os.path.isfile(NO_PHOTO_PATH):
        return send_file(NO_PHOTO_PATH, mimetype="image/png")
    abort(404)

# --- API rozhraní pro infopanely ---
@app.route("/api/load-menu")
def api_load_menu():
    conn = None
    try:
        canteen_id = request.args.get("canteen_id", default=2, type=int)
        # Načtení dat z lokální paměti (cache)
        aktualni_menu = menu_cache.get_cached_meals(canteen_id)

        # Záložní přímé stažení, pokud je lokální cache prázdná
        if aktualni_menu is None:
            dnes = (datetime.now(PRAGUE_TZ) - timedelta(days=1)).strftime("%Y-%m-%d")
            datum_api, _ = menu_collector.ziskej_datum_pro_api(dnes)
            raw_cz = menu_collector.stahni_data(datum_api, canteen_id, lang="cs")   
            if not raw_cz:
                return no_cache(make_response(jsonify({"status": "error", "message": "Nepodarilo se stahnout data z univerzitniho API."})))
            aktualni_menu = menu_collector.zpracuj_jidla(raw_cz)

        db_jede = False
        try:
            conn = get_conn()
            cur = conn.cursor()
            db_jede = True
        except Exception as db_err:
            logger.error(f"DB chyba: {db_err}")

        vysledna_data = []
        # Zpracování pokrmů a synchronizace s databází
        for jidlo in aktualni_menu:
            slug = vyrob_ascii_nazev(jidlo.get("name", ""))
            alergeny_api = parse_allergens(jidlo.get("allergens", ""))

            if jidlo.get("price_public") is None and jidlo.get("price2") is not None:
                jidlo["price_public"] = jidlo.get("price2")
            
            if db_jede:
                # Ochrana proti SQL injection pomocí parametrizace dotazů
                cur.execute("""
                    SELECT m.id, m.name_en, m.allergens, p.file_path
                    FROM meals m
                    LEFT JOIN photos p
                        ON p.meal_id = m.id AND p.is_primary = TRUE
                    WHERE m.slug = %s;
                """, (slug,))
                vysledek = cur.fetchone()

                if vysledek:
                    jidlo["db_id"] = vysledek[0]
                    db_name_en = vysledek[1] if vysledek[1] else ""
                    api_name_en = jidlo.get("name_en", "")
                    
                    # Doplnění chybějícího překladu z API
                    if not db_name_en and api_name_en:
                        cur.execute("UPDATE meals SET name_en = %s WHERE id = %s;", (api_name_en, vysledek[0]))
                        db_name_en = api_name_en

                    db_allergens = vysledek[2]
                    # Synchronizace alergenů v DB podle aktuálních dat z API (pokud nejsou prázdná)
                    if alergeny_api and alergeny_api != db_allergens:
                        cur.execute("UPDATE meals SET allergens = %s WHERE id = %s;", (alergeny_api, vysledek[0]))
                        db_allergens = alergeny_api

                    jidlo["name_en"] = db_name_en
                    jidlo["allergens"] = db_allergens if db_allergens else alergeny_api
                    jidlo["image_url"] = vysledek[3] if vysledek[3] else None
                else:
                    kategorie_nazev = jidlo.get("category", "Neznámá kategorie")
                    cur.execute("SELECT id FROM categories WHERE name = %s;", (kategorie_nazev,))
                    cat = cur.fetchone()
                    if cat:
                        cat_id = cat[0]
                    else:
                        cur.execute("INSERT INTO categories (name) VALUES (%s) RETURNING id;", (kategorie_nazev,))
                        cat_id = cur.fetchone()[0]

                    api_name_en = jidlo.get("name_en", "")
                    cur.execute(
                        "INSERT INTO meals (category_id, original_name, name_en, slug, allergens) VALUES (%s, %s, %s, %s, %s) RETURNING id;",
                        (cat_id, jidlo.get("name", ""), api_name_en, slug, alergeny_api)
                    )
                    jidlo["db_id"] = cur.fetchone()[0]
                    jidlo["name_en"] = api_name_en
                    jidlo["allergens"] = alergeny_api
                    jidlo["image_url"] = None
            else:
                jidlo["db_id"] = "DB offline"
                jidlo["name_en"] = jidlo.get("name_en", "")
                jidlo["allergens"] = alergeny_api
                jidlo["image_url"] = None

            vysledna_data.append(jidlo)

        if db_jede:
            conn.commit()
            cur.close()
            release_conn(conn) # Bezpečné vrácení připojení zpět do poolu

        resp = make_response(jsonify({"status": "ok", "data": vysledna_data}))
        return no_cache(resp)

    except Exception as e:
        if conn:
            release_conn(conn) # Uvolnění spojení i v případě výjimky
        return jsonify({"status": "error", "message": str(e)})


@app.route("/api/portions")
def api_portions():
    # API endpoint pro zjištění zbývajících porcí
    canteen_id = request.args.get("canteen_id", default=2, type=int)
    meals = menu_cache.get_cached_meals(canteen_id)
    if meals is None:
        return no_cache(make_response(jsonify({"status": "error"}))), 503

    portions = [
        {"name": m.get("name", ""), "count_available": m.get("count_available")}
        for m in meals
    ]
    resp = make_response(jsonify({"status": "ok", "portions": portions}))
    return no_cache(resp)

@app.route("/api/mobile/menu")
def api_mobile_menu():
    try:
        canteen_id = request.args.get("canteen_id", default=0, type=int)
        
        if canteen_id != 0:
            canteen_ids = [canteen_id]
        else:
            canteen_ids = [c_id for c_id, _ in SEZNAM_JIDELEN if c_id not in SKRYTE_JIDELNY_NA_WEBU]

        conn = None
        try:
            conn = get_conn()
            cur = conn.cursor()
        except Exception:
            return jsonify({"error": "Databaze je nedostupna."}), 503

        mobile_data = []
        seen_meal_ids = set()

        for c_id in canteen_ids:
            aktualni_menu = menu_cache.get_cached_meals(c_id)
            if aktualni_menu is None:
                dnes = (datetime.now(PRAGUE_TZ) - timedelta(days=1)).strftime("%Y-%m-%d")
                datum_api, _ = menu_collector.ziskej_datum_pro_api(dnes)
                raw_cz = menu_collector.stahni_data(datum_api, c_id, lang="cs")
                if not raw_cz:
                    continue
                aktualni_menu = menu_collector.zpracuj_jidla(raw_cz)

            for jidlo in aktualni_menu:
                nazev = jidlo.get("name", "")
                slug = vyrob_ascii_nazev(nazev)
                
                # Ochrana proti SQL injection pomocí parametrizace dotazů
                cur.execute("""
                    SELECT m.id, m.allergens,
                           EXISTS(SELECT 1 FROM photos p WHERE p.meal_id = m.id AND p.is_primary = TRUE)
                    FROM meals m 
                    WHERE m.slug = %s;
                """, (slug,))
                zaznam = cur.fetchone()

                db_id = None
                has_photo = False
                alergeny = parse_allergens(jidlo.get("allergens", ""))

                if zaznam:
                    db_id = zaznam[0]
                    has_photo = zaznam[2]
                    alergeny_db = zaznam[1]
                    # Synchronizace alergenů v DB při nalezení rozdílů
                    if alergeny and alergeny != alergeny_db:
                        cur.execute("UPDATE meals SET allergens = %s WHERE id = %s;", (alergeny, db_id))
                        alergeny_db = alergeny
                    if alergeny_db:
                        alergeny = alergeny_db
                else:
                    kategorie_nazev = jidlo.get("category", "Neznámá kategorie")
                    cur.execute("SELECT id FROM categories WHERE name = %s;", (kategorie_nazev,))
                    cat = cur.fetchone()
                    if cat:
                        cat_id = cat[0]
                    else:
                        cur.execute("INSERT INTO categories (name) VALUES (%s) RETURNING id;", (kategorie_nazev,))
                        cat_id = cur.fetchone()[0]

                    cur.execute(
                        "INSERT INTO meals (category_id, original_name, slug, allergens) VALUES (%s, %s, %s, %s) RETURNING id;",
                        (cat_id, nazev, slug, alergeny)
                    )
                    db_id = cur.fetchone()[0]

                if db_id not in seen_meal_ids:
                    seen_meal_ids.add(db_id)
                    mobile_data.append({
                        "meal_id": db_id,
                        "name": nazev,
                        "category": jidlo.get("category", ""),
                        "allergens": alergeny,
                        "has_photo": has_photo
                    })

        conn.commit()
        cur.close()
        release_conn(conn)
        return jsonify(mobile_data)

    except Exception as e:
        return jsonify({"error": str(e)}), 500


@app.route("/api/mobile/upload", methods=["POST"])
def api_mobile_upload():
    try:
        meal_id = request.form.get("meal_id")
        if not meal_id:
            return jsonify({"error": "Chybí meal_id"}), 400

        if "photo" not in request.files:
            return jsonify({"error": "Chybí photo v requestu"}), 400
            
        file = request.files["photo"]
        if file.filename == "":
            return jsonify({"error": "Prázdný název souboru"}), 400

        if not allowed_photo(file):
            return jsonify({"error": "Nepodporovaný formát."}), 415

        conn = None
        try:
            conn = get_conn()
            cur = conn.cursor()
        except Exception:
            return jsonify({"error": "Databaze je nedostupna. Ukladani fotek je vypnuto."}), 503

        filename = secure_filename(f"img_meal_{meal_id}_{datetime.now(PRAGUE_TZ).strftime('%Y%m%d%H%M%S')}.jpg")
        file_path = os.path.join(app.config["UPLOAD_FOLDER"], filename)
        file.save(file_path)

        relative_path = f"uploads/{filename}"

        # Parametrizovaný dotaz z bezpečnostních důvodů
        cur.execute("UPDATE photos SET is_primary = FALSE WHERE meal_id = %s;", (meal_id,))
        cur.execute(
            "INSERT INTO photos (meal_id, file_path, is_primary, created_at) VALUES (%s, %s, TRUE, %s);",
            (meal_id, relative_path, datetime.now(PRAGUE_TZ).replace(tzinfo=None))
        )
        conn.commit()
        cur.close()
        release_conn(conn)

        return jsonify({"status": "ok", "message": "Fotografie byla uspesne ulozena."})

    except Exception as e:
        if conn:
            release_conn(conn)
        return jsonify({"error": str(e)}), 500


@app.route("/api/mobile/verify_pin", methods=["POST"])
def api_mobile_verify_pin():
    try:
        data = request.get_json() or {}
        entered_pin = data.get("pin")
        correct_pin = os.environ.get("MOBILE_APP_PIN")

        if correct_pin and entered_pin == correct_pin:
            return jsonify({"status": "ok", "message": "PIN je správný."})
        else:
            return jsonify({"status": "error", "message": "Zadaný PIN je nesprávný."}), 401
    except Exception as e:
        return jsonify({"error": str(e)}), 500


# --- inicializace a spusteni aplikace ---
with app.app_context():
    try:
        init_db_pool()
        logger.info("DB pool inicializovan.")
    except Exception:
        logger.exception("Nepodarilo se inicializovat DB pool.")

menu_cache.start_cache_worker(app)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5001)
