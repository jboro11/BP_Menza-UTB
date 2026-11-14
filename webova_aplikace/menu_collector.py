"""
Stahování jídelníčků z WebKreditu a převod do CSV.
Použití: python menu_collector.py --date 2025-11-10 --canteen 2
"""

import argparse
import csv
import json
import os
import unicodedata
from datetime import datetime, timedelta
from zoneinfo import ZoneInfo

import requests

# Seznam menz, jejich ID a názvy složek
# ID menzy, název složky
SEZNAM_JIDELEN = [
    (16, 'U11 UNI'),
    (17, 'U15 LCFT'),
    (18, 'U16 FMK'),
    (19, 'U17 CPS'),
    (20, 'U18 FHS'),
    (2, 'U4'),
    (3, 'U5'),
    (4, 'BUFET U2'),
    (6, 'U13'),
    (15, 'GARNI'),
]

PRAGUE_TZ = ZoneInfo("Europe/Prague")


def ziskej_datum_pro_api(datum_str):
    """
    Vrátí timestamp pro API odpovídající půlnoci pražského času v UTC.
    API WebKredit vyžaduje přesně tento formát, jinak vrátí prázdný jídelníček.
    """
    if datum_str:
        dt = datetime.fromisoformat(datum_str)
    else:
        dt = datetime.now(PRAGUE_TZ) - timedelta(days=1)

    # Den, pro který chceme menu, je den po předaném datu
    target_dt = dt + timedelta(days=1)
    target_midnight = target_dt.replace(
        hour=0, minute=0, second=0, microsecond=0, tzinfo=PRAGUE_TZ
    )
    datum_api = target_midnight.astimezone(ZoneInfo("UTC")).strftime("%Y-%m-%dT%H:00:00.000Z")

    dt = dt.replace(hour=23, minute=0, second=0, microsecond=0)
    return datum_api, dt


def stahni_data(datum_param, id_jidelny, lang='cs'):
    # Cílová URL adresa WebKredit API
    url = 'https://jidelnicek.utb.cz/webkredit/Api/Ordering/Menu'
    
    params = {
        'Dates': datum_param,
        'CanteenId': id_jidelny,
    }
    
    print(f'Stahovani dat ({lang}) pro jidelnu ID {id_jidelny}...')
    
    headers = {
        'User-Agent': 'Mozilla/5.0',
        'Accept-Language': lang
    }
    
    cookies = {
        '.AspNetCore.Culture': f'c={lang}|uic={lang}'
    }
    
    try:
        r = requests.get(url, params=params, headers=headers, cookies=cookies, timeout=20)
        r.raise_for_status()
        return r.json()
    except requests.exceptions.RequestException as e:
        print(f"Chyba site pri stahovani jidelny {id_jidelny}: {e}")
        return None
    except ValueError as e:
        # Neplatná JSON odpověď (např. chybová stránka)
        print(f"Chyba parsovani JSON pro jidelnu {id_jidelny}: {e}")
        return None

def zpracuj_jidla(json_data):
    # Vytáhne z JSON struktury klíčové informace pro uložení a zobrazení
    radky = []
    
    groups = json_data.get('groups')
    if not groups:
        return radky

    for g in groups:
        kategorie = g.get('mealKindName')
        
        rows = g.get('rows', [])
        for r in rows:
            item = r.get('item', {})
            nazev = item.get('mealName')
            
            nazev_ascii = ''
            if nazev:
                n = unicodedata.normalize('NFKD', nazev).encode('ascii', 'ignore').decode('ascii')
                nazev_ascii = n.lower().replace(' ', '').strip()

            alergeny = item.get('allergens')
            if not alergeny:
                short = item.get('allergensShort')
                if short:
                    alergeny = ', '.join(short)
                else:
                    alergeny = ''

            count_available = item.get('countAvailable')
            count_ordered = item.get('countOrdered')

            # Bezpečné vytažení ceny pokrmu
            price = item.get('price')
            if price is None:
                price = item.get('mealPrice')

            price2 = item.get('price2')

            radky.append({
                'category': kategorie,
                'name': nazev,
                'name_ascii': nazev_ascii,
                'allergens': alergeny,
                'count_available': count_available,
                'count_ordered': count_ordered,
                'price': price,
                'price_public': price2,
                'price2': price2,
                'meal_kind_id': item.get('mealKindId'),
                'alt_id': item.get('altId')
            })
    return radky

def uloz_csv(data, cesta):
    hlavicky = ['category', 'name', 'name_ascii', 'allergens', 'count_available', 'count_ordered', 'price', 'price_public', 'price2']
    
    # Kódování UTF-8 s BOM pro bezproblémové otevírání v Excelu na Windows
    with open(cesta, 'w', encoding='utf-8-sig', newline='') as f:
        writer = csv.DictWriter(f, fieldnames=hlavicky, extrasaction='ignore')
        writer.writeheader()
        for radek in data:
            writer.writerow(radek)
    
    if not data:
        print(f'Uloženo prázdné CSV (žádná jídla): {cesta}')
    else:
        print(f'Uloženo CSV: {cesta}')

def aktualizuj_master(nove_radky, cesta_master):
    # Přidá nová jídla do hlavního souboru, pokud je ještě neobsahuje
    existujici_klice = set()
    
    # Pokud soubor existuje, načtou se stávající klíče
    if os.path.exists(cesta_master):
        with open(cesta_master, 'r', encoding='utf-8-sig', newline='') as f:
            reader = csv.DictReader(f)
            for r in reader:
                # Unikátní identifikátor pro detekci duplicit
                na = r.get('name_ascii', '')
                al = r.get('allergens', '')
                klic = f"{na}|{al}"
                existujici_klice.add(klic)
    
    novych = 0
    mode = 'a' if os.path.exists(cesta_master) else 'w'
    with open(cesta_master, mode, encoding='utf-8-sig', newline='') as f:
        writer = csv.DictWriter(f, fieldnames=['category', 'name', 'name_ascii', 'allergens', 'count_available', 'count_ordered', 'price', 'price_public', 'price2'], extrasaction='ignore')
        
        # Pokud se vytváří nový soubor, zapíše se hlavička
        if mode == 'w':
            writer.writeheader()
            
        for r in nove_radky:
            klic = f"{r['name_ascii']}|{r['allergens']}"
            if klic not in existujici_klice:
                writer.writerow(r)
                existujici_klice.add(klic)
                novych += 1
                
    print(f'Hlavní soubor aktualizován: {cesta_master} (+{novych} nových jídel)')

def main():
    parser = argparse.ArgumentParser(description='Stahovac jidelnicku')
    parser.add_argument('--date', help='Datum (YYYY-MM-DD). Kdyz chysi, bere se vcerejsek.')
    parser.add_argument('--canteen', type=int, help='ID jidelny (pokud chces jen jednu)')
    parser.add_argument('--all', action='store_true', help='Stahnout vsechny jidelny ze seznamu')
    parser.add_argument('--raw', help='Cesta kam ulozit JSON (funguje jen pro jednu jidelnu)')
    
    args = parser.parse_args()

    # Příprava data
    datum_api, datum_obj = ziskej_datum_pro_api(args.date)
    # Formát pro název souboru: DD.MM.YY
    nazev_souboru_base = datum_obj.strftime('%d.%m.%y')

    # Rozhodnutí, které jídelny zpracovat
    ke_zpracovani = []
    
    if args.all:
        ke_zpracovani = SEZNAM_JIDELEN
    elif args.canteen:
        # Nalezení názvu jídelny
        label = ''
        for cid, lab in SEZNAM_JIDELEN:
            if cid == args.canteen:
                label = lab
                break
        ke_zpracovani = [(args.canteen, label)]
    else:
        print("Je nutné zadat buď --canteen ID nebo --all")
        return

    vsechny_radky_pro_master = []

    for id_jidelny, nazev_jidelny in ke_zpracovani:
        # Vytvoření cílové složky
        slozka = f'canteen={id_jidelny}'
        if nazev_jidelny:
            slozka += f' {nazev_jidelny}'
            
        if not os.path.exists(slozka):
            os.makedirs(slozka)

        # 1. Stažení JSON struktury
        data = stahni_data(datum_api, id_jidelny)
        if not data:
            continue

        # Uložení syrových JSON dat
        cesta_json = os.path.join(slozka, f'{nazev_souboru_base}.json')
        with open(cesta_json, 'w', encoding='utf-8') as f:
            json.dump(data, f, ensure_ascii=False, indent=2)
            print(f'Uložen JSON: {cesta_json}')

        # 2. Převod na CSV strukturu
        radky = zpracuj_jidla(data)
        vsechny_radky_pro_master.extend(radky)

        # Uložení denního CSV souboru
        cesta_csv = os.path.join(slozka, f'{nazev_souboru_base}.csv')
        uloz_csv(radky, cesta_csv)

    # Při stažení všech jídelen se aktualizuje hlavní soubor
    if args.all:
        # Soubor se aktualizuje i při prázdném seznamu
        aktualizuj_master(vsechny_radky_pro_master, 'master.csv')

if __name__ == '__main__':
    main()

