import os
import re
import psycopg2
from psycopg2 import pool
import unicodedata

# Konfigurace DB z environment proměnných (.env soubor)
DB_HOST = os.getenv("DB_HOST", "127.0.0.1")
DB_PORT = int(os.getenv("DB_PORT", "5432"))
DB_NAME = os.getenv("DB_NAME", "postgres")
DB_USER = os.getenv("DB_USER", "postgres")
DB_PASS = os.getenv("DB_PASS", "")

_db_pool = None


def init_db_pool():
    # Vytvoří pool vláknových připojení k DB (min 2, max 10)
    global _db_pool
    _db_pool = pool.ThreadedConnectionPool(
        2, 10,
        host=DB_HOST,
        port=DB_PORT,
        database=DB_NAME,
        user=DB_USER,
        password=DB_PASS,
    )


def get_conn():
    if _db_pool is None:
        raise RuntimeError("DB pool nebyl inicializován. Zavolej init_db_pool() při startu.")
    return _db_pool.getconn()


def release_conn(conn):
    # Vrátí připojení zpět do poolu, při chybě transakce provede rollback
    if not _db_pool or not conn:
        return
    try:
        if conn.closed == 0 and conn.status == psycopg2.extensions.STATUS_IN_TRANSACTION:
            conn.rollback()
    except Exception:
        pass
    _db_pool.putconn(conn)


# Povolené přípony a MIME typy pro nahrávané fotky
ALLOWED_EXTENSIONS = {"jpg", "jpeg", "png", "webp"}
ALLOWED_MIME_TYPES  = {"image/jpeg", "image/png", "image/webp"}


def allowed_photo(file):
    # Zkontroluje příponu a MIME typ nahrávaného obrázku
    name = file.filename or ""
    ext  = name.rsplit(".", 1)[-1].lower() if "." in name else ""
    if ext not in ALLOWED_EXTENSIONS:
        return False
    
    mime = file.mimetype or ""
    # Zpětná kompatibilita pro specifické MIME typy u některých mobilních klientů
    if mime == "application/octet-stream" or not mime:
        mimes_by_ext = {
            "jpg": "image/jpeg",
            "jpeg": "image/jpeg",
            "png": "image/png",
            "webp": "image/webp"
        }
        mime = mimes_by_ext.get(ext, "")
        
    return mime in ALLOWED_MIME_TYPES


# Parser alergenů z API WebKreditu
def parse_allergens(raw):
    # Převede textový popis alergenů na seřazený seznam kódů
    if not raw:
        return ""
    text = str(raw).lower()
    found = set()

    # Pokud vstup již obsahuje hotové kódy alergenů, zachováme je
    pre_coded = re.findall(r"\b(1[0-4]|[1-9][a-h]?)\b", text)
    if pre_coded:
        for code in pre_coded:
            found.add(code)

    # 1 - Obiloviny obsahující lepek
    if re.search(r"pšenic|pšenice", text):
        found.add("1a")
    if "žito" in text:
        found.add("1b")
    if "ječmen" in text:
        found.add("1c")
    if "oves" in text:
        found.add("1d")
    # Obecný lepek přidáme pouze v případě, že není specifikována podkategorie
    if "lepek" in text and not found.intersection({"1a", "1b", "1c", "1d"}):
        found.add("1")

    # 2 - korysi
    if re.search(r"korýš|kreveta|krab|humr|langust", text):
        found.add("2")

    # 3 - vejce
    if re.search(r"vejc|vajec|vaječ", text):
        found.add("3")

    # 4 - ryby
    if "ryb" in text:
        found.add("4")

    # 5 - arasidy
    if re.search(r"arašíd|podzemnic", text):
        found.add("5")

    # 6 - soja
    if re.search(r"soja|sój", text):
        found.add("6")

    # 7 - mleko
    if re.search(r"mlék|smetan|tvaroh|laktóz", text):
        found.add("7")

    # 8 - Skořápkové plody
    # Para ořechy - ošetření, aby nedošlo k falešné detekci u slova "parametr"
    if re.search(r"skořápkov|stromov.{0,5}ořech", text):
        found.add("8")
    if "mandl" in text:
        found.add("8a")
    if "lískov" in text:
        found.add("8b")
    if "vlašsk" in text:
        found.add("8c")
    if "kešu" in text:
        found.add("8d")
    if "pekan" in text:
        found.add("8e")
    if re.search(r"\bpara\b.*?ořech|ořech.*?\bpara\b", text):
        found.add("8f")
    if "pistác" in text:
        found.add("8g")
    if "makadam" in text:
        found.add("8h")

    # 9 - celer
    if "celer" in text:
        found.add("9")

    # 10 - horcice
    if "hořčic" in text:
        found.add("10")

    # 11 - sezam
    if "sezam" in text:
        found.add("11")

    # 12 - oxid siricity
    if "siřičit" in text:
        found.add("12")

    # 13 - vlci bob (lupin)
    if re.search(r"lupin|vlčí bob", text):
        found.add("13")

    # 14 - mekkýsi
    if re.search(r"měkkýš|mušl|ústřic|sépi|chobotnic", text):
        found.add("14")

    def _sort_key(item):
        m = re.match(r"(\d+)([a-z]*)", item)
        if m:
            return (int(m.group(1)), m.group(2))
        return (999, item)

    return ", ".join(sorted(found, key=_sort_key))


def vyrob_ascii_nazev(text):
    # Odstraní diakritiku, převede text na malá písmena a odstraní mezery (slouží jako slug)
    if not text:
        return ""
    n = unicodedata.normalize("NFKD", text)
    n = n.encode("ascii", "ignore").decode("ascii")
    return n.lower().replace(" ", "").strip()

