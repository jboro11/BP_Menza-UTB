"""
Lokální mezipaměť jídelníčků stahovaných na pozadí.
"""

import threading
import time
import logging

import menu_collector

logger = logging.getLogger(__name__)

# Interval obnovy dat v sekundách
REFRESH_INTERVAL = 30

# ID menz, které se zobrazují na infopanelech
VISIBLE_CANTEEN_IDS = [c_id for c_id, _ in menu_collector.SEZNAM_JIDELEN if c_id not in {16, 17, 18, 19, 20}]

# Zámek a slovník pro ukládání dat
_lock  = threading.Lock()
_cache = {}

# Datum API, pro které jsou data platná
_current_api_date = None


def _fetch_all(api_date):
    # Stáhne data ze všech viditelných jídelen
    new_data = {}
    for canteen_id in VISIBLE_CANTEEN_IDS:
        try:
            raw_cz = menu_collector.stahni_data(api_date, canteen_id, lang="cs")
            if raw_cz:
                meals_cz = menu_collector.zpracuj_jidla(raw_cz)
                
                # Pokus o stažení anglického překladu
                try:
                    raw_en = menu_collector.stahni_data(api_date, canteen_id, lang="en")
                    if raw_en:
                        meals_en = menu_collector.zpracuj_jidla(raw_en)
                        # Mapování anglických názvů
                        en_dict = {
                            (m.get("meal_kind_id"), m.get("alt_id")): m.get("name", "")
                            for m in meals_en
                        }
                        # Doplnění anglických názvů do českého jídelníčku
                        for m in meals_cz:
                            key = (m.get("meal_kind_id"), m.get("alt_id"))
                            m["name_en"] = en_dict.get(key, "")
                except Exception as en_err:
                    logger.warning("Cache: nepodarilo se stahnout anglickou verzi pro jidelnu %d: %s", canteen_id, en_err)

                new_data[canteen_id] = {
                    "meals": meals_cz,
                    "fetched_at": time.time(),
                }
                logger.info("Cache: jidelna %d - %d jidel.", canteen_id, len(meals_cz))
            else:
                logger.warning("Cache: jidelna %d - API vratilo prazdna data.", canteen_id)
        except Exception:
            logger.exception("Cache: chyba pri stahovani jidelny %d.", canteen_id)

    return new_data


def _get_api_date():
    # Vrátí aktuální API datum (půlnoc v UTC pro dnešní den)
    from datetime import datetime, timedelta
    from zoneinfo import ZoneInfo
    yesterday = datetime.now(ZoneInfo("Europe/Prague")) - timedelta(days=1)
    api_date, _ = menu_collector.ziskej_datum_pro_api(yesterday.strftime("%Y-%m-%d"))
    return api_date


def _worker(app):
    # Běží na pozadí a pravidelně aktualizuje data v cache
    with app.app_context():
        while True:
            try:
                api_date = _get_api_date()
                new_data = _fetch_all(api_date)
                if new_data:
                    with _lock:
                        _cache.update(new_data)
                        global _current_api_date
                        _current_api_date = api_date
            except Exception:
                logger.exception("Cache worker: neocekavana chyba v hlavni smycce.")
            time.sleep(REFRESH_INTERVAL)


def start_cache_worker(app):
    # Spustí vedlejší vlákno pro aktualizaci mezipaměti
    t = threading.Thread(target=_worker, args=(app,), daemon=True, name="menu-cache-worker")
    t.start()
    logger.info("Cache worker spusten (interval %ds, menzy: %s).", REFRESH_INTERVAL, VISIBLE_CANTEEN_IDS)


def get_cached_meals(canteen_id):
    # Pokud cache ještě neobsahuje data (první sekundy po startu), vrátí None
    with _lock:
        entry = _cache.get(canteen_id)
    return entry["meals"] if entry else None


def get_cache_age(canteen_id):
    # Vrátí stáří dat v cache v sekundách, nebo None pokud data nejsou
    with _lock:
        entry = _cache.get(canteen_id)
    if not entry:
        return None
    return time.time() - entry["fetched_at"]


def get_current_api_date():
    # Vrátí API datum, pro které jsou aktuálně platná data v cache
    with _lock:
        return _current_api_date
