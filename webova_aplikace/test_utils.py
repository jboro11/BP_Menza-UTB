"""
test_utils.py - unit testy pro pomocne funkce webove aplikace.
"""

import sys
import os

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

from utils import parse_allergens, vyrob_ascii_nazev


# --- testy pro vyrob_ascii_nazev ---

def test_ascii_nazev_diakritika():
    # mela by odstranit diakritiku
    vysledek = vyrob_ascii_nazev("Svíčková na smetaně")
    assert vysledek == "svickovanasmetan" or "svickova" in vysledek, f"Neocekavany vysledek: {vysledek}"

def test_ascii_nazev_prazdny_retezec():
    # prazdny vstup vrati prazdny retezec
    assert vyrob_ascii_nazev("") == ""

def test_ascii_nazev_none():
    # None vstup vrati prazdny retezec
    assert vyrob_ascii_nazev(None) == ""

def test_ascii_nazev_mala_pismena():
    # vystup je vzdycky malymi pismeny
    assert vyrob_ascii_nazev("GULÁŠ") == "gulas"

def test_ascii_nazev_bez_mezer():
    # mezery se odstrani
    result = vyrob_ascii_nazev("kuřecí řízek")
    assert " " not in result


# --- testy pro parse_allergens ---

def test_parse_allergens_prazdny():
    # prazdny vstup
    assert parse_allergens("") == ""
    assert parse_allergens(None) == ""

def test_parse_allergens_lepek():
    # pšenice -> alergen 1a
    vysledek = parse_allergens("obsahuje pšenici a lepek")
    assert "1a" in vysledek

def test_parse_allergens_mleko():
    # smetana -> alergen 7
    vysledek = parse_allergens("se smetanou a máslem")
    assert "7" in vysledek

def test_parse_allergens_vejce():
    # vejce -> alergen 3
    vysledek = parse_allergens("obsahuje vejce")
    assert "3" in vysledek

def test_parse_allergens_vice_alergenu():
    # kombinace orechy + ryby
    vysledek = parse_allergens("se lískovými ořechy a rybím masem")
    assert "8b" in vysledek
    assert "4" in vysledek

def test_parse_allergens_para_orech_ne_parametr():
    # "parametr" nesmí spustit detekci para orechu
    vysledek = parse_allergens("vstupní parametr funkce")
    assert "8f" not in vysledek

def test_parse_allergens_serazeni():
    # vystup je serazen - nizsi cisla driv
    vysledek = parse_allergens("mléko, vejce, pšenice")
    kody = vysledek.split(", ")
    # 1a (pšenice) má přijít dřív než 7 (mléko)
    if "1a" in kody and "7" in kody:
        assert kody.index("1a") < kody.index("7"), "Alergeny nejsou spravne serazeny"

def test_parse_allergens_hotove_kody():
    # vstup uz obsahuje hotove kody - ma je zachovat
    vysledek = parse_allergens("1, 3, 7")
    assert "1" in vysledek
    assert "3" in vysledek
    assert "7" in vysledek


# --- spusteni ---

if __name__ == "__main__":
    testy = [
        test_ascii_nazev_diakritika,
        test_ascii_nazev_prazdny_retezec,
        test_ascii_nazev_none,
        test_ascii_nazev_mala_pismena,
        test_ascii_nazev_bez_mezer,
        test_parse_allergens_prazdny,
        test_parse_allergens_lepek,
        test_parse_allergens_mleko,
        test_parse_allergens_vejce,
        test_parse_allergens_vice_alergenu,
        test_parse_allergens_para_orech_ne_parametr,
        test_parse_allergens_serazeni,
        test_parse_allergens_hotove_kody,
    ]

    uspesne = 0
    neuspesne = 0
    for test in testy:
        try:
            test()
            print(f"  OK  {test.__name__}")
            uspesne += 1
        except AssertionError as e:
            print(f"  FAIL {test.__name__}: {e}")
            neuspesne += 1
        except Exception as e:
            print(f"  ERR  {test.__name__}: {e}")
            neuspesne += 1

    print(f"\nVysledek: {uspesne}/{len(testy)} testu proslo.")
    if neuspesne > 0:
        sys.exit(1)
