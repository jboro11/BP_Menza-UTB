"""
Synchronizační robot pro naplnění databáze záznamy jídel.

Spouští se jako jednorázová úloha (cron, docker run --rm) typicky ráno před
otevřením menzy. Stáhne jídelníček ze všech menz, doplní překlady a uloží
nová jídla do databáze. Fotografie nahrává obsluha přes mobilní aplikaci.
"""

import logging
from datetime import datetime, timedelta
from zoneinfo import ZoneInfo

import psycopg2

import menu_collector
from utils import DB_HOST, DB_PORT, DB_NAME, DB_USER, DB_PASS, parse_allergens, vyrob_ascii_nazev

logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s [%(levelname)s] %(message)s",
)
logger = logging.getLogger(__name__)

PRAGUE_TZ = ZoneInfo("Europe/Prague")


def _get_or_create_category(cur, name):
    """
    Vrátí ID kategorie. Pokud ještě neexistuje, vytvoří ji.
    Pracuje s předaným kurzorem – bez vlastního commitu.
    """
    cur.execute("SELECT id FROM categories WHERE name = %s", (name,))
    row = cur.fetchone()
    if row:
        return row[0]
    cur.execute("INSERT INTO categories (name) VALUES (%s) RETURNING id", (name,))
    return cur.fetchone()[0]


def run_robot():
    """
    Stáhne jídelníček ze všech menz a synchronizuje záznamy do DB.
    Jedna transakce na celý běh – při chybě se vše vrátí zpět.
    """
    now = datetime.now(PRAGUE_TZ)
    logger.info("Robot: spoustim synchronizaci...")

    yesterday = (now - timedelta(days=1)).strftime("%Y-%m-%d")
    datum_api, _ = menu_collector.ziskej_datum_pro_api(yesterday)

    try:
        conn = psycopg2.connect(
            host=DB_HOST, port=DB_PORT,
            database=DB_NAME, user=DB_USER, password=DB_PASS,
        )
    except psycopg2.OperationalError:
        logger.exception("Nelze se pripojit k databazi.")
        return

    added              = 0
    translations_added = 0

    try:
        with conn:
            with conn.cursor() as cur:

                # Předběžné načtení všech kategorií jedním dotazem (zamezení N+1 problému)
                cur.execute("SELECT id, name FROM categories")
                cat_cache = {row[1]: row[0] for row in cur.fetchall()}

                for canteen_id, canteen_name in menu_collector.SEZNAM_JIDELEN:
                    raw_cz = menu_collector.stahni_data(datum_api, canteen_id, lang="cs")
                    raw_en = menu_collector.stahni_data(datum_api, canteen_id, lang="en")

                    if not raw_cz:
                        logger.warning("[%s] Zadna data, preskakuji.", canteen_name)
                        continue

                    menu_cz = menu_collector.zpracuj_jidla(raw_cz)
                    menu_en = menu_collector.zpracuj_jidla(raw_en) if raw_en else []

                    # Vytvoření slovníku anglických názvů pro spárování pomocí (meal_kind_id, alt_id)
                    menu_en_dict = {}
                    for meal_en in menu_en:
                        key = (meal_en.get("meal_kind_id"), meal_en.get("alt_id"))
                        menu_en_dict[key] = meal_en.get("name", "")

                    for meal_cz in menu_cz:
                        name_cz       = meal_cz.get("name", "")
                        
                        # Spárování překladu na základě unikátního klíče skupiny a indexu pokrmu
                        key           = (meal_cz.get("meal_kind_id"), meal_cz.get("alt_id"))
                        name_en       = menu_en_dict.get(key, "")
                        
                        slug          = vyrob_ascii_nazev(name_cz)
                        allergens     = parse_allergens(meal_cz.get("allergens", ""))
                        category_name = meal_cz.get("category", "Neznama kategorie")

                        # Získání kategorie z mezipaměti nebo vytvoření nové
                        if category_name not in cat_cache:
                            cur.execute(
                                "INSERT INTO categories (name) VALUES (%s) RETURNING id",
                                (category_name,)
                            )
                            cat_cache[category_name] = cur.fetchone()[0]
                        cat_id = cat_cache[category_name]

                        # Kontrola, zda již pokrm v databázi existuje
                        cur.execute(
                            "SELECT id, name_en FROM meals WHERE slug = %s",
                            (slug,)
                        )
                        existing = cur.fetchone()

                        if existing:
                            # Doplnění anglického překladu, pokud dosud chyběl
                            if not existing[1] and name_en:
                                cur.execute(
                                    "UPDATE meals SET name_en = %s WHERE id = %s",
                                    (name_en, existing[0])
                                )
                                translations_added += 1
                        else:
                            cur.execute(
                                "INSERT INTO meals (category_id, original_name, name_en, slug, allergens) "
                                "VALUES (%s, %s, %s, %s, %s)",
                                (cat_id, name_cz, name_en, slug, allergens)
                            )
                            added += 1

        logger.info(
            "Hotovo - pridano %d jidel, doplneno %d prekladu.",
            added, translations_added,
        )

    except Exception:
        logger.exception("Chyba pri synchronizaci, zmeny byly vraceny zpet.")
    finally:
        conn.close()


if __name__ == "__main__":
    run_robot()
