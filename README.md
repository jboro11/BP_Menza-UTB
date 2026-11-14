# Menza UTB

Repozitář obsahuje praktickou část bakalářské práce zaměřené na vizuální prezentaci jídel v menze Univerzity Tomáše Bati ve Zlíně. Cílem práce bylo doplnit textový jídelníček o fotografie hotových pokrmů, aby se strávníci mohli rozhodnout před příchodem k výdejnímu pultu a výdej jídel probíhal rychleji.

Systém automaticky načítá aktuální nabídku z WebKreditu. Obsluha kuchyně v mobilní aplikaci pořizuje fotografie a přiřazuje je k jednotlivým jídlům. Po nahrání se snímky zobrazují spolu s jídelníčkem na televizních panelech v jídelně. Funkčnost systému byla ověřena v testovacím provozu.

## Obsah repozitáře

- [Mobilní aplikace](mobilni_aplikace/) ve Flutteru pro pořizování a nahrávání fotografií.
- [Webová aplikace](webova_aplikace/) s API ve Flasku, databází PostgreSQL a rozhraním pro infopanely v JavaScriptu.
- [Dokumentace](dokumentace/index.html) s návody pro obsluhu, správce a vývojáře.

## Spuštění

Před spuštěním se z `.env.example` vytvoří soubor `.env` a doplní se heslo k databázi (`DB_PASS`) a čtyřmístný PIN pro mobilní aplikaci (`MOBILE_APP_PIN`). Webová aplikace se spouští z kořene repozitáře příkazem `docker compose up --build` a je dostupná na `http://localhost:5001`.

Adresa serveru se mobilní aplikaci předává parametrem `API_BASE_URL`. Postup je uvedený v [návodu ke spuštění mobilní aplikace](mobilni_aplikace/README.md#spuštění).
