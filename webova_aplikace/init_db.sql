--
-- Schéma a výchozí seznam jídel pro PostgreSQL.
--

-- Dumped by pg_dump version 16.13 (Ubuntu 16.13-0ubuntu0.24.04.1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: categories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categories (
    id integer NOT NULL,
    name character varying(100) NOT NULL
);


--
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.categories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.categories_id_seq OWNED BY public.categories.id;


--
-- Name: meals; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.meals (
    id integer NOT NULL,
    original_name character varying(1024) NOT NULL,
    slug character varying(1024) NOT NULL,
    allergens character varying(500),
    name_en character varying(1024),
    category_id integer
);


--
-- Name: meals_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.meals_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: meals_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.meals_id_seq OWNED BY public.meals.id;


--
-- Name: photos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.photos (
    id integer NOT NULL,
    meal_id integer NOT NULL,
    file_path character varying(500) NOT NULL,
    is_primary boolean DEFAULT false,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: photos_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.photos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: photos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.photos_id_seq OWNED BY public.photos.id;


--
-- Name: categories id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories ALTER COLUMN id SET DEFAULT nextval('public.categories_id_seq'::regclass);


--
-- Name: meals id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.meals ALTER COLUMN id SET DEFAULT nextval('public.meals_id_seq'::regclass);


--
-- Name: photos id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.photos ALTER COLUMN id SET DEFAULT nextval('public.photos_id_seq'::regclass);


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.categories (id, name) FROM stdin;
1	Oběd ostatní
2	Oběd
3	Salát
4	Snídaně
5	Steril. jídla
6	Minutka
7	Přílohy
8	Pizza
9	Polévka
10	Obaly
11	Bageta
\.


--
-- Data for Name: meals; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.meals (id, original_name, slug, allergens, name_en, category_id) FROM stdin;
540	250g Těstoviny penne s krevetami, sušenými rajčaty, kapary a olivami	250gtestovinypenneskrevetami,susenymirajcaty,kaparyaolivami	1a, 2, 3, 9, 10	\N	2
541	250g Těstoviny se smetanovou omáčkou z pečených paprik a rajčat sypané sýrem	250gtestovinysesmetanovouomackouzpecenychpaprikarajcatsypanesyrem	1a, 3, 7, 9	\N	2
542	250g Tortilla plněná trhanou vepřovou krkovicí a zeleninou, česnekový dresink, zeleninová ozdoba	250gtortillaplnenatrhanouveprovoukrkoviciazeleninou,cesnekovydresink,zeleninovaozdoba	1a, 7, 9	\N	2
348	150g Kuřecí prsa na bylinkách s hráškem a mrkví, bramborová kaše	150gkureciprsanabylinkachshraskemamrkvi,bramborovakase	1a, 7, 9	150g Kuřecí prsa na bylinkách s hráškem a mrkví, mashed Potatoes	2
456	150g Vepřový kebab z mletého masa na špejli se zeleninou, smažené hranolky, bylinkový dresink s česnekem	150gveprovykebabzmletehomasanaspejlisezeleninou,smazenehranolky,bylinkovydresinkscesnekem	1a, 3, 7, 9, 10	150g Minced Pork Kebab Skewer, french Fries (Fried Potato Chips), herb Dressing with Garlic	2
735	300g Tagliatelle s restovanými hříbky, smetanovým špenátem a strouhaným sýrem	300gtagliatellesrestovanymihribky,smetanovymspenatemastrouhanymsyrem	1a, 3, 7, 9	300g Tagliatelle with Fried Mushrooms, Creamy Spinach and Grated Cheese	2
1368	120g Kuřecí medailonky s hermelínem, sušenými rajčaty a bazalkou, dušená rýže	120gkurecimedailonkyshermelinem,susenymirajcatyabazalkou,dusenaryze	1a, 7, 9	120g Chicken Noisettes with Camembert Cheese, Dried Tomatoes and Basil, stewed Rice	1
41	120g Cheeseburger s hovězím masem, čedarem, goudou, okurkami a rajčatovým chutney, steakové hranolky	120gcheeseburgershovezimmasem,cedarem,goudou,okurkamiarajcatovymchutney,steakovehranolky	1a, 1b, 7, 9, 10, 12	\N	6
304	130g Pečený losos teriyaki se sezamem a medem, stir-fry zelenina pečené vaječné kari  nudle	130gpecenylososteriyakisesezamemamedem,stir-fryzeleninapecenevajecnekarinudle	1a, 3, 4, 5, 6, 7, 9, 10, 11	130g Roasted Teiyaki Salmon with Sesame and Honey Sauce, vegetable Stir-Fry and Egg Noodles	2
73	120g Grilovaná vepřová panenka s pepřovou omáčkou, steakové hranolky	120ggrilovanaveprovapanenkaspeprovouomackou,steakovehranolky	1a, 3, 5, 6, 7, 9, 10, 11, 12	\N	6
1376	120g Medailonky z vepřové panenky se zeleninou, zázvorem a sezamem, jasmínová rýže	120gmedailonkyzveprovepanenkysezeleninou,zazvoremasezamem,jasminovaryze	1a, 3, 5, 6, 7, 9, 10, 11	120g Pork Undercut Noisettes with Vegetables, Ginger and Sesame, jasmine Rice	2
1377	300g Tagliatelle s třísýrovou omáčkou z nivy, goudy a parmazánu se špenátovým pestem	300gtagliatellestrisyrovouomackouznivy,goudyaparmazanusespenatovympestem	1a, 3, 7, 9	300g Tagliatelle with Three-Cheese Sauce (Blue Cheese, Gouda & Parmesan) and Spinach Pesto	2
1378	130g Pečený candát s citronovou gremolatou, mačkaný hrášek se šalotkou a česnekem, opékané brambory	130gpecenycandatscitronovougremolatou,mackanyhraseksesalotkouacesnekem,opekanebrambory	1a, 4, 7	130g Roasted Pike Perch with Lemon Gremolata, crushed Potatoes with Shallot and Garlic, roast Potatoes	2
1379	120g Kuřecí směs s bazalkou, rajčaty a pečenou kápií, míchané luštěniny s česnekem, bez lepku	120gkurecismessbazalkou,rajcatyapecenoukapii,michanelusteninyscesnekem,bezlepku	9	120g Kuřecí směs s bazalkou, rajčaty a pečenou kápií, míchané luštěniny s česnekem, gluten Free	2
1380	200g Pita chléb s trhaným masem, čedarem a zeleninou, bramborové hranolky, pivní majonéza	200gpitachlebstrhanymmasem,cedaremazeleninou,bramborovehranolky,pivnimajoneza	1a, 1b, 3, 6, 7, 9, 10, 12	200g Pita chléb s trhaným masem, čedarem a zeleninou, potato French Fries, beer Mayonnaise	6
1381	100g Smažený camembert, bramborové hranolky, zeleninová obloha	100gsmazenycamembert,bramborovehranolky,zeleninovaobloha	1a, 3, 7	100g Fried Camembert Cheese, potato French Fries, vegetable Garnish	6
1382	250g Veganský Buddha Bowl s pečeným tofu	250gveganskybuddhabowlspecenymtofu	6, 11	250g Vegan Buddha Bowl with Roasted Tofu (Bean Curd)	6
241	120g Vepřová kapsa plněná modrým sýrem, bramborové hranolky	120gveprovakapsaplnenamodrymsyrem,bramborovehranolky	1a, 7, 9	\N	6
1385	240g Pečené kuřecí stehno po Asijsku, jasmínová rýže, trhaný salát	240gpecenekurecistehnopoasijsku,jasminovaryze,trhanysalat	1a, 3, 5, 7, 9, 10, 11	240g Pečené kuřecí stehno po Asijsku, jasmine Rice, shredded Lettuce	2
1386	300g Těstoviny s kuřecím masem a brokolicí ve smetanové omáčce sypané sýrem	300gtestovinyskurecimmasemabrokolicivesmetanoveomaccesypanesyrem	1a, 3, 7, 9	300g Pasta with Chicken Meat and Broccoli in Creamy Sauce Sprinkled with Cheese	2
135	120g Kuřecí medailonky s hermelínem, sušenými rajčaty a bazalkovým pestem, smetanové brambory	120gkurecimedailonkyshermelinem,susenymirajcatyabazalkovympestem,smetanovebrambory	1a, 7, 9	\N	2
115	120g Krůtí medailonky s anglickou slaninou, pórkem a sušenými rajčaty, jasmínová rýže	120gkrutimedailonkysanglickouslaninou,porkemasusenymirajcaty,jasminovaryze	1a, 7, 9	120g Turkey Noisettes with Bacon, Leek and Dried Tomatoes, jasmine Rice	2
270	130g Filety z tilápie nilské s jarní nádivkou, bylinkovým máslem, karotkové pyré	130gfiletyztilapienilskesjarninadivkou,bylinkovymmaslem,karotkovepyre	1a, 4, 7, 9	130g Nile Tilapia Fillet with Spring Stuffing, Herb Butter, carrot Purée	2
296	130g Pečené kuřecí nudličky se zeleninou a červenou čočkou, basmati rýže	130gpecenekurecinudlickysezeleninouacervenoucockou,basmatiryze	9	130g Roasted Chicken Bites with Vegetables and Red Lentils, basmati Rice	2
122	120g Krůtí stripsy v panko strouhance, bramborové hranolky, coleslaw s jablky	120gkrutistripsyvpankostrouhance,bramborovehranolky,coleslawsjablky	1a, 1b, 3, 5, 7, 9, 10, 11	120g Panko-Crusted Turkey Strips, potato French Fries, apple Coleslaw	6
1052	Obal na polévku	obalnapolevku		Obal na polévku	10
137	120g Kuřecí nudle WOK se zázvorem, zeleninou a teriyaki omáčkou, rýžové nudle	120gkurecinudlewoksezazvorem,zeleninouateriyakiomackou,ryzovenudle	1a, 1b, 3, 5, 6, 7, 9, 10, 11	120g Chicken WOK Noodles with Ginger, Vegetables and Teriyaki Sauce, rice Noodles	6
973	460g Pizza MILÁNO tomat, pizza šunka, balkán, rukola, rajče,mozzarella	460gpizzamilanotomat,pizzasunka,balkan,rukola,rajce,mozzarella	1a, 1b, 7	460g Pizza Pizza MILANO Tomato Purée, Pizza Ham, Brined Curd Cheese, Rocket Salad, Tomato, Edam Cheese	8
970	460g Pizza ANANASSO tomat, ananas, eidam, oregáno	460gpizzaananassotomat,ananas,eidam,oregano	1a, 1b, 7	460g Pizza ANANASSO Tomato Purée, Pineapple, Edam Cheese, Oregano	8
744	300g Těstovinový salát se zeleninou a kuřecími kousky, jogurtový dip	300gtestovinovysalatsezeleninouakurecimikousky,jogurtovydip	1a, 3, 5, 7, 9, 10, 11	300g Pasta Salad with Vegetables and Chicken Pieces, yogurt Dip	6
1397	Fazolová s uzeným masem a libečkem	fazolovasuzenymmasemalibeckem	1a, 9	Bean Soup with Smoked Meat and Lovage	9
27	100g Smažený kuřecí řízek, bramborový salát s majonézou	100gsmazenykurecirizek,bramborovysalatsmajonezou	1a, 3, 7, 9, 10	100g Fried Chicken Schnitzel, potato Salad with Mayonnaise	2
1211	250g Smažený květák, bramborová kaše	250gsmazenykvetak,bramborovakase	1a, 3	250g Fried Cauliflower, mashed Potatoes	2
643	300g Capresse salát s cherry rajčaty, mozzarelou a bazalkovým pestem, kuřecí kousky, opečený toast	300gcapressesalatscherryrajcaty,mozzarelouabazalkovympestem,kurecikousky,opecenytoast	1a, 3, 5, 7, 9, 10, 11	300g Caprese Salad with Cherry Tomatoes, Mozzarella and Basil Pesto, chicken Pieces, toast	2
167	120g Medailonky z vepřové panenky se smetanovou koňakovou omáčkou, vařené brambory	120gmedailonkyzveprovepanenkysesmetanovoukonakovouomackou,varenebrambory	1a, 3, 5, 7, 9, 10, 11	\N	1
168	120g Medové kuřecí kousky s pórkem a paprikou, dušená rýže, bez lepku	120gmedovekurecikouskysporkemapaprikou,dusenaryze,bezlepku	6, 9, 10	\N	2
1268	300g Těstovinový salát s francouzským dresinkem, kuřecí kousky	300gtestovinovysalatsfrancouzskymdresinkem,kurecikousky	1a, 3, 7, 9	300g Pasta Salad with French Dressing, Sliced Chicken Breast	2
1283	120g Smažené kuřecí goujons v kukuřičné krustě, opečené brambory, sweet chilli majonéza	120gsmazenekurecigoujonsvkukuricnekruste,opecenebrambory,sweetchillimajoneza	1a, 3, 6, 7, 9, 10	120g Fried Chicken Goujons in Cornflake Crust, roasted Potatoes, sweet Chilli Mayonnaise	6
841	390g Pizza QUATTRO FORMAGGI uzený sýr,mozzarella, niva, hermelín	390gpizzaquattroformaggiuzenysyr,mozzarella,niva,hermelin	1a, 1b, 4, 7, 9	390g Pizza QUATTRO FORMAGGI Smoked Cheese, Edam Cheese, Blue Cheese, Camembert	8
1364	300g Zeleninová směs s brokolicí, květákem, cuketou a pečenými rajčaty, jasmínová rýže	300gzeleninovasmessbrokolici,kvetakem,cuketouapecenymirajcaty,jasminovaryze	1a, 9, 10	300g Vegetable Medley with Broccoli, Cauliflower, Zucchini and Roasted Tomatoes, jasmine Rice	1
1	100g Camembert na grilu, opékané brambory a trhaný salát, tatarská omáčka	100gcamembertnagrilu,opekanebramboryatrhanysalat,tatarskaomacka	1a, 7, 9, 10	\N	6
2	100g Grilovaný camembert, trhaný salát, bylinkový dip	100ggrilovanycamembert,trhanysalat,bylinkovydip	1a, 1b, 3, 5, 7, 9, 10, 11	\N	6
4	100g Grilovaný camembert s brusinkovým dipem, bramborové hranolky	100ggrilovanycamembertsbrusinkovymdipem,bramborovehranolky	1, 3, 5, 7, 9, 10, 11, 12	\N	6
5	100g Grilovaný camembert s brusinkovým dipem, smažené hranolky	100ggrilovanycamembertsbrusinkovymdipem,smazenehranolky	3, 5, 9, 10, 11, 12	\N	6
762	300g Tvarohové knedlíky s meruňkovou náplní, skořicová drobenka, créme karamel	300gtvarohoveknedlikysmerunkovounaplni,skoricovadrobenka,cremekaramel	1a, 7	\N	2
13	100g Kuřecí prsa na paprice, vařené těstoviny - kolínka	100gkureciprsanapaprice,varenetestoviny-kolinka	1a, 3, 7, 9	\N	2
1209	Příloha balená	prilohabalena		Příloha balená	7
1157	Sterilovaná polévka ve skle 0,7l - Kyselice s uz.masem, Z restovaných paprik s rajčaty, Rozbaš hrachová  s masem a raj., Gulášová s vepř.masem	sterilovanapolevkaveskle0,7l-kyselicesuz.masem,zrestovanychpapriksrajcaty,rozbashrachovasmasemaraj.,gulasovasvepr.masem		Sterilovaná polévka ve skle 0,7l - Kyselice s uz.masem, Z restovaných paprik s rajčaty, Rozbaš hrachová  s masem a raj., Gulášová s vepř.masem	5
479	1 Sterilovaná hotovka ve skle 0,7l - Bramborový gulá	1sterilovanahotovkaveskle0,7l-bramborovygula		1 Sterilovaná hotovka ve skle 0,7l - Bramborový gulá	5
1399	300g Krémové rizoto z pečeného kuřete se zeleninou a strouhaným sýrem, jasmínová rýže	300gkremoverizotozpecenehokuretesezeleninouastrouhanymsyrem,jasminovaryze	7, 9	\N	2
14	100g Kuřecí směs se zeleninou, bramborové hranolky	100gkurecismessezeleninou,bramborovehranolky	1a, 9, 10	\N	6
15	100g Smažená mozzarella, bramborové hranolky	100gsmazenamozzarella,bramborovehranolky	1a, 3, 7	\N	6
16	100g Smažená mozzarella, bramborové hranolky, tatarská omáčka	100gsmazenamozzarella,bramborovehranolky,tatarskaomacka	1a, 3, 7, 9, 10	\N	6
17	100g Smažená mozzarella, opékané brambory, tatarská omáčka	100gsmazenamozzarella,opekanebrambory,tatarskaomacka	1a, 3, 7, 10	\N	6
18	100g Smažený camembert, bramborové hranolky	100gsmazenycamembert,bramborovehranolky	1a, 3, 7	\N	6
20	100g Smažený camembert, vařené brambory, tatarská omáčka	100gsmazenycamembert,varenebrambory,tatarskaomacka	1a, 3, 7, 9, 10	\N	2
21	100g Smažený celer, bramborový salát s vejci a majonézou	100gsmazenyceler,bramborovysalatsvejciamajonezou	1a, 3, 7, 9, 10	\N	6
22	100g Smažený celer, vařené brambory, tatarská omáčka	100gsmazenyceler,varenebrambory,tatarskaomacka	1a, 3, 7, 9	\N	6
23	100g Smažený hermelín, bramborové hranolky, brusinkový dip	100gsmazenyhermelin,bramborovehranolky,brusinkovydip	1a, 1b, 3, 7, 12	\N	6
30	100g Smažený sýr, smažené hranolky	100gsmazenysyr,smazenehranolky	1a, 1b, 3, 7	\N	2
31	100g Smažený sýr, smažené hranolky, česnekový dip	100gsmazenysyr,smazenehranolky,cesnekovydip	1a, 3, 7	\N	2
32	100g Smažený sýr, vařené brambory, tatarská omáčka	100gsmazenysyr,varenebrambory,tatarskaomacka	1a, 3, 7, 9, 10	\N	2
34	100g Smažený sýr se šunkou, bramborové hranolky	100gsmazenysyrsesunkou,bramborovehranolky	1a, 3, 7	\N	6
35	100g Tortilla plněná kuřecí směsí se zeleninou, trhaný salát, dresink	100gtortillaplnenakurecismesisezeleninou,trhanysalat,dresink	1a, 7, 9, 10	\N	6
36	100g Vepřová panenka, pepřová omáčka, smažené krokety	100gveprovapanenka,peprovaomacka,smazenekrokety	1a, 7, 9, 12	\N	6
37	100g Vepřová panenka v bramboráku, trhaný salát, dip z modrého sýra	100gveprovapanenkavbramboraku,trhanysalat,dipzmodrehosyra	1a, 3, 7, 9	\N	6
38	100g Vepřová panenka v bramboráku, trhaný salát, smetanový dip	100gveprovapanenkavbramboraku,trhanysalat,smetanovydip	1a, 3, 7, 9, 10	\N	6
47	120g Chow - mein z vepřové panenky s brokolicí, mrkví, žampiony  a sezamem, kari nudle	120gchow-meinzveprovepanenkysbrokolici,mrkvi,zampionyasezamem,karinudle	1a, 3, 5, 6, 7, 9, 10, 11	\N	2
29	100g Smažený sýr, bramborové hranolky, tatarská omáčka	100gsmazenysyr,bramborovehranolky,tatarskaomacka	1a, 1b, 3, 7, 9, 10	100g Fried Cheese, potato French Fries, Tartar Sauce	6
1007	Čočková s debrecínským párkem	cockovasdebrecinskymparkem	1a, 9	Lentil Soup with Spiced Sausage	9
1016	Francouzská s mušličkami	francouzskasmuslickami	1a, 3, 9	French Vegetable Soup	9
497	200g Smažený květák, vařené brambory, tatarská omáčka	200gsmazenykvetak,varenebrambory,tatarskaomacka	1, 3, 7, 10	200g Fried Cauliflower, boiled Potatoes, tartar Sauce	2
766	300g Veganské egyptské KOSHARI s cizrnou, čočkou, rajčatovou omáčkou a rýží	300gveganskeegyptskekoshariscizrnou,cockou,rajcatovouomackouaryzi	9	300g Vegan Egyptian KOSHARI with Chickpea, Lentils, Tomato Sauce and Rice	2
247	120g Vepřové nudličky na kari se zeleninou, jasmínová rýže	120gveprovenudlickynakarisezeleninou,jasminovaryze	1a, 6, 9	120g Pork Noodles in Curry Sauce with Vegetables, jasmine Rice	6
537	250g Smažený květák, vařené brambory, tatarská omáčka	250gsmazenykvetak,varenebrambory,tatarskaomacka	1a, 3, 7, 9, 10	250g Fried Cauliflower, boiled Potatoes, tartar Sauce	2
49	120g Ciabatta s grilovaným kuřecím masem, bramborové hranolky, dip z kysané smetany	120gciabattasgrilovanymkurecimmasem,bramborovehranolky,dipzkysanesmetany	1a, 7, 9	\N	6
50	120g Ciabatta s grilovaným kuřecím masem, smažené hranolky, pikantní dip	120gciabattasgrilovanymkurecimmasem,smazenehranolky,pikantnidip	1a, 3, 6, 7, 9, 10, 11, 12	\N	6
51	120g Ciabatta s grilovaným kuřecím masem a zeleninou, bramborové hranolky, pikantní dip	120gciabattasgrilovanymkurecimmasemazeleninou,bramborovehranolky,pikantnidip	1a, 3, 6, 7, 9, 10, 11, 12	\N	6
53	120g Ciabatta s trhaným vepřovým masem, chipotle majonéza, bramborové hranolky	120gciabattastrhanymveprovymmasem,chipotlemajoneza,bramborovehranolky	1a, 1b, 3, 6, 7, 9, 10, 12, 13	\N	6
54	120g Dančí kýta s divokým kořením, červené zelí s vínem a jablky, bramborový knedlík	120gdancikytasdivokymkorenim,cervenezelisvinemajablky,bramborovyknedlik	1a, 3, 9, 10, 12	\N	2
56	120g Džuveč z vepřového masa se zeleninou, sýr gouda, kyselý okurek	120gdzuveczveprovehomasasezeleninou,syrgouda,kyselyokurek	7, 9, 10	\N	2
1091	Sterilovaná polévka ve skle  0,7l -	sterilovanapolevkaveskle0,7l-		Sterilovaná polévka ve skle  0,7l -	5
466	1 Sterilovaná hotovka ve skle  -	1sterilovanahotovkaveskle-		1 Sterilovaná hotovka ve skle  -	5
1402	3 ks Fresh spring rolls s rýžovými nudlemi	3ksfreshspringrollssryzovyminudlemi	1a, 1b, 3, 6, 7, 9, 10	\N	6
1000	Brambory vařené, houskový knedlík	bramboryvarene,houskovyknedlik		Brambory vařené, houskový knedlík	7
1400	300g Těstoviny primavera se zeleninou, hráškem, karotkou, paprikou a brokolicí, gran biraghi sýr	300gtestovinyprimaverasezeleninou,hraskem,karotkou,paprikouabrokolici,granbiraghisyr	1a, 7, 9	300g Pasta primavera with vegetables, peas, carrots, peppers and broccoli, grand biraghi cheese, gran Biraghi Cheese	2
58	120g Filé ze pstruha s bylinkovou nádivkou, vinná omáčka, pečené grenaile	120gfilezepstruhasbylinkovounadivkou,vinnaomacka,pecenegrenaile	1a, 4, 7, 9, 12	\N	2
28	100g Smažený sýr, bramborové hranolky	100gsmazenysyr,bramborovehranolky	1a, 1b, 3, 7	100g Fried Cheese, potato French Fries	6
43	120g Chilli con-carne z kuřecího masa s fazolemi a zeleninou, dušená rýže	120gchillicon-carnezkurecihomasasfazolemiazeleninou,dusenaryze	1a, 3, 7, 9	120g Chicken Meat in Spicy Sauce with Beans and Vegetables, stewed Rice	1
33	100g Smažený sýrový špíz, bramborové hranolky, tatarská omáčka	100gsmazenysyrovyspiz,bramborovehranolky,tatarskaomacka	1a, 3, 7, 10	100g Fried Cheese Skewer, potato French Fries, tartar Sauce	6
52	120g Ciabatta s grilovaným kuřecím masem a zeleninou, smažené hranolky, pikantní dip	120gciabattasgrilovanymkurecimmasemazeleninou,smazenehranolky,pikantnidip	1a, 3, 6, 7, 9, 10, 11, 12	120g Ciabatta with Grilled Chicken Meat and Vegetables, french Fries (Fried Potato Chips), spicy Dip	6
62	120g Grilovaná marinovaná vepřová kotleta, basmati rýže	120ggrilovanamarinovanaveprovakotleta,basmatiryze	1a, 9, 10	\N	1
63	120g Grilovaná marinovaná vepřová kotleta, dušená rýže	120ggrilovanamarinovanaveprovakotleta,dusenaryze	1a, 1b, 9, 10	\N	1
64	120g Grilovaná marinovaná vepřová kotleta, pečené grenaile	120ggrilovanamarinovanaveprovakotleta,pecenegrenaile	1a, 9, 10	\N	2
65	120g Grilovaná marinovaná vepřová kotleta, pepřová omáčka, dušená rýže	120ggrilovanamarinovanaveprovakotleta,peprovaomacka,dusenaryze	1a, 1b, 7, 9, 10, 12	\N	2
66	120g Grilovaná vepřová panenka, bramborové hranolky, bylinkový dip	120ggrilovanaveprovapanenka,bramborovehranolky,bylinkovydip	1a, 1b, 3, 5, 7, 9, 10, 11	\N	6
68	120g Grilovaná vepřová panenka, pečená zelenina, bramborové hranolky, sýrový dip	120ggrilovanaveprovapanenka,pecenazelenina,bramborovehranolky,syrovydip	1a, 1b, 3, 5, 7, 9, 10, 11	\N	6
69	120g Grilovaná vepřová panenka, pepřová omáčka, opékané brambory	120ggrilovanaveprovapanenka,peprovaomacka,opekanebrambory	1a, 1b, 3, 5, 7, 9, 10, 11, 12	\N	6
835	360g Pizza LUCIA tomat, klobása, feferonky, niva,mozzarella	360gpizzaluciatomat,klobasa,feferonky,niva,mozzarella	1a, 1b, 7, 10	\N	8
71	120g Grilovaná vepřová panenka s pepřovou omáčkou, americké brambory	120ggrilovanaveprovapanenkaspeprovouomackou,americkebrambory	1a, 3, 5, 7, 9, 10, 11, 12	\N	6
67	120g Grilovaná vepřová panenka, bramborové hranolky, smetanový dip z modrého sýra	120ggrilovanaveprovapanenka,bramborovehranolky,smetanovydipzmodrehosyra	1a, 1b, 7, 9, 10	120g Grilled Pork Undercut, potato French Fries, blue Cheese Creamy Dip	6
57	120g Džuveč z vepřového masa se zeleninou, sýr gouda, sterilovaný okurek	120gdzuveczveprovehomasasezeleninou,syrgouda,sterilovanyokurek	7, 9, 10	120g Stewed Pork Meat with Vegetables, Gouda Cheese, gherkin	2
1728	3 Sterilovaná hotovka ve skle  - Hovězí guláš,Hovězí pečeně s rajskou om.	3sterilovanahotovkaveskle-hovezigulas,hovezipecenesrajskouom.		3 Sterilovaná hotovka ve skle  - Hovězí guláš,Hovězí pečeně s rajskou om.	5
1729	2 Sterilovaná hotovka ve skle  - Krkovice se steakovou omáčkou, Boloňská směs, Rajská omáčka	2sterilovanahotovkaveskle-krkovicesesteakovouomackou,bolonskasmes,rajskaomacka		2 Sterilovaná hotovka ve skle  - Krkovice se steakovou omáčkou, Boloňská směs, Rajská omáčka	5
59	120g Frankfurtská sekaná pečeně, houskový knedlík	120gfrankfurtskasekanapecene,houskovyknedlik	1a, 3, 7, 9	120g Roasted Minced Meat with Ground Paprika and Sausage, bread Dumplings	2
61	120g Gratinované brambory s kuřecím masem a hermelínem	120ggratinovanebramboryskurecimmasemahermelinem	1a, 7	120g Scalloped  Potatoes with Chicken Meat and Camembert Cheese	6
1374	130g Filet ze pstruha s bylinkovou nádivkou, vinná omáčka, opékané brambory	130gfiletzepstruhasbylinkovounadivkou,vinnaomacka,opekanebrambory	1a, 4, 7, 9, 12	130g Trout Fillet with Herb Stuffing, wine Sauce, roast Potatoes	2
1070	Rýže	ryze		Rýže	7
1212	Sterilovaná polévka ve skle 0,7l - Vývar, Z pečených paprik, Kapustová, Kyselice s uz.masem, Z restovaných paprik s rajčaty, Rozbaš hrachová  s masem a raj., Gulášová s vepř.masem	sterilovanapolevkaveskle0,7l-vyvar,zpecenychpaprik,kapustova,kyselicesuz.masem,zrestovanychpapriksrajcaty,rozbashrachovasmasemaraj.,gulasovasvepr.masem		Sterilovaná polévka ve skle 0,7l - Vývar, Z pečených paprik, Kapustová, Kyselice s uz.masem, Z restovaných paprik s rajčaty, Rozbaš hrachová  s masem a raj., Gulášová s vepř.masem	5
1213	2 Sterilovaná hotovka ve skle 0,7l - Kuřecí just, Boloňská vepř. směs, Moravský vrabec, zelí	2sterilovanahotovkaveskle0,7l-kurecijust,bolonskavepr.smes,moravskyvrabec,zeli		2 Sterilovaná hotovka ve skle 0,7l - Kuřecí just, Boloňská vepř. směs, Moravský vrabec, zelí	5
1214	3 Sterilovaná hotovka ve skle 0,7l - Hov. svíčková omáčka, Medailónky z vepř panenky, Hovězí guláš,  Krůtí medailonky,  Hov.Stroganoff	3sterilovanahotovkaveskle0,7l-hov.svickovaomacka,medailonkyzveprpanenky,hovezigulas,krutimedailonky,hov.stroganoff		3 Sterilovaná hotovka ve skle 0,7l - Hov. svíčková omáčka, Medailónky z vepř panenky, Hovězí guláš,  Krůtí medailonky,  Hov.Stroganoff	5
1396	300g Cizrnové kari s rajčaty, cuketou a jogurtem, basmati rýže	300gcizrnovekarisrajcaty,cuketouajogurtem,basmatiryze		300g Chickpea Curry with Tomatoes, Courgette and Yoghurt, basmati Rice	2
1071	Salát kaki s feta sýrem	salatkakisfetasyrem		\N	3
538	250g Špagety po boloňsku s vepřovým masem a sýrem gran biraghi	250gspagetypobolonskusveprovymmasemasyremgranbiraghi		\N	2
533	250g Pita s kuřecím gyrosem, zelným salátem a ranchero dresinkem, bramborové hranolky	250gpitaskurecimgyrosem,zelnymsalatemarancherodresinkem,bramborovehranolky	1a, 1b, 3, 7, 9, 10	250g Pita with Chicken Gyros, Cabbage Salad and Ranchero Dressing, potato French Fries	6
102	120g Hovězí nudličky po znojemsku s okurkami a slaninou, dušená rýže	120ghovezinudlickypoznojemskusokurkamiaslaninou,dusenaryze	1a, 9, 10	\N	2
527	250g Hrachová kaše, sázené vejce, opečená klobása, kmínový chléb, sterilovaný okurek	250ghrachovakase,sazenevejce,opecenaklobasa,kminovychleb,sterilovanyokurek	1a, 3, 9, 10	\N	2
528	250g Konfitované kachní stehno, červené zelí s vínem a jablky, bramborový knedlík	250gkonfitovanekachnistehno,cervenezelisvinemajablky,bramborovyknedlik	1a, 1b, 3, 9, 10, 12	\N	2
529	250g Lívance se šlehaným tvarohem a malinovým coulis, čerstvé ovoce	250glivanceseslehanymtvarohemamalinovymcoulis,cerstveovoce	1a, 6, 7	\N	2
530	250g Mexické fazole, sázené vejce, opečená klobása, kmínový chléb	250gmexickefazole,sazenevejce,opecenaklobasa,kminovychleb	1a, 3, 9	\N	2
531	250g Pečené kuřecí paličky, kari coleslaw, pečené grenaile	250gpecenekurecipalicky,karicoleslaw,pecenegrenaile	1, 3, 5, 7, 9, 10, 11	\N	2
532	250g Pečené uzené koleno, teplý zelný salát s anglickou slaninou a křenem, bramborový knedlík	250gpeceneuzenekoleno,teplyzelnysalatsanglickouslaninouakrenem,bramborovyknedlik	1a, 3, 9, 10	\N	2
534	250g Pšeničná tortilla plněná zeleninou a kuřecím masem, česnekový dip	250gpsenicnatortillaplnenazeleninouakurecimmasem,cesnekovydip	1a, 3, 7	\N	2
535	250g Salát Tabbouleh s bulgurem a kuřecími plátky	250gsalattabboulehsbulguremakurecimiplatky	1a, 3, 9	\N	2
539	250g Špagety s krevetami, sušenými rajčaty a olivami sypané sýrem gran biraghi	250gspagetyskrevetami,susenymirajcatyaolivamisypanesyremgranbiraghi	1a, 2, 3, 5, 6, 9, 10, 11	\N	2
1404	300g Krémové rizoto z pečeného kuřete se zeleninou a strouhaným sýrem	300gkremoverizotozpecenehokuretesezeleninouastrouhanymsyrem	7, 9	300g Creamy Risotto with Roasted Chicken, Vegetables and Grated Cheese	2
1405	150g Kuřecí prsa na grilu s pečenou mrkví, bramborové hranolky	150gkureciprsanagriluspecenoumrkvi,bramborovehranolky		150g Grilled Chicken Breast with Roasted Carrots, potato French Fries	6
1406	50g Těstovinový salát s krabím masem, zeleninou, dip z kysané smetany	50gtestovinovysalatskrabimmasem,zeleninou,dipzkysanesmetany		50g Pasta Salad with Crab Meat and Vegetables, sour Cream Dip	6
1730	150g Chilli con carne z hovězího masa s kukuřicí, rajčaty a fazolemi, dušená rýže	150gchilliconcarnezhovezihomasaskukurici,rajcatyafazolemi,dusenaryze	1a, 1b, 3, 7, 9	150g Beef  in Spicy Sauce with Maize, Tomatoes and Beans , stewed Rice	2
1731	120g Mozaiková sekaná se šunkou, sýrem a zeleninou, bramborová kaše, sterilovaný okurek	120gmozaikovasekanasesunkou,syremazeleninou,bramborovakase,sterilovanyokurek	1a, 3, 7, 9, 10	120g Minced Meat with Ham, Cheese and Vegetables, mashed Potatoes, gherkin	1
1732	130g Pečený filet z tresky s fazolkami na medu a hrubozrnné hořčici, karotkové pyré, grenaille brambory	130gpecenyfiletztreskysfazolkaminameduahrubozrnnehorcici,karotkovepyre,grenaillebrambory	1a, 4, 5, 6, 7, 9, 10, 11, 12	130g Baked Cod Fillet with Green Beans in Honey and Wholegrain Mustard, carrot Purée, grenaille Potatoes	1
1733	3 Sterilovaná hotovka ve skle  - Rajská s hov.masem, Chow -main z vepř.panenky, Znojemské nudličky, Chilli con carne, Kuř.medailonky s liškovou omáčkou	3sterilovanahotovkaveskle-rajskashov.masem,chow-mainzvepr.panenky,znojemskenudlicky,chilliconcarne,kur.medailonkysliskovouomackou		3 Sterilovaná hotovka ve skle  - Rajská s hov.masem, Chow -main z vepř.panenky, Znojemské nudličky, Chilli con carne, Kuř.medailonky s liškovou omáčkou	5
997	Boršč s kysanou smetanou	borscskysanousmetanou	1a, 7, 9	Borscht with Soured Cream	9
158	120g Kuřecí stir-fry se zeleninou, zázvorem, jasmínová rýže	120gkurecistir-frysezeleninou,zazvorem,jasminovaryze	1a, 3, 5, 6, 7, 9, 10, 11	120g Chicken Stir-Fry with Vegetables, Ginger, jasmine Rice	2
644	300g Cassoulet s fazolemi, pečenou mrkví, baby špenátem, rýžový pilaf, bez lepku	300gcassouletsfazolemi,pecenoumrkvi,babyspenatem,ryzovypilaf,bezlepku	9, 10	300g Cassoulet with Beans, Roasted Carrots and Baby Spinach, rice Pilaf, gluten Free	2
969	460g Pizza AL CAPONE tomat, šunka, feferonky-ber.rohy, z.olivy, mozzarella	460gpizzaalcaponetomat,sunka,feferonky-ber.rohy,z.olivy,mozzarella	1a, 1b, 7, 10	460g Pizza AL CAPONE Tomato Purée, Ham, Hot Pepper, Green Olives, Mozzarella	8
1215	250g Smažený květák, smažené hranolky	250gsmazenykvetak,smazenehranolky	1a, 3	250g Fried Cauliflower, french Fries (Fried Potato Chips)	2
1375	Polévka z restovaných paprik se smetanou	polevkazrestovanychpapriksesmetanou	1a, 7, 9	Soup with Fried Peppers and Cream	9
1383	Žampionový krém s krutony	zampionovykremskrutony	1a, 7, 9	Champignon Cream with Croutons	9
74	120g Grilované krůtí kousky, trhaný salát, medovo - hořčicový dip, bramborové hranolky	120ggrilovanekrutikousky,trhanysalat,medovo-horcicovydip,bramborovehranolky	1a, 1b, 3, 5, 7, 9, 10, 11	\N	6
75	120g Grilované krůtí kousky s anglickou slaninou, pepřová omáčka, bramborové hranolky	120ggrilovanekrutikouskysanglickouslaninou,peprovaomacka,bramborovehranolky	1a, 1b, 7, 9, 10, 12	\N	6
76	120g Grilované kuřecí kousky, bramborové hranolky, steaková omáčka	120ggrilovanekurecikousky,bramborovehranolky,steakovaomacka	1a, 1b, 3, 5, 7, 9, 10, 11	\N	6
78	120g Grilované kuřecí kousky, bramborové hranolky, tatarská omáčka	120ggrilovanekurecikousky,bramborovehranolky,tatarskaomacka	1a, 1b, 3, 5, 7, 9, 10, 11	\N	6
1202	Sterilovaná polévka ve skle  0,7l - Gulášová,Dýňová,Valašská kyselice,Z restovaných paprik,Telecí vývar,Jemná pepřová omáčka	sterilovanapolevkaveskle0,7l-gulasova,dynova,valasskakyselice,zrestovanychpaprik,telecivyvar,jemnapeprovaomacka		Sterilovaná polévka ve skle  0,7l - Gulášová,Dýňová,Valašská kyselice,Z restovaných paprik,Telecí vývar,Jemná pepřová omáčka	5
1035	Kimchi - kvašená zelenina 170g	kimchi-kvasenazelenina170g		Kimchi - kvašená zelenina 170g	5
477	1 Sterilovaná hotovka ve skle  - Veganský DHAL ze žlutého hrachu,Bramborový guláš	1sterilovanahotovkaveskle-veganskydhalzezlutehohrachu,bramborovygulas		1 Sterilovaná hotovka ve skle  - Veganský DHAL ze žlutého hrachu,Bramborový guláš	5
1203	2 Sterilovaná hotovka ve skle  - Vepřový vrabec,Kuřecí kousky,Boloňská směs,Frankfurtská pečeně	2sterilovanahotovkaveskle-veprovyvrabec,kurecikousky,bolonskasmes,frankfurtskapecene		2 Sterilovaná hotovka ve skle  - Vepřový vrabec,Kuřecí kousky,Boloňská směs,Frankfurtská pečeně	5
856	3 Sterilovaná hotovka ve skle  - Hovězí guláš,Vepřové medailonky se steakovou om.,Hovězí svíčková,Hovězí stroganoff,Chow-Mein z vepřové panenky,Krůtí medailonky	3sterilovanahotovkaveskle-hovezigulas,veprovemedailonkysesteakovouom.,hovezisvickova,hovezistroganoff,chow-meinzveprovepanenky,krutimedailonky		3 Sterilovaná hotovka ve skle  - Hovězí guláš,Vepřové medailonky se steakovou om.,Hovězí svíčková,Hovězí stroganoff,Chow-Mein z vepřové panenky,Krůtí medailonky	5
1051	Obal na jídlo	obalnajidlo		Obal na jídlo	10
1204	Sterilovaná polévka ve skle 0,7l - Dýňová,Kapustová,Z restovaných paprik	sterilovanapolevkaveskle0,7l-dynova,kapustova,zrestovanychpaprik		Sterilovaná polévka ve skle 0,7l - Dýňová,Kapustová,Z restovaných paprik	5
468	1 Sterilovaná hotovka ve skle  - Bio hovězí vývar	1sterilovanahotovkaveskle-biohovezivyvar		1 Sterilovaná hotovka ve skle  -BIO hovězí vývar	5
1407	120g Smažené kuřecí kousky marinované v jogurtu, opékané brambory, smetanový dip	120gsmazenekurecikouskymarinovanevjogurtu,opekanebrambory,smetanovydip	1a, 3, 6, 7, 10	120g Fried Chicken Pieces Marinated in Yogurt, roasted Potatoes, creamy Dip	6
79	120g Grilované kuřecí kousky, omáčka z modrého sýra, smažené hranolky	120ggrilovanekurecikousky,omackazmodrehosyra,smazenehranolky	1a, 7, 10	\N	6
80	120g Grilované kuřecí kousky, pepřová omáčka, bramborové hranolky	120ggrilovanekurecikousky,peprovaomacka,bramborovehranolky	1a, 1b, 3, 5, 7, 9, 10, 11, 12	\N	6
82	120g Grilované kuřecí kousky na medu se slunečnicovými semínky, smažené hranolky, zeleninová ozdoba	120ggrilovanekurecikouskynameduseslunecnicovymiseminky,smazenehranolky,zeleninovaozdoba	1a, 3, 5, 7, 9, 10, 11	\N	6
83	120g Grilované medailonky z vepřové panenky, pečená zelenina, bramborové hranolky, sýrový dip	120ggrilovanemedailonkyzveprovepanenky,pecenazelenina,bramborovehranolky,syrovydip	1a, 1b, 3, 5, 7, 9, 10, 11	\N	6
84	120g Grilované pikantní medailonky z vepřové panenky, smetanová bylinková omáčka, bramborové hranolky	120ggrilovanepikantnimedailonkyzveprovepanenky,smetanovabylinkovaomacka,bramborovehranolky	1a, 1b, 3, 5, 7, 9, 10, 11	\N	6
85	120g Grilovaný camembert v anglické slanině, vařené brambory, brusinkový dip,trhaný salát	120ggrilovanycamembertvanglickeslanine,varenebrambory,brusinkovydip,trhanysalat	1, 3, 5, 7, 9, 10, 11	\N	2
1408	200g Kuřecí steak na grilu, steakové hranolky, steaková omáčka	200gkurecisteaknagrilu,steakovehranolky,steakovaomacka	1, 7, 9, 10, 11	200g Grilled Chicken Steak, french Fries in Steak Seasoning, steak Sauce	6
81	120g Grilované kuřecí kousky na medu se slunečnicovými semínky, smažené hranolky, zeleninová obloha	120ggrilovanekurecikouskynameduseslunecnicovymiseminky,smazenehranolky,zeleninovaobloha	1, 3, 5, 7, 9, 10, 11	120g Grilled Chicken Pieces in Honey with Sunflower Seeds, french Fries (Fried Potato Chips), vegetable Garnish	6
1734	120g Mozaiková sekaná se šunkou a sýrem, vařené brambory, sterilovaný okurek	120gmozaikovasekanasesunkouasyrem,varenebrambory,sterilovanyokurek	1a, 3, 6, 7, 9, 10	120g Minced Meat with Ham and Cheese , boiled Potatoes, gherkin	1
1205	120g Zapečené kuřecí prso s peperonátou a smetanou, šťouchané brambory	120gzapecenekureciprsospeperonatouasmetanou,stouchanebrambory	1, 3, 5, 7, 9, 10, 11	120g Scalloped Chicken Breast with Peperonata and Cream, mashed Potatoes	2
432	150g Sojové kung-pao se zeleninou a zázvorem, jasmínová rýže	150gsojovekung-paosezeleninouazazvorem,jasminovaryze	1, 3, 5, 6, 7, 9, 10, 11	150g Spicy Soya Noodles, Sauce, Vegetables and Ginger, jasmine Rice	2
228	120g Smetanové krůtí ragú se slaninou, pórkem a sušenými rajčaty, jasmínová rýže	120gsmetanovekrutiraguseslaninou,porkemasusenymirajcaty,jasminovaryze	1a, 7, 9, 10, 12	120g Cream Turkey Ragout with Bacon, Leek and Dried Tomatoes, jasmine Rice	2
1206	130g Filet z tilápie smažený v panko strouhance, šťouchané brambory, tatarská omáčka	130gfiletztilapiesmazenyvpankostrouhance,stouchanebrambory,tatarskaomacka	1a, 3, 4, 5, 6, 7, 9, 10	130g Fried Panko-Crusted Tilapia Fillet, mashed Potatoes, tartar Sauce	1
667	300g Gratinované gnochi s kuřecím masem, špenátem, smetanou a parmazánem	300ggratinovanegnochiskurecimmasem,spenatem,smetanouaparmazanem	1a, 1b, 3, 7, 9	300g Scalloped Gnocchi with Chicken Meat, Spinach, Cream and Parmesan Cheese	6
207	120g Smažené kuřecí goujons v kukuřičné krustě, zeleninový salát se slunečnicovými semínky, jogurtový dip	120gsmazenekurecigoujonsvkukuricnekruste,zeleninovysalatseslunecnicovymiseminky,jogurtovydip	1, 3, 7, 9	120g Fried Chicken Goujons in Cornflake Crust, vegetable Salad with Sunflower Seeds, yogurt Dip	6
1207	120g Kuřecí kapsa plněná sušenými rajčaty a mozzarelou, bramborové hranolky	120gkurecikapsaplnenasusenymirajcatyamozzarelou,bramborovehranolky	1a, 7, 9, 10	120g Chicken Roll Stuffed with Dried Tomatoes and Mozzarella, potato French Fries	6
86	120g Grilovaný kuřecí gyros v brioche bulce, zelný salát, bylinkový dip	120ggrilovanykurecigyrosvbriochebulce,zelnysalat,bylinkovydip	1a, 7, 9, 10	\N	6
91	120g Hamburger s trhaným vepřovým masem, trhaný salát, bramborové hranolky	120ghamburgerstrhanymveprovymmasem,trhanysalat,bramborovehranolky	1a, 1b, 3, 6, 7, 9, 10, 12	\N	6
92	120g Hamburger s trhaným vepřovým masem a čedarem, bramborové hranolky, pepřový dip	120ghamburgerstrhanymveprovymmasemacedarem,bramborovehranolky,peprovydip	1a, 1b, 7, 9, 10, 12	\N	6
93	120g Hamburger s trhaným vepřovým masem a čedarem, bramborové hranolky, pikantní dip	120ghamburgerstrhanymveprovymmasemacedarem,bramborovehranolky,pikantnidip	1a, 7, 9, 10	\N	6
580	2 Sterilovaná hotovka ve skle  - Masové kuličky s rajskou omáčkou,Segedínský guláš,Kuřecí směs,Vepřový vrabec se zelím,Vepřová boloňská směs,Kuřecí kousky,Kuřecí na paprice	2sterilovanahotovkaveskle-masovekulickysrajskouomackou,segedinskygulas,kurecismes,veprovyvrabecsezelim,veprovabolonskasmes,kurecikousky,kurecinapaprice		2 Sterilovaná hotovka ve skle  -Masové kuličky s rajskou omáčkou,Segedínský guláš,Kuřecí směs,Vepřový vrabec se zelím,Vepřová boloňská směs,Kuřecí kousky,Kuřecí na paprice	5
884	3 Sterilovaná hotovka ve skle  -Hovězí stroganoff,Chow-mein z vepřové panenky,Hovězí pečeně s koprovou omáčkou,Hovězí po burgundsku,Krůtí ragů,Vepřová panenka se steakovou omáčkou	3sterilovanahotovkaveskle-hovezistroganoff,chow-meinzveprovepanenky,hovezipeceneskoprovouomackou,hovezipoburgundsku,krutiragu,veprovapanenkasesteakovouomackou		3 Sterilovaná hotovka ve skle  -Hovězí stroganoff,Chow-mein z vepřové panenky,Hovězí pečeně s koprovou omáčkou,Hovězí po burgundsku,Krůtí ragů,Vepřová panenka se steakovou omáčkou	5
1208	Sterilovaná polévka ve skle 0,7l - Kyselice, Dýňová	sterilovanapolevkaveskle0,7l-kyselice,dynova		Sterilovaná polévka ve skle 0,7l - Kyselice, Dýňová	5
97	120g Hovězí hamburger se sýrem, cibulová marmeláda, bramborové hranolky	120ghovezihamburgersesyrem,cibulovamarmelada,bramborovehranolky	1a, 1b, 7, 9, 10, 12	\N	6
98	120g Hovězí hamburger se sýrem a slaninou, smažené hranolky, pivní majonéza	120ghovezihamburgersesyremaslaninou,smazenehranolky,pivnimajoneza	3, 6, 7, 9, 10, 12	\N	6
99	120g Hovězí kostky na víně a kořenové zelenině, bramborové pyré	120ghovezikostkynavineakorenovezelenine,bramborovepyre	1a, 7, 9, 12	\N	2
100	120g Hovězí nudličky po znojemsku, dušená rýže	120ghovezinudlickypoznojemsku,dusenaryze	1a, 9, 10	\N	1
1439	120g Zapečené kuřecí prso se šunkou a sýrem, přírodní šťáva, jasmínová rýže	120gzapecenekureciprsosesunkouasyrem,prirodnistava,jasminovaryze	1a, 3, 5, 7, 9, 10, 11	120g Scalloped Chicken Breast with Ham and Cheese, přírodní šťáva, jasmínová rýže	2
1440	300g Bramborový guláš s klobásou a kápií, kmínový chléb	300gbramborovygulassklobasouakapii,kminovychleb	1a, 9, 10	300g Potato Goulash with Sausage and Sweet Capsicum, caraway Seed Bread	2
1441	300g Citrusový salát s mangem, pak choi, křupavými krevetami a teriyaki mayo	300gcitrusovysalatsmangem,pakchoi,krupavymikrevetamiateriyakimayo	1a, 1b, 2, 3, 6, 7, 9	300g Citrusový salát s mangem, pak choi, křupavými krevetami a teriyaki mayo	6
89	120g Hamburger s trhaným kuřecím masem, smažené hranolky, pikantní dip	120ghamburgerstrhanymkurecimmasem,smazenehranolky,pikantnidip	1a, 3, 5, 7, 9, 10, 11	120g Hamburger with Pulled Chicken Meat, french Fries (Fried Potato Chips), spicy Dip	6
87	120g Grilovaný kuřecí steak, restovaná zelenina, omáčka z modrého sýra, bramborové hranolky	120ggrilovanykurecisteak,restovanazelenina,omackazmodrehosyra,bramborovehranolky	1a, 1b, 7, 9	120g Grilled Chicken Steak, Roasted Vegetables, Blue Cheese Sauce, potato French Fries	6
1058	Pečený filet ze pstruha s mandlemi a bylinkovou omáčkou, opékané rozmarýnové grenaille	pecenyfiletzepstruhasmandlemiabylinkovouomackou,opekanerozmarynovegrenaille	1a, 4, 7, 8, 8a, 9, 10	Baked Trout Fillet with Almonds and Herb Sauce, pan-fried Rosemary Grenaille Potatoes	2
1210	150g Zapečený kuřecí steak s anglickou slaninou a mozzarellou , vařené brambory	150gzapecenykurecisteaksanglickouslaninouamozzarellou,varenebrambory	1a, 7, 9	150g Scalloped Chicken Steak with Bacon and Mozzarella, boiled Potatoes	1
208	120g Smažené kuřecí kousky marinované v jogurtu, opečené brambory, sweet chilli majonéza	120gsmazenekurecikouskymarinovanevjogurtu,opecenebrambory,sweetchillimajoneza	1a, 3, 6, 7, 10	120g Fried Chicken Pieces Marinated in Yogurt, roasted Potatoes, sweet Chilli Mayonnaise	6
605	2 Sterilovaná hotovka ve skle  - Vrabec se zelím	2sterilovanahotovkaveskle-vrabecsezelim		2 Sterilovaná hotovka ve skle  - Vrabec se zelím	5
891	3 Sterilovaná hotovka ve skle  -Krůtí ragů	3sterilovanahotovkaveskle-krutiragu		3 Sterilovaná hotovka ve skle  - Krůtí ragú	5
615	2 Sterilovaná hotovka ve skle 0,7l - Boloňská vepř. směs, Moravský vrabec, zelí	2sterilovanahotovkaveskle0,7l-bolonskavepr.smes,moravskyvrabec,zeli		2 Sterilovaná hotovka ve skle 0,7l - Boloňská vepř. směs, Moravský vrabec, zelí	5
937	3 Sterilovaná hotovka ve skle 0,7l - Hovězí guláš,  Krůtí medailonky,  Hov.stroganoff	3sterilovanahotovkaveskle0,7l-hovezigulas,krutimedailonky,hov.stroganoff		3 Sterilovaná hotovka ve skle 0,7l - Hovězí guláš,  Krůtí medailonky,  Hov.stroganoff	5
1111	Sterilovaná polévka ve skle  0,7l - Gulášová, Bramboračka, Rajská z pečených paprik	sterilovanapolevkaveskle0,7l-gulasova,bramboracka,rajskazpecenychpaprik		Sterilovaná polévka ve skle  0,7l - Gulášová, Bramboračka, Rajská z pečených paprik	5
563	2 Sterilovaná hotovka ve skle  - Boloňská vepřová směs, Vepř.vrabec se zelím, Rajská s kuličkami	2sterilovanahotovkaveskle-bolonskaveprovasmes,vepr.vrabecsezelim,rajskaskulickami		2 Sterilovaná hotovka ve skle  - Boloňská vepřová směs, Vepř.vrabec se zelím, Rajská s kuličkami	5
851	3 Sterilovaná hotovka ve skle  - Hovězí guláš, Kuřecí chilli, Medailonky z vepř.panenky se steak.om. , Boloňská hovězí, Hov.po burgundsku, Znojemské nudličky, Svíčková om.	3sterilovanahotovkaveskle-hovezigulas,kurecichilli,medailonkyzvepr.panenkysesteak.om.,bolonskahovezi,hov.poburgundsku,znojemskenudlicky,svickovaom.		3 Sterilovaná hotovka ve skle  - Hovězí guláš, Kuřecí chilli, Medailonky z vepř.panenky se steak.om. , Boloňská hovězí, Hov.po burgundsku, Znojemské nudličky, Svíčková om.	5
1410	120g Kuřecí směs s bazalkou, rajčaty a pečenou kápií, dušená rýže	120gkurecismessbazalkou,rajcatyapecenoukapii,dusenaryze	9	120g Chicken Mix with Basil, Tomatoes and Roasted Red Peppers, stewed Rice	1
1442	Ragú z francouzské čočky se zeleninou a bylinkami, bramborové gnocchi	raguzfrancouzskecockysezeleninouabylinkami,bramborovegnocchi	1a, 7	French Lentil Ragout with Vegetables and Herbs, potato Gnocchi	2
1443	Sterilovaná polévka ve skle 0,7l - Kyselice s čabajkou, Z restovaných paprik, Kuřecí krémová, Brokolicový krém, Cibulačka, Hov.vývar s byl.noky, Borsč, Gulášová s vep.masem, Rozbaš- hrachová  s masem a raj.	sterilovanapolevkaveskle0,7l-kyselicescabajkou,zrestovanychpaprik,kurecikremova,brokolicovykrem,cibulacka,hov.vyvarsbyl.noky,borsc,gulasovasvep.masem,rozbas-hrachovasmasemaraj.		Sterilovaná polévka ve skle 0,7l - Kyselice s čabajkou, Z restovaných paprik, Kuřecí krémová, Brokolicový krém, Cibulačka, Hov.vývar s byl.noky, Borsč, Gulášová s vep.masem, Rozbaš- hrachová  s masem a raj.	5
1369	Sterilovaná polévka ve skle  0,7l - Valašská kyselice, Bramboračka, Gulášová	sterilovanapolevkaveskle0,7l-valasskakyselice,bramboracka,gulasova		Sterilovaná polévka ve skle  0,7l - Valašská kyselice, Bramboračka, Gulášová	5
1370	1 Sterilovaná hotovka ve skle  - Bramborové kari Aloo-bhaji	1sterilovanahotovkaveskle-bramborovekarialoo-bhaji		1 Sterilovaná hotovka ve skle  - Bramborové kari Aloo-bhaji	5
1371	2 Sterilovaná hotovka ve skle  - Rajská s kuličkami, Frankfurtská pečeně, Boloňská směs, Kuřecí kousky na zeleném pepři	2sterilovanahotovkaveskle-rajskaskulickami,frankfurtskapecene,bolonskasmes,kurecikouskynazelenempepri		2 Sterilovaná hotovka ve skle  - Rajská s kuličkami, Frankfurtská pečeně, Boloňská směs, Kuřecí kousky na zeleném pepři	5
1372	3 Sterilovaná hotovka ve skle  - Chow-main z vepř.panenky, Svíčková om., Hov.guláš, Znojemské nudličky, Chilli con carne, Hov. po burgundsku	3sterilovanahotovkaveskle-chow-mainzvepr.panenky,svickovaom.,hov.gulas,znojemskenudlicky,chilliconcarne,hov.poburgundsku		3 Sterilovaná hotovka ve skle  - Chow-main z vepř.panenky, Svíčková om., Hov.guláš, Znojemské nudličky, Chilli con carne, Hov. po burgundsku	5
1444	1 Sterilovaná hotovka ve skle 0,7l - Bramborové kari Aloo- Bhaji	1sterilovanahotovkaveskle0,7l-bramborovekarialoo-bhaji		1 Sterilovaná hotovka ve skle 0,7l - Bramborové kari Aloo- Bhaji	5
1445	2 Sterilovaná hotovka ve skle 0,7l - Boloňská vepř. směs, Kuřecí kari	2sterilovanahotovkaveskle0,7l-bolonskavepr.smes,kurecikari		2 Sterilovaná hotovka ve skle 0,7l - Boloňská vepř. směs, Kuřecí kari	5
1216	Sterilovaná polévka ve skle 0,7l - Kapustnice, Kyselice, Hovězí vývar, Gulášová	sterilovanapolevkaveskle0,7l-kapustnice,kyselice,hovezivyvar,gulasova		Sterilovaná polévka ve skle 0,7l - Kapustnice, Kyselice, Hovězí vývar, Gulášová	5
101	120g Hovězí nudličky po znojemsku s okurkami a slaninou, basmati rýže	120ghovezinudlickypoznojemskusokurkamiaslaninou,basmatiryze	1a, 9, 10	\N	1
1446	3 Sterilovaná hotovka ve skle 0,7l - Hov.maso špik. svíčková om., Medailonky z v. panenky s ang.slan.a rozmarýnem	3sterilovanahotovkaveskle0,7l-hov.masospik.svickovaom.,medailonkyzv.panenkysang.slan.arozmarynem		3 Sterilovaná hotovka ve skle 0,7l - Hov.maso špik. svíčková om., Medailonky z v. panenky s ang.slan.a rozmarýnem	5
1447	150g Kuřecí kung-pao, jasmínová rýže	150gkurecikung-pao,jasminovaryze	1, 3, 5, 6, 7, 9, 10, 11	150g Spicy Roasted Chicken with Soya Sauce and Peanuts, jasmine Rice	2
1448	300g Zeleninový salát s pečenými grenaille bramborami, květákem, cuketou a mrkví sypané sýrem Feta	300gzeleninovysalatspecenymigrenaillebramborami,kvetakem,cuketouamrkvisypanesyremfeta	7	300g Zeleninový salát s pečenými grenaille bramborami, květákem, cuketou a mrkví sypané sýrem Feta	2
60	120g Frankfurtská vepřová pečeně, houskový knedlík	120gfrankfurtskaveprovapecene,houskovyknedlik	1a, 3, 7, 9	120g Spicy Roasted Pork, Sausage, Cream Sauce, bread Dumplings	2
1735	130g Filet ze pstruha, máslová omáčka, pečená baby karotka s bulgurem	130gfiletzepstruha,maslovaomacka,pecenababykarotkasbulgurem	1a, 4, 7, 9, 10, 12	130g Trout Fillet, butter Sauce, pečená baby karotka s bulgurem	2
388	150g Mix medailonky z vepřové panenky a kuřecího prsa, pepřová omáčka, americké brambory	150gmixmedailonkyzveprovepanenkyakurecihoprsa,peprovaomacka,americkebrambory	1a, 7, 9, 10, 12	150g Pork Loin and Chicken Breast Noisettes, peppercorn Sauce, potato Wedges	2
796	300g Zeleninový salát s grilovanou zeleninou, červenou řepou a granaille bramborami sypaný sýrem Feta	300gzeleninovysalatsgrilovanouzeleninou,cervenourepouagranaillebramboramisypanysyremfeta	7, 9	300g Vegetable Salad with Grilles Vegetables, Beetroot and Grenaille Potatoes Sprinkled with Feta Cheese	2
1390	3 Sterilovaná hotovka ve skle  - Krůtí medailonky,Znojemské hovězí nudličky,Kuřecí medailonky,Chow-Mein z vepřové panenky	3sterilovanahotovkaveskle-krutimedailonky,znojemskehovezinudlicky,kurecimedailonky,chow-meinzveprovepanenky		3 Sterilovaná hotovka ve skle  - Krůtí medailonky,Znojemské hovězí nudličky,Kuřecí medailonky,Chow-Mein z vepřové panenky	5
1398	120g Smažený vepřový karbenátek, vařené brambory s máslem, kyselý okurek	120gsmazenyveprovykarbenatek,varenebramborysmaslem,kyselyokurek	1a, 3, 7, 9, 10	120g Fried Pork Burger , boiled Potatoes with Butter, gherkin	2
1391	Sterilovaná polévka ve skle 0,7l -Kapustová,Boršč,Kyselice,Gulášová,Kuřecí vývar,Hovězí vývar,Z restovaných paprik,Cibulačka	sterilovanapolevkaveskle0,7l-kapustova,borsc,kyselice,gulasova,kurecivyvar,hovezivyvar,zrestovanychpaprik,cibulacka		Sterilovaná polévka ve skle 0,7l -Kapustová,Boršč,Kyselice,Gulášová,Kuřecí vývar,Hovězí vývar,Z restovaných paprik,Cibulačka	5
1392	1 Sterilovaná hotovka ve skle  -Bio hovězí vývar,Aloo-bhaji	1sterilovanahotovkaveskle-biohovezivyvar,aloo-bhaji		1 Sterilovaná hotovka ve skle  -Bio hovězí vývar,Aloo-bhaji	5
1393	2 Sterilovaná hotovka ve skle  -Masové kuličky s rajskou omáčkou,Segedínský guláš,Vepřová krkovice se steakovou omáčkou,Kuřecí směs,Vepřový vrabec se zelím,Kuřecí kousky	2sterilovanahotovkaveskle-masovekulickysrajskouomackou,segedinskygulas,veprovakrkovicesesteakovouomackou,kurecismes,veprovyvrabecsezelim,kurecikousky		2 Sterilovaná hotovka ve skle  -Masové kuličky s rajskou omáčkou,Segedínský guláš,Vepřová krkovice se steakovou omáčkou,Kuřecí směs,Vepřový vrabec se zelím,Kuřecí kousky	5
1394	3 Sterilovaná hotovka ve skle  -Chow-mein z vepřové panenky,Hovězí nudličky po znojemsku,Krůtí medailonky,Kuřecí medailonky s omáčkou z lišek	3sterilovanahotovkaveskle-chow-meinzveprovepanenky,hovezinudlickypoznojemsku,krutimedailonky,kurecimedailonkysomackouzlisek		3 Sterilovaná hotovka ve skle  -Chow-mein z vepřové panenky,Hovězí nudličky po znojemsku,Krůtí medailonky,Kuřecí medailonky s omáčkou z lišek	5
1401	130g Filet z lososa vařený v páře s pečenými čínskými nudlemi a zeleninou chow-mein	130gfiletzlososavarenyvparespecenymicinskyminudlemiazeleninouchow-mein	1a, 3, 4, 5, 6, 7, 9, 10, 11	130g Steamed Salmon Fillet with Roasted Chinese Noodles and Chow-Mein Vegetables	2
383	150g Medové kuřecí kousky s pórkem a paprikou, jasmínová rýže, bez lepku	150gmedovekurecikouskysporkemapaprikou,jasminovaryze,bezlepku	6, 9, 10	150g Chicken Bites with Honey, Leek and Sweet Pepper, jasmine Rice, gluten Free	2
1403	120g Grilovaný kuřecí gyros v brioche bulce, zelný salát, hranolky, bylinkový dip	120ggrilovanykurecigyrosvbriochebulce,zelnysalat,hranolky,bylinkovydip	1a, 1b, 7, 9, 10	120g Grilled Chicken Gyros in Brioche Bun, cabbage Salad, french Fries, Herb Dip	6
1411	2 Sterilovaná hotovka ve skle  - Rajská s kuličkami, Frankfurtská pečeně, Vrabec se zelím, Vepř.krkovice s pepř.om., Boloňská směs, Kuřecí kousky na zeleném pepři	2sterilovanahotovkaveskle-rajskaskulickami,frankfurtskapecene,vrabecsezelim,vepr.krkovicespepr.om.,bolonskasmes,kurecikouskynazelenempepri		2 Sterilovaná hotovka ve skle  - Rajská s kuličkami, Frankfurtská pečeně, Vrabec se zelím, Vepř.krkovice s pepř.om., Boloňská směs, Kuřecí kousky na zeleném pepři	5
1412	3 Sterilovaná hotovka ve skle  - Chow-main z vepř.panenky, Svíčková om., Hov.guláš, Znojemské nudličky, Chilli con carne, Kuř.medailonky s liškovou omáčkou	3sterilovanahotovkaveskle-chow-mainzvepr.panenky,svickovaom.,hov.gulas,znojemskenudlicky,chilliconcarne,kur.medailonkysliskovouomackou		3 Sterilovaná hotovka ve skle  - Chow-main z vepř.panenky, Svíčková om., Hov.guláš, Znojemské nudličky, Chilli con carne, Kuř.medailonky s liškovou omáčkou	5
1413	150g Kuřecí kapsa plněná sušenými rajčaty a mozzarelou, dušená rýže, trhané saláty	150gkurecikapsaplnenasusenymirajcatyamozzarelou,dusenaryze,trhanesalaty	1a, 7, 9	150g Chicken Roll Stuffed with Dried Tomatoes and Mozzarella, stewed Rice, shredded Lettuce	2
1414	120g Smažený camembert, vařené brambory, tatarská omáčka	120gsmazenycamembert,varenebrambory,tatarskaomacka	1a, 3, 7, 9, 10	120g Fried Camembert Cheese, boiled Potatoes, tartar Sauce	2
1415	300g Míchaný salát s fazolovými lusky a cherry rajčaty sypaný sýrem Feta, opečená bageta	300gmichanysalatsfazolovymiluskyacherryrajcatysypanysyremfeta,opecenabageta	1a, 3, 5, 7, 9, 10, 11	300g Míchaný salát s fazolovými lusky a cherry rajčaty sypaný sýrem Feta, toasted Baguette	2
1449	Sterilovaná polévka ve skle  0,7l - Gulášová,Valašská kyselice,Z restovaných paprik,Rajská,Boršč,Cibulačka,Slovenská kapustnica,Brokolicový krémový chowder,Jemná pepřová omáčka	sterilovanapolevkaveskle0,7l-gulasova,valasskakyselice,zrestovanychpaprik,rajska,borsc,cibulacka,slovenskakapustnica,brokolicovykremovychowder,jemnapeprovaomacka		Sterilovaná polévka ve skle  0,7l - Gulášová,Valašská kyselice,Z restovaných paprik,Rajská,Boršč,Cibulačka,Slovenská kapustnica,Brokolicový krémový chowder,Jemná pepřová omáčka	5
72	120g Grilovaná vepřová panenka s pepřovou omáčkou, smažené hranolky	120ggrilovanaveprovapanenkaspeprovouomackou,smazenehranolky	1a, 3, 5, 7, 9, 10, 11, 12	120g Grilled Pork Undercut with Peppercorn Sauce, french Fries (Fried Potato Chips)	6
1373	200g Smažený květák, vařené brambory	200gsmazenykvetak,varenebrambory	1, 3, 7, 10	200g Fried Cauliflower, boiled Potatoes	1
1395	120g Porthaus z vepřové panenky s česnekem a sezamovou strouhankou, šťouchané brambory, zeleninová ozdoba	120gporthauszveprovepanenkyscesnekemasezamovoustrouhankou,stouchanebrambory,zeleninovaozdoba	1a, 3, 7	120g Pork Undercut with Garlic and Sesame Crumbs, mashed Potatoes, vegetable Garnish	6
1450	2 Sterilovaná hotovka ve skle  - Kuřecí kousky,Boloňská směs,Vepřový vrabec,Steak z vepřové krkovice s pepřovou om.,Segedínský guláš	2sterilovanahotovkaveskle-kurecikousky,bolonskasmes,veprovyvrabec,steakzveprovekrkovicespeprovouom.,segedinskygulas		2 Sterilovaná hotovka ve skle  - Kuřecí kousky,Boloňská směs,Vepřový vrabec,Steak z vepřové krkovice s pepřovou om.,Segedínský guláš	5
1384	120g Hovězí po burgundsku s červeným vínem slaninou a baby cibulkami, bramborová kaše	120ghovezipoburgundskuscervenymvinemslaninouababycibulkami,bramborovakase	1a, 7, 9, 10, 12	120g Beef, Vegetables, Sauce with Red Wine, Bacon and Baby Onions, mashed Potatoes	2
1416	120g Kuřecí medailonky s hermelínem, sušenými rajčaty a bazalkovým pestem, šťouchané brambory	120gkurecimedailonkyshermelinem,susenymirajcatyabazalkovympestem,stouchanebrambory		120g Chicken Noisettes with Camembert Cheese, Dried Tomatoes and Basil Pesto, mashed Potatoes	1
1451	3 Sterilovaná hotovka ve skle  - Znojemské hovězí nudličky,Chow-Mein z vepřové panenky,Hovězí svíčková	3sterilovanahotovkaveskle-znojemskehovezinudlicky,chow-meinzveprovepanenky,hovezisvickova		3 Sterilovaná hotovka ve skle  - Znojemské hovězí nudličky,Chow-Mein z vepřové panenky,Hovězí svíčková	5
1452	120g Zvěřinový guláš z dančího a srnčího masa, špekové knedlíky	120gzverinovygulaszdancihoasrncihomasa,spekoveknedliky	1a, 3, 7, 9, 10	120g Venison Goulash with Fallow and Roe Deer Meat, dumplings with Bacon	1
1453	300g Zapečené palačinky s tvarohem, rozinkami a skořicí	300gzapecenepalacinkystvarohem,rozinkamiaskorici	1a, 3, 7, 12	300g Scalloped Pancakes with Quark, Raisins and Cinnamon	1
1454	Sterilovaná polévka ve skle 0,7l - Hovězí vývar, Rajská	sterilovanapolevkaveskle0,7l-hovezivyvar,rajska		Sterilovaná polévka ve skle 0,7l - Hovězí vývar, Rajská	5
1455	3 Sterilovaná hotovka ve skle  - Krůtí medailonky, Kuřecí medailonky, Znojemské nudličky	3sterilovanahotovkaveskle-krutimedailonky,kurecimedailonky,znojemskenudlicky		3 Sterilovaná hotovka ve skle  - Krůtí medailonky, Kuřecí medailonky, Znojemské nudličky	5
687	300g Luštěninové ragů s pečenou podzimní zeleninou a rajčaty, rýžový pilaf, bez lepku	300glusteninoveraguspecenoupodzimnizeleninouarajcaty,ryzovypilaf,bezlepku	9, 10	300g Lentil Ragout with Roasted Autumn Vegetables and Tomatoes, rice Pilaf, gluten Free	2
1736	250g Caesar tortilla s kuřecím masem, ančovičkovým dresinkem a sýrem, steakové hranolky	250gcaesartortillaskurecimmasem,ancovickovymdresinkemasyrem,steakovehranolky	1a, 1b, 3, 4, 5, 7, 9, 10, 11	250g Caesar Tortilla with Chicken, Anchovy Dressing and Cheese, french Fries in Steak Seasoning	6
1737	120g Řízečky z panenky v panko strouhance, steakové hranolky, bylinková creme fraiche	120grizeckyzpanenkyvpankostrouhance,steakovehranolky,bylinkovacremefraiche	1a, 1b, 3, 7, 11	120g Undercut Schnitzels in Panko Crumbs, french Fries in Steak Seasoning, herb Creme Fraiche	6
1738	430g Pizza PLAMEN tomat-pikant, šunka, trvanl.salám,mozzarella	430gpizzaplamentomat-pikant,sunka,trvanl.salam,mozzarella	1a, 1b, 7, 10	430g Pizza FLAME Tomato Purée, Ham, Salami, Chilli Peppers, Edam Cheese	8
1739	100g Smažený camembert, bramborové hranolky, trhaný salát	100gsmazenycamembert,bramborovehranolky,trhanysalat		100g Fried Camembert Cheese, potato French Fries, shredded Lettuce	6
1062	Pizza PLAMEN tomat-pikant, šunka, trvanl.salám,mozzarella	pizzaplamentomat-pikant,sunka,trvanl.salam,mozzarella	1a, 1b, 7, 10	Pizza FLAME Tomato Purée, Ham, Salami, Chilli Peppers, Edam Cheese	8
1387	Sterilovaná polévka ve skle 0,7l - Dýňová, Hovězí vývar, Kapustnice	sterilovanapolevkaveskle0,7l-dynova,hovezivyvar,kapustnice		Sterilovaná polévka ve skle 0,7l - Dýňová, Hovězí vývar, Kapustnice	5
1388	2 Sterilovaná hotovka ve skle  - Vepřový vrabec, Boloňská směs,	2sterilovanahotovkaveskle-veprovyvrabec,bolonskasmes,		2 Sterilovaná hotovka ve skle  - Vepřový vrabec, Boloňská směs,	5
1389	3 Sterilovaná hotovka ve skle  - Kuřecí kousky, Svíčková omáčka, Znojemské nudličky, Krůtí medailonky	3sterilovanahotovkaveskle-kurecikousky,svickovaomacka,znojemskenudlicky,krutimedailonky		3 Sterilovaná hotovka ve skle  - Kuřecí kousky, Svíčková omáčka, Znojemské nudličky, Krůtí medailonky	5
246	120g Vepřové medailonky s anglickou slaninou, smažené hranolky	120gveprovemedailonkysanglickouslaninou,smazenehranolky	1a, 3, 5, 7, 9, 11	120g Pork Noisettes with Bacon, french Fries (Fried Potato Chips)	6
1740	100g Salát se smaženými mozzarellovými tyčinkami a čerstvou zeleninou, jogurtový dip	100gsalatsesmazenymimozzarellovymitycinkamiacerstvouzeleninou,jogurtovydip	1a, 3, 7, 9	100g Salát se smaženými mozzarellovými tyčinkami a čerstvou zeleninou, yogurt Dip	6
1217	2 Sterilovaná hotovka ve skle  - Boloňská směs, Kuřecí na paprice, Fraknfurtská pečeně	2sterilovanahotovkaveskle-bolonskasmes,kurecinapaprice,fraknfurtskapecene		2 Sterilovaná hotovka ve skle  - Boloňská směs, Kuřecí na paprice, Fraknfurtská pečeně	5
1218	3 Sterilovaná hotovka ve skle  - Svíčková omáčka	3sterilovanahotovkaveskle-svickovaomacka		3 Sterilovaná hotovka ve skle  - Svíčková omáčka	5
1219	100g Smažený kuřecí řízek	100gsmazenykurecirizek		100g Fried Chicken Schnitzel	2
1741	240g Pečené kuřecí stehno, dušené červené zelí s cibulí, bramborový knedlík	240gpecenekurecistehno,dusenecervenezeliscibuli,bramborovyknedlik	1a, 3, 5, 7, 9, 10, 11	240g Roasted Chicken Leg, stewed Red Cabbage with Onion, Potato Dumplings	2
1220	Sterilovaná polévka ve skle  0,7l - Gulášová,Dýňová,Valašská kyselice,Z restovaných paprik,Telecí vývar,Slovenská kapustnica,Jemná pepřová omáčka	sterilovanapolevkaveskle0,7l-gulasova,dynova,valasskakyselice,zrestovanychpaprik,telecivyvar,slovenskakapustnica,jemnapeprovaomacka		Sterilovaná polévka ve skle  0,7l - Gulášová,Dýňová,Valašská kyselice,Z restovaných paprik,Telecí vývar,Slovenská kapustnica,Jemná pepřová omáčka	5
1221	3 Sterilovaná hotovka ve skle  - Hovězí guláš,Vepřové medailonky se steakovou om.,Hovězí svíčková,Chow-Mein z vepřové panenky,Krůtí medailonky,Znojemské hovězí nudličky	3sterilovanahotovkaveskle-hovezigulas,veprovemedailonkysesteakovouom.,hovezisvickova,chow-meinzveprovepanenky,krutimedailonky,znojemskehovezinudlicky		3 Sterilovaná hotovka ve skle  - Hovězí guláš,Vepřové medailonky se steakovou om.,Hovězí svíčková,Chow-Mein z vepřové panenky,Krůtí medailonky,Znojemské hovězí nudličky	5
1008	Coleslaw	coleslaw		Coleslaw	3
1222	300g Cassoulet s fazolemi, pečenou mrkví, baby špenátem, rýžový pilaf	300gcassouletsfazolemi,pecenoumrkvi,babyspenatem,ryzovypilaf		300g Cassoulet with Beans, Roasted Carrots and Baby Spinach, rice Pilaf	2
1742	150g Medailonky z vepřové panenky s nivovou omáčkou, pečené brambory	150gmedailonkyzveprovepanenkysnivovouomackou,pecenebrambory	1a, 7, 9, 10, 12	150g Pork Undercut Noisettes with Blue Cheese Sauce, scalloped Potatoes	2
1417	120g Krůtí nudličky na bylinkách s pórkem a smetanou, basmati rýže	120gkrutinudlickynabylinkachsporkemasmetanou,basmatiryze		120g Turkey Noodles with Herbs, Leek and Cream, basmati Rice	1
1456	2 Sterilovaná hotovka ve skle  - Kuřecí kousky,Boloňská směs,Vepřový vrabec,Kuřecí kari,Segedínský guláš	2sterilovanahotovkaveskle-kurecikousky,bolonskasmes,veprovyvrabec,kurecikari,segedinskygulas		2 Sterilovaná hotovka ve skle  - Kuřecí kousky,Boloňská směs,Vepřový vrabec,Kuřecí kari,Segedínský guláš	5
1457	3 Sterilovaná hotovka ve skle  - Znojemské hovězí nudličky,Chow-Mein z vepřové panenky,Hovězí svíčková,Medailonky z vepřové panenky	3sterilovanahotovkaveskle-znojemskehovezinudlicky,chow-meinzveprovepanenky,hovezisvickova,medailonkyzveprovepanenky		3 Sterilovaná hotovka ve skle  - Znojemské hovězí nudličky,Chow-Mein z vepřové panenky,Hovězí svíčková,Medailonky z vepřové panenky	5
1743	2 Sterilovaná hotovka ve skle  - Boloňská,Krkovice se steakovou omáčkou	2sterilovanahotovkaveskle-bolonska,krkovicesesteakovouomackou		2 Sterilovaná hotovka ve skle  - Boloňská,Krkovice se steakovou omáčkou	5
1744	Sterilovaná polévka ve skle 0,7l - Cibulačka	sterilovanapolevkaveskle0,7l-cibulacka		Sterilovaná polévka ve skle 0,7l - Cibulačka	5
1745	2 Sterilovaná hotovka ve skle 0,7l - Boloňská vepř. směs, Vepř.krkovice s pepř.omáčkou	2sterilovanahotovkaveskle0,7l-bolonskavepr.smes,vepr.krkovicespepr.omackou		2 Sterilovaná hotovka ve skle 0,7l - Boloňská vepř. směs, Vepř.krkovice s pepř.omáčkou	5
1223	120g Kuřecí řízek v mandlové strouhance, mačkané brambory se smetanou	120gkurecirizekvmandlovestrouhance,mackanebramborysesmetanou	1a, 3, 7, 8, 8a	120g Chicken Schnitzel in Almond Breadcrumbs, Crushed Potatoes with Cream	2
1224	120g Špikovaná vepřová pečeně na smetaně, houskový knedlík	120gspikovanaveprovapecenenasmetane,houskovyknedlik	1a, 3, 7, 9, 10	120g Larded Pork Roast in Cream Sauce, bread Dumplings	2
1225	300g Zeleninové chilli concarne se sojovým masem, fazolemi a kukuřicí, bylinkový kuskus	300gzeleninovechilliconcarnesesojovymmasem,fazolemiakukurici,bylinkovykuskus	1a, 3, 6, 7, 9	300g Vegetable Chilli Con Carne with Soya Meat, Beans and Corn, herb Couscous	2
1226	350g Dukátové buchtičky s vanilkovým krémem a slaným karamelem	350gdukatovebuchtickysvanilkovymkrememaslanymkaramelem	1a, 3, 7	350g Small Yeast Buns with Vanilla Custard and Salted Caramel	2
1227	100g Grilovaný camembert, bramborové hranolky, brusinkový dip	100ggrilovanycamembert,bramborovehranolky,brusinkovydip	1a, 1b, 3, 5, 7, 9, 10, 11, 12	100g Grilled Camembert, potato French Fries, cranberry Dip	6
1228	450g Pizza ZINGARA tomat, klobása, cibule, žampiony,mozzarella, oregáno	450gpizzazingaratomat,klobasa,cibule,zampiony,mozzarella,oregano	1a, 1b, 7	450g Pizza ZINGARA Tomato Purée, Edam Cheese, Sausage, Onion, Champignons, Oregano	8
1229	Vegetariánská ciabatta s cuketou, pečenými paprikami a tofu, bramborové hranolky, smetanový dip	vegetarianskaciabattascuketou,pecenymipaprikamiatofu,bramborovehranolky,smetanovydip	1a, 3, 7, 9	Vegetarian Ciabatta with Zucchini, Roasted Peppers and Tofu (Bean Curd), potato French Fries, creamy Dip	6
1230	150g Grilovaný losos s bylinkami, opékané brambory, koprový dip	150ggrilovanylosossbylinkami,opekanebrambory,koprovydip	3, 4, 7	150g Grilled Salmon with Herbs, roasted Potatoes, dill Dip	6
1231	150g Kuřecí prsa na paprice, těstoviny	150gkureciprsanapaprice,testoviny	1a, 3, 7, 9	150g Chicken Breast in Cream and Paprika Sauce, pasta	2
1232	300g Bulgureto s hovězím masem a zeleninou sypané sýrem, kyselý okurek	300gbulguretoshovezimmasemazeleninousypanesyrem,kyselyokurek	1a, 7, 10	300g Bulgur Wheat Risotto with Beef and Vegetables, Sprinkled with Cheese, gherkin	2
1233	300g Belgické wafle s karamelizovaným jablkem, čerstvým ovocem, šlehačkou a javorovým sirupem	300gbelgickewafleskaramelizovanymjablkem,cerstvymovocem,slehackouajavorovymsirupem	1a, 3, 7	300g Belgian Waffles with Caramelized Apple, Fresh Fruit, Whipped Cream and Maple Syrup	2
1009	Dýňová polévka	dynovapolevka	1a, 7, 9	\N	9
1266	250g Restovaná jasmínová rýže se zeleninou a krevetami, trhaný salát	250grestovanajasminovaryzesezeleninouakrevetami,trhanysalat	2, 6, 7, 9	250g Roasted Jasmine Rice with Vegetables and Shrimp, shredded Lettuce	2
1267	120g Hovězí maso vařené, koprová omáčka, opečené brambory	120ghovezimasovarene,koprovaomacka,opecenebrambory	1a, 7, 9	120g Boiled Beef Meat, Dill Sauce, roasted Potatoes	2
1418	120g Bramborák plněný pikantní kuřecí směsí, trhaný salát	120gbramborakplnenypikantnikurecismesi,trhanysalat	1a, 3, 5, 6, 7, 9, 10, 11	120g Potato Pancake Stuffed with Spicy Chicken Meat Mix, shredded Lettuce	2
1235	Sterilovaná polévka ve skle 0,7l -Hovězí vývar,Slovenská kapustnice,Gulášová,Dýňová	sterilovanapolevkaveskle0,7l-hovezivyvar,slovenskakapustnice,gulasova,dynova		Sterilovaná polévka ve skle 0,7l -Hovězí vývar,Slovenská kapustnice,Gulášová,Dýňová	5
1236	2 Sterilovaná hotovka ve skle  -Boloňská,Vepřový vrabec,Frankfurtská pečeně,Kuřecí kousky na pepři	2sterilovanahotovkaveskle-bolonska,veprovyvrabec,frankfurtskapecene,kurecikouskynapepri		2 Sterilovaná hotovka ve skle  -Boloňská,Vepřový vrabec,Frankfurtská pečeně,Kuřecí kousky na pepři	5
1237	3 Sterilovaná hotovka ve skle  -Hovězí svíčková	3sterilovanahotovkaveskle-hovezisvickova		3 Sterilovaná hotovka ve skle  -Hovězí svíčková	5
1419	350g Stew z červené řepy po burgundsku s čočkou, cibulkami a šalotkou, česneková bageta	350gstewzcervenerepypoburgundskuscockou,cibulkamiasalotkou,cesnekovabageta	1a, 7, 9, 10, 12	350g Beetroot Stew with Lentils, Onions and Shallot, garlic Baguette	2
1359	Sterilovaná polévka ve skle 0,7l - Kapustnice, Dýňová, Hovězí vývar	sterilovanapolevkaveskle0,7l-kapustnice,dynova,hovezivyvar		Sterilovaná polévka ve skle 0,7l - Kapustnice, Dýňová, Hovězí vývar	5
1360	2 Sterilovaná hotovka ve skle  - Boloňská směs, Rajská s kuličkami, Vepřová vrabec	2sterilovanahotovkaveskle-bolonskasmes,rajskaskulickami,veprovavrabec		2 Sterilovaná hotovka ve skle  - Boloňská směs, Rajská s kuličkami, Vepřová vrabec	5
1361	3 Sterilovaná hotovka ve skle  - Kuřecí medailonky, Svíčková omáčka, Znojemské nudličky,	3sterilovanahotovkaveskle-kurecimedailonky,svickovaomacka,znojemskenudlicky,		3 Sterilovaná hotovka ve skle  - Kuřecí medailonky, Svíčková omáčka, Znojemské nudličky,	5
1362	Sterilovaná polévka ve skle 0,7l - Kapustová	sterilovanapolevkaveskle0,7l-kapustova		Sterilovaná polévka ve skle 0,7l - Kapustová	5
1363	2 Sterilovaná hotovka ve skle  --Masové kuličky s rajskou omáčkou,Segedínský guláš,Kuřecí směs,Vepřový vrabec se zelím,Kuřecí kousky	2sterilovanahotovkaveskle--masovekulickysrajskouomackou,segedinskygulas,kurecismes,veprovyvrabecsezelim,kurecikousky		2 Sterilovaná hotovka ve skle  --Masové kuličky s rajskou omáčkou,Segedínský guláš,Kuřecí směs,Vepřový vrabec se zelím,Kuřecí kousky	5
1420	250g 1 ks Rakouský knedlík s povidly, vanilkovým krémem sypaný mákem a cukrem	250g1ksrakouskyknedlikspovidly,vanilkovymkrememsypanymakemacukrem	1a, 3, 7	250g Germknödel with Plum Butter, Poppy, Vanilla Cream	2
1365	Sterilovaná polévka ve skle 0,7l - Telecí vývar, Slovenská kapustnica, Kyselice s uz.masem, Z restovaných paprik s rajčaty, Rozbaš- hrachová  s masem a raj., Gulášová s vepř.m., Hov.vývar s byl.noky	sterilovanapolevkaveskle0,7l-telecivyvar,slovenskakapustnica,kyselicesuz.masem,zrestovanychpapriksrajcaty,rozbas-hrachovasmasemaraj.,gulasovasvepr.m.,hov.vyvarsbyl.noky		Sterilovaná polévka ve skle 0,7l - Telecí vývar, Slovenská kapustnica, Kyselice s uz.masem, Z restovaných paprik s rajčaty, Rozbaš- hrachová  s masem a raj., Gulášová s vepř.m., Hov.vývar s byl.noky	5
1366	1 Sterilovaná hotovka ve skle 0,7l - Bramborový guláš, Brambor.kari Aloo- Bhaji	1sterilovanahotovkaveskle0,7l-bramborovygulas,brambor.karialoo-bhaji		1 Sterilovaná hotovka ve skle 0,7l - Bramborový guláš, Brambor.kari Aloo- Bhaji	5
1367	3 Sterilovaná hotovka ve skle 0,7l - Krůtí med.angl.sl.pórek,suš.rajčata, Hov. svíčková omáčka, Med. z vepř panenky,steak.om.,	3sterilovanahotovkaveskle0,7l-krutimed.angl.sl.porek,sus.rajcata,hov.svickovaomacka,med.zveprpanenky,steak.om.,		3 Sterilovaná hotovka ve skle 0,7l - Krůtí med.angl.sl.pórek,suš.rajčata, Hov. svíčková omáčka, Med. z vepř panenky,steak.om.,	5
1421	150g Bramborák plněný pikantní kuřecí směsí, trhaný salát	150gbramborakplnenypikantnikurecismesi,trhanysalat	1a, 3, 5, 6, 7, 9, 10, 11	150g Potato Pancake Stuffed with Spicy Chicken Meat Mix, shredded Lettuce	2
1422	150g Steak z vepřové krkovice, bramborový špíz s cibulkou a slaninou, česnekový dresink	150gsteakzveprovekrkovice,bramborovyspizscibulkouaslaninou,cesnekovydresink	1a, 3, 5, 7, 9, 10, 11	150g Pork Neck Steak, potato Skewer with Onion and Bacon, garlic Dressing	2
1423	300g Palačinky s marmeládou a šlehaným tvarohem, čerstvé ovoce, strouhaná čokoláda	300gpalacinkysmarmeladouaslehanymtvarohem,cerstveovoce,strouhanacokolada	1a, 3, 7	300g Pancakes with Jam and Whipped Quark, Fresh Fruit, Chocolate Crumbs	2
1458	150g Steak z vepřové krkovičky s pepřovou omáčkou, opékané brambory	150gsteakzveprovekrkovickyspeprovouomackou,opekanebrambory	1a, 3, 5, 7, 9, 10, 11, 12	150g Pork Neck Steak with Peppercorn Sauce, roasted Potatoes	2
1459	300g Zeleninový smetanový perkelt s paprikami a robi masem, bylinkové gnocchi	300gzeleninovysmetanovyperkeltspaprikamiarobimasem,bylinkovegnocchi	1a, 6, 7, 9	300g Vegetable Creamy Pörkölt with Peppers and 'Plant Protein' Meat, herbal Gnocchi	2
1234	130g Filet z tilápie s jarní nádivkou, bylinkové máslo, šťouchané brambory	130gfiletztilapiesjarninadivkou,bylinkovemaslo,stouchanebrambory	1a, 4, 7, 9	130g Tilapia Fillet with Spring Stuffing, herb Butter, mashed Potatoes	1
1284	150g Marinovaná vepřová kotleta, grilovaná zelenina, steakové hranolky	150gmarinovanaveprovakotleta,grilovanazelenina,steakovehranolky	1, 3, 5, 9, 10, 11	150g Marinated Pork Cutlet, grilled Vegetables, french Fries in Steak Seasoning	6
1285	300g Bun bo nam bo - Vietnamský salát se zeleninou, rýžovými nudlemi,bylinkami a hovězím masem	300gbunbonambo-vietnamskysalatsezeleninou,ryzovyminudlemi,bylinkamiahovezimmasem	5	300g Bun bo Nam Bo - Vietnamese Salad with Vegetables, Rice Noodles, Herbs and Beef	2
976	470g Pizza JULIA tomat, šunka, kukuřice, smetana, uzený sýr	470gpizzajuliatomat,sunka,kukurice,smetana,uzenysyr	1a, 1b, 7	470g Pizza JULIA Tomato Purée, Ham, Maize, Single Cream, Smoked Cheese	8
1069	Rajská s těstovinou	rajskastestovinou	1a, 3, 9	\N	9
1460	130g Pečený filet z mořského pstruha s bylinkami, restovanou zeleninou a grenaille bramborami	130gpecenyfiletzmorskehopstruhasbylinkami,restovanouzeleninouagrenaillebramborami	1, 4, 7, 9, 10	130g Roasted Sea Trout Fillet with Herbs, Roasted Vegetables and Grenaille Potatoes	2
1461	300g Zeleninová směs s dýní, uzeným tofu, fazolemi a cherry rajčaty, jasmínová rýže, bez lepku	300gzeleninovasmessdyni,uzenymtofu,fazolemiacherryrajcaty,jasminovaryze,bezlepku	6, 9, 10	300g Vegetable Medley with Pumpkin, Smoked Tofu, Beans and Cherry Tomatoes, jasmine Rice, gluten Free	2
1238	Sterilovaná polévka ve skle  0,7l - Gulášová,Dýňová,Valašská kyselice,Z restovaných paprik,Telecí vývar,Slovenská kapustnica,Rajská,Jemná pepřová omáčka	sterilovanapolevkaveskle0,7l-gulasova,dynova,valasskakyselice,zrestovanychpaprik,telecivyvar,slovenskakapustnica,rajska,jemnapeprovaomacka		Sterilovaná polévka ve skle  0,7l - Gulášová,Dýňová,Valašská kyselice,Z restovaných paprik,Telecí vývar,Slovenská kapustnica,Rajská,Jemná pepřová omáčka	5
1239	3 Sterilovaná hotovka ve skle  - Vepřové medailonky se steakovou om.,Hovězí svíčková,Chow-Mein z vepřové panenky,Krůtí medailonky,Znojemské hovězí nudličky,Kuřecí medailonky	3sterilovanahotovkaveskle-veprovemedailonkysesteakovouom.,hovezisvickova,chow-meinzveprovepanenky,krutimedailonky,znojemskehovezinudlicky,kurecimedailonky		3 Sterilovaná hotovka ve skle  - Vepřové medailonky se steakovou om.,Hovězí svíčková,Chow-Mein z vepřové panenky,Krůtí medailonky,Znojemské hovězí nudličky,Kuřecí medailonky	5
1424	Sterilovaná polévka ve skle  0,7l - Gulášová,Valašská kyselice,Z restovaných paprik,Telecí,Hovězí vývar,Rajská,Boršč,Jemná pepřová omáčka	sterilovanapolevkaveskle0,7l-gulasova,valasskakyselice,zrestovanychpaprik,teleci,hovezivyvar,rajska,borsc,jemnapeprovaomacka		Sterilovaná polévka ve skle  0,7l - Gulášová,Valašská kyselice,Z restovaných paprik,Telecí,Hovězí vývar,Rajská,Boršč,Jemná pepřová omáčka	5
1425	120g Grilované krůtí kousky, bramborové hranolky, pivní majonéza	120ggrilovanekrutikousky,bramborovehranolky,pivnimajoneza	1a, 1b, 3, 5, 7, 9, 10, 11	120g Grilled Turkey Pieces, potato French Fries, beer Mayonnaise	6
1426	Sterilovaná polévka ve skle 0,7l - Rajská,Krémová kuřecí,Cibulačka,Gulášová,Kyselice,Kapustová,Hovězí vývar,Boršč,Kuřecí vývar	sterilovanapolevkaveskle0,7l-rajska,kremovakureci,cibulacka,gulasova,kyselice,kapustova,hovezivyvar,borsc,kurecivyvar		Sterilovaná polévka ve skle 0,7l - Rajská,Krémová kuřecí,Cibulačka,Gulášová,Kyselice,Kapustová,Hovězí vývar,Boršč,Kuřecí vývar	5
1427	2 Sterilovaná hotovka ve skle  -Masové kuličky s rajskou omáčkou,Vepř.krkovice s pepřovou omáčkou,Kuřecí směs,Vepřový vrabec se zelím,Kuřecí kousky	2sterilovanahotovkaveskle-masovekulickysrajskouomackou,vepr.krkovicespeprovouomackou,kurecismes,veprovyvrabecsezelim,kurecikousky		2 Sterilovaná hotovka ve skle  -Masové kuličky s rajskou omáčkou,Vepř.krkovice s pepřovou omáčkou,Kuřecí směs,Vepřový vrabec se zelím,Kuřecí kousky	5
1428	3 Sterilovaná hotovka ve skle  - Vepřové medailonky chow-mein,Hovězí nudličky po znojemsku,Krůtí medailonky,Vepřová panenka se svíčkovou,Kuřecí medailonky s omáčkou z lišek	3sterilovanahotovkaveskle-veprovemedailonkychow-mein,hovezinudlickypoznojemsku,krutimedailonky,veprovapanenkasesvickovou,kurecimedailonkysomackouzlisek		3 Sterilovaná hotovka ve skle  - Vepřové medailonky chow-mein,Hovězí nudličky po znojemsku,Krůtí medailonky,Vepřová panenka se svíčkovou,Kuřecí medailonky s omáčkou z lišek	5
1429	120g Porthaus z vepřové panenky s česnekem a sezamovou strouhankou, šťouchané brambory	120gporthauszveprovepanenkyscesnekemasezamovoustrouhankou,stouchanebrambory	1a, 9, 11	120g Pork Undercut with Garlic and Sesame Crumbs, mashed Potatoes	6
1462	300g Čerstvé těstoviny s cuketou, polotvrdým sýrem grand biraghi a smetanou	300gcerstvetestovinyscuketou,polotvrdymsyremgrandbiraghiasmetanou	1a, 1b, 7, 9	300g Čerstvé těstoviny s cuketou, polotvrdým sýrem grand biraghi a smetanou	6
1463	100g Kuřecí směs po čínsku, bramborové hranolky	100gkurecismespocinsku,bramborovehranolky	1a, 3, 5, 6, 7, 9, 11	100g Spicy Chicken Noodles with Vegetables and Champignons, potato French Fries	6
1464	Plněný paprikový lusk v rajské omáčce, těstoviny fusilli	plnenypaprikovyluskvrajskeomacce,testovinyfusilli	1a, 3, 9	Bell Pepper Stuffed with Minced Meat, Tomato Sauce, pasta Twists (Fusilli)	2
1465	100g Smažený camembert, bramborové hranolky, zeleninová ozdoba	100gsmazenycamembert,bramborovehranolky,zeleninovaozdoba	1a, 3, 7	100g Fried Camembert Cheese, potato French Fries, vegetable Garnish	6
1466	150g Vepřová pečeně na houbách, smažené hranolky	150gveprovapecenenahoubach,smazenehranolky	1a, 9, 10	150g Pork Roast with Mushrooms, french Fries (Fried Potato Chips)	2
1467	300g Luštěninový salát s cizrnou, čočkou, fazolemi, cherry rajčaty, paprikou a červenou cibulí, grilované tofu	300glusteninovysalatscizrnou,cockou,fazolemi,cherryrajcaty,paprikouacervenoucibuli,grilovanetofu	6, 9, 10	300g Luštěninový salát s cizrnou, čočkou, fazolemi, cherry rajčaty, paprikou a červenou cibulí, grilované tofu	2
1746	Sterilovaná polévka ve skle  0,7l - Z restovaných paprik,Cibulačka,Brokolicový chowder,Kuřecí,Dýňová,Kulajda,Jemná pepřová omáčka	sterilovanapolevkaveskle0,7l-zrestovanychpaprik,cibulacka,brokolicovychowder,kureci,dynova,kulajda,jemnapeprovaomacka		Sterilovaná polévka ve skle  0,7l - Z restovaných paprik,Cibulačka,Brokolicový chowder,Kuřecí,Dýňová,Kulajda,Jemná pepřová omáčka	5
1747	3 Sterilovaná hotovka ve skle  - Hovězí guláš	3sterilovanahotovkaveskle-hovezigulas		3 Sterilovaná hotovka ve skle  - Hovězí guláš	5
524	250g Caesar tortilla s kuřecím masem, ančovičkovým dresinkem a sýrem, bramborové hranolky	250gcaesartortillaskurecimmasem,ancovickovymdresinkemasyrem,bramborovehranolky	1a, 1b, 3, 4, 5, 7, 9, 10, 11	250g Caesar Tortilla with Chicken, Anchovy Dressing and Cheese, potato French Fries	6
1240	490g Pizza ANANASSO tomat, ananas, eidam, oregáno	490gpizzaananassotomat,ananas,eidam,oregano	1a, 1b, 7	490g Pizza ANANASSO Tomato Purée, Pineapple, Edam Cheese, Oregano	8
6	100g Grilovaný hermelín, bramborové hranolky, brusinkový dip	100ggrilovanyhermelin,bramborovehranolky,brusinkovydip	1a, 1b, 3, 5, 7, 9, 10, 11, 12	\N	6
7	100g Hermelín na grilu s brusinkami, bramborové hranolky, trhaný salát	100ghermelinnagrilusbrusinkami,bramborovehranolky,trhanysalat	7, 9, 12	\N	6
8	100g Hermelín na grilu s brusinkami, pečené grenaile, trhaný salát	100ghermelinnagrilusbrusinkami,pecenegrenaile,trhanysalat	7, 9, 12	\N	6
9	100g Hovězí pečeně přírodní, koprová máslová omáčka, houskový knedlík	100ghovezipeceneprirodni,koprovamaslovaomacka,houskovyknedlik	1a, 3, 7, 9	\N	1
10	100g Kuřecí gyros v housce, trhaný salát, česnekový dip	100gkurecigyrosvhousce,trhanysalat,cesnekovydip	1a, 3, 7, 9, 10	\N	6
11	100g Kuřecí nudličky, pečené kari nudle	100gkurecinudlicky,pecenekarinudle	1a, 3, 6, 9	\N	6
12	100g Kuřecí prsa na paprice, houskový knedlík	100gkureciprsanapaprice,houskovyknedlik	1a, 3, 7, 9	\N	2
1241	300g Zeleninové chilli concarne se sojovým masem, fazolemi a kukuřicí, dušená rýže	300gzeleninovechilliconcarnesesojovymmasem,fazolemiakukurici,dusenaryze		300g Vegetable Chilli Con Carne with Soya Meat, Beans and Corn, stewed Rice	2
39	11 Sterilovaná hotovka ve skle  - Hovězí vývar BIO	11sterilovanahotovkaveskle-hovezivyvarbio		\N	5
1430	2 Sterilovaná hotovka ve skle  - Kuřecí kousky,Boloňská směs,Frankfurtská pečeně,Kuličky z mletého masa s rajskou om.,Vepřový vrabec,Steak z vepřové krkovice s pepřovou om.	2sterilovanahotovkaveskle-kurecikousky,bolonskasmes,frankfurtskapecene,kulickyzmletehomasasrajskouom.,veprovyvrabec,steakzveprovekrkovicespeprovouom.		2 Sterilovaná hotovka ve skle  - Kuřecí kousky,Boloňská směs,Frankfurtská pečeně,Kuličky z mletého masa s rajskou om.,Vepřový vrabec,Steak z vepřové krkovice s pepřovou om.	5
1431	3 Sterilovaná hotovka ve skle  - Krůtí medailonky,Znojemské hovězí nudličky,Kuřecí medailonky,Chow-Mein z vepřové panenky,Chilli con carne z kuřecího masa	3sterilovanahotovkaveskle-krutimedailonky,znojemskehovezinudlicky,kurecimedailonky,chow-meinzveprovepanenky,chilliconcarnezkurecihomasa		3 Sterilovaná hotovka ve skle  - Krůtí medailonky,Znojemské hovězí nudličky,Kuřecí medailonky,Chow-Mein z vepřové panenky,Chilli con carne z kuřecího masa	5
1432	120g Medové kuřecí kousky s pórkem a paprikou, dušená rýže	120gmedovekurecikouskysporkemapaprikou,dusenaryze	6, 9, 10	120g Chicken Bites with Honey, Leek and Sweet Pepper, stewed Rice	2
1433	120g Medailonky z vepřové panenky se zeleninou, zázvorem a sezamem, dušená rýže	120gmedailonkyzveprovepanenkysezeleninou,zazvoremasezamem,dusenaryze	1a, 1b, 3, 5, 6, 7, 9, 10, 11	120g Pork Undercut Noisettes with Vegetables, Ginger and Sesame, stewed Rice	2
1434	130g Pečený candát s citronovou gremolatou, opékané brambory	130gpecenycandatscitronovougremolatou,opekanebrambory		130g Roasted Pike Perch with Lemon Gremolata, roast Potatoes	6
1435	Sterilovaná polévka ve skle 0,7l - Hovězí vývar, Dýňová, Gulášová	sterilovanapolevkaveskle0,7l-hovezivyvar,dynova,gulasova		Sterilovaná polévka ve skle 0,7l - Hovězí vývar, Dýňová, Gulášová	5
1436	2 Sterilovaná hotovka ve skle  - Boloňská směs, Vepřový vrabec	2sterilovanahotovkaveskle-bolonskasmes,veprovyvrabec		2 Sterilovaná hotovka ve skle  - Boloňská směs, Vepřový vrabec	5
1437	3 Sterilovaná hotovka ve skle  - Znojemské nudličky, Krůtí medailonky, Svíčková omáčka, Kuřecí medailonky	3sterilovanahotovkaveskle-znojemskenudlicky,krutimedailonky,svickovaomacka,kurecimedailonky		3 Sterilovaná hotovka ve skle  - Znojemské nudličky, Krůtí medailonky, Svíčková omáčka, Kuřecí medailonky	5
55	120g Džuveč z vepřového masa se zeleninou, sýr gouda	120gdzuveczveprovehomasasezeleninou,syrgouda		\N	2
1468	Sterilovaná polévka ve skle  0,7l - Gulášová,Valašská kyselice,Z restovaných paprik,Rajská,Boršč,Cibulačka,Slovenská kapustnica,Brokolicový krémový chowder,Kuřecí,Jemná pepřová omáčka	sterilovanapolevkaveskle0,7l-gulasova,valasskakyselice,zrestovanychpaprik,rajska,borsc,cibulacka,slovenskakapustnica,brokolicovykremovychowder,kureci,jemnapeprovaomacka		Sterilovaná polévka ve skle  0,7l - Gulášová,Valašská kyselice,Z restovaných paprik,Rajská,Boršč,Cibulačka,Slovenská kapustnica,Brokolicový krémový chowder,Kuřecí,Jemná pepřová omáčka	5
1469	3 Sterilovaná hotovka ve skle  - Kuřecí medailonky, Znojemké nudličky, Krůtí medailonky	3sterilovanahotovkaveskle-kurecimedailonky,znojemkenudlicky,krutimedailonky		3 Sterilovaná hotovka ve skle  - Kuřecí medailonky, Znojemké nudličky, Krůtí medailonky	5
1012	Fazolová s rajčaty	fazolovasrajcaty	1a, 9	Bean Soup with Tomatoes	9
1748	Sterilovaná polévka ve skle 0,7l - Brokolicová,Fazolová,Dýňová,Z restovaných paprik,Sugo di Pomodoro,Pepřová omáčka	sterilovanapolevkaveskle0,7l-brokolicova,fazolova,dynova,zrestovanychpaprik,sugodipomodoro,peprovaomacka		Sterilovaná polévka ve skle 0,7l - Brokolicová,Fazolová,Dýňová,Z restovaných paprik,Sugo di Pomodoro,Pepřová omáčka	5
1749	2 Sterilovaná hotovka ve skle  - Vepřová boloňská omáčka	2sterilovanahotovkaveskle-veprovabolonskaomacka		2 Sterilovaná hotovka ve skle  - Vepřová boloňská omáčka	5
1750	Sterilovaná polévka ve skle 0,7l - Cibulačka, Steaková om.,Pepřová om., Sugo di pomodoro	sterilovanapolevkaveskle0,7l-cibulacka,steakovaom.,peprovaom.,sugodipomodoro		Sterilovaná polévka ve skle 0,7l - Cibulačka, Steaková om.,Pepřová om., Sugo di pomodoro	5
42	120g Chilli con-carne z kuřecího masa s fazolemi a zeleninou, basmati rýže	120gchillicon-carnezkurecihomasasfazolemiazeleninou,basmatiryze	1a, 3, 7, 9	\N	1
1242	120g Sekaná vepřová pečeně, šťouchané brambory, sterilovaný okurek	120gsekanaveprovapecene,stouchanebrambory,sterilovanyokurek		120g Minced Pork Meat, mashed Potatoes, gherkin	1
1438	120g Kuřecí plátek na barevném pepři, basmati rýže	120gkureciplateknabarevnempepri,basmatiryze	1a, 9, 10	120g Chicken Slice with Peppercorns, basmati Rice	1
1470	Sterilovaná polévka ve skle 0,7l - Rajská,Hovězí vývar,Kuřecí krémová,Cibulačka,Boršč	sterilovanapolevkaveskle0,7l-rajska,hovezivyvar,kurecikremova,cibulacka,borsc		Sterilovaná polévka ve skle 0,7l - Rajská,Hovězí vývar,Kuřecí krémová,Cibulačka,Boršč	5
1471	2 Sterilovaná hotovka ve skle  - Vepřový vrabec se zelím,Vepřová krkovice s pepřovou omáčkou,Kuřecí kousky,	2sterilovanahotovkaveskle-veprovyvrabecsezelim,veprovakrkovicespeprovouomackou,kurecikousky,		2 Sterilovaná hotovka ve skle  - Vepřový vrabec se zelím,Vepřová krkovice s pepřovou omáčkou,Kuřecí kousky,	5
1472	3 Sterilovaná hotovka ve skle  -Kuřecí medailonkys liškovou omáčkou	3sterilovanahotovkaveskle-kurecimedailonkysliskovouomackou		3 Sterilovaná hotovka ve skle  -Kuřecí medailonkys liškovou omáčkou	5
1751	120g Přírodní vepřový plátek, mačkané brambory	120gprirodniveprovyplatek,mackanebrambory	1a, 7, 9, 10	120g Pork Slice au Naturel, Sauce, crushed Potatoes	1
438	150g Steak z vepřové pečeně s mrkví, pečené grenaile	150gsteakzveprovepecenesmrkvi,pecenegrenaile	1, 3, 5, 7, 9, 10, 11	\N	2
70	120g Grilovaná vepřová panenka, smažené hranolky, pepřový dip	120ggrilovanaveprovapanenka,smazenehranolky,peprovydip	1a, 7, 10, 11, 12	\N	6
77	120g Grilované kuřecí kousky, bramborové hranolky, sýrový dip	120ggrilovanekurecikousky,bramborovehranolky,syrovydip	1a, 1b, 3, 5, 6, 7, 9, 10, 11	\N	6
1473	100g Myslivecká hovězí pečeně, houskový knedlík	100gmysliveckahovezipecene,houskovyknedlik		100g Roasted and Stewed Beef, Bacon, Cream Sauce, bread Dumplings	1
109	120g Hovězí pečeně s rajskou omáčkou, houskový knedlík	120ghovezipecenesrajskouomackou,houskovyknedlik	1a, 3, 9	120g Roast Beef with Tomato Sauce, bread Dumplings	1
1752	3 Sterilovaná hotovka ve skle  - Hovězí guláš,Hovězí pečeně s koprovou om.	3sterilovanahotovkaveskle-hovezigulas,hovezipeceneskoprovouom.		3 Sterilovaná hotovka ve skle  - Hovězí guláš,Hovězí pečeně s koprovou om.	5
48	120g Chow - mein z vepřové panenky s brokolicí, mrkví, žampiony  a sezamem, pečené kari nudle	120gchow-meinzveprovepanenkysbrokolici,mrkvi,zampionyasezamem,pecenekarinudle	1a, 3, 5, 6, 7, 9, 10, 11	120g Pork Undercut Chow Mein with Broccoli, Carrot  and Sesame, baked Curry Noodles	2
1753	350g Pečené kuřecí stehno ala husa, červené zelí s vínem a jablky, bramborový knedlík	350gpecenekurecistehnoalahusa,cervenezelisvinemajablky,bramborovyknedlik	1a, 3, 5, 7, 9, 10, 11, 12	350g Roast Chicken Leg, red Cabbage with Wine and Apples, potato Dumpling	2
343	150g Kuřecí kousky "sweet and sour" s medem, chilli a zeleninou, jasmínová rýže, bez lepku	150gkurecikousky"sweetandsour"smedem,chilliazeleninou,jasminovaryze,bezlepku	6, 9, 10	150g Chicken Pieces in Sweet and Sour Sauce with Honey, Chilli and Vegetables, jasmine Rice, gluten Free	2
963	440g Pizza BÍLÁ PERLA zakys. smetana, uzená kýta, anglická slanina, česnek,mozzarella	440gpizzabilaperlazakys.smetana,uzenakyta,anglickaslanina,cesnek,mozzarella	1a, 1b, 7, 10	440g Pizza WHITE PEARL Sour Cream, Smoked Leg, Bacon, Garlic, Edam Cheese	8
1754	120g Smažené kuřecí stripsy v mandlové strouhance, bramborové hranolky, bylinková creme fraiche	120gsmazenekurecistripsyvmandlovestrouhance,bramborovehranolky,bylinkovacremefraiche	1a, 3, 7, 9, 10	120g Fried Almond-Crusted Chicken Strips, potato French Fries, herb Creme Fraiche	6
1755	300g Těstovinový salát s vepřovými nudličkami a zeleninou, dip z kysané smetany	300gtestovinovysalatsveprovyminudlickamiazeleninou,dipzkysanesmetany	1a, 3, 7, 9	300g Pasta Salad with Pork Noodles and Vegetables, sour Cream Dip	6
1756	150g Kuřecí prsa na grilu, zeleninové rizoto, kyselý okurek	150gkureciprsanagrilu,zeleninoverizoto,kyselyokurek	1, 3, 5, 7, 9, 10, 11	150g Kuřecí prsa na grilu, zeleninové rizoto, gherkin	2
1757	300g Těstoviny alla Zozzona sypané sýrem gran biraghi	300gtestovinyallazozzonasypanesyremgranbiraghi	1a, 3, 7	300g Pasta Alla Zozzona Sprinkled with Gran Biraghi Cheese	2
103	120g Hovězí nudličky po znojemsku s okurkami a slaninou, jasmínová rýže	120ghovezinudlickypoznojemskusokurkamiaslaninou,jasminovaryze	1a, 9, 10	120g Beef Noodles with Pickled Cucumber and Bacon, jasmine Rice	2
480	1 Sterilovaná hotovka ve skle 0,7l - Bramborový guláš	1sterilovanahotovkaveskle0,7l-bramborovygulas		\N	5
44	120g Chow-mein z vepřové panenky s brokolicí, mrkví, paprikami a sezamem, basmati rýže	120gchow-meinzveprovepanenkysbrokolici,mrkvi,paprikamiasezamem,basmatiryze	1a, 3, 5, 6, 7, 9, 10, 11	120g Pork Undercut Chow Mein with Broccoli, Carrot, Peppers and Sesame, basmati Rice	1
717	300g Smetanové fetuciny all Alfredo se sýrem pecorino a špenátovým pestem	300gsmetanovefetucinyallalfredosesyrempecorinoaspenatovympestem	1a, 3, 7, 9	300g Fettuccine al Alfredo with Cream, Pecorino Cheese and Spinach Pesto	2
420	150g Smažené rybí filé, vařené brambory, tatarská omáčka	150gsmazenerybifile,varenebrambory,tatarskaomacka	1a, 3, 4, 7, 10	150g Fried Fish Fillet, boiled Potatoes, tartar Sauce	2
1243	300g Tvarohové knedlíky s nugátovou náplní, ořechová drobenka, přepuštěné máslo	300gtvarohoveknedlikysnugatovounaplni,orechovadrobenka,prepustenemaslo	1a, 3, 7, 8, 8b, 8c	300g Quark Dumplings Filled with Nougat, nut Crumble, melted Butter	2
1244	120g Club sandwich s krůtím masem, cibulovou slaninádou a ledovým salátem, bramborové hranolky	120gclubsandwichskrutimmasem,cibulovouslaninadoualedovymsalatem,bramborovehranolky	1a, 1b, 3, 7	120g Club sandwich s krůtím masem, cibulovou slaninádou a ledovým salátem, potato French Fries	6
45	120g Chow - mein z vepřové panenky s brokolicí, mrkví, žampiony  a sezamem, basmati rýže	120gchow-meinzveprovepanenkysbrokolici,mrkvi,zampionyasezamem,basmatiryze	1a, 3, 5, 6, 7, 9, 10, 11	120g Pork Undercut Chow Mein with Broccoli, Carrot  and Sesame, basmati Rice	2
1245	350g Tvarohové knedlíky s nugátovou náplní, ořechová drobenka, přepuštěné máslo	350gtvarohoveknedlikysnugatovounaplni,orechovadrobenka,prepustenemaslo	1a, 3, 7, 8, 8b, 8c	350g Quark Dumplings Filled with Nougat, nut Crumble, melted Butter	2
1246	100g Grilovaný camembert s brusinkovým dipem, bramborové hranolky, zeleninová obloha	100ggrilovanycamembertsbrusinkovymdipem,bramborovehranolky,zeleninovaobloha	1, 5, 7, 9, 10, 11, 12	100g Grilled Camembert with Cranberry Dip, potato French Fries, vegetable Garnish	6
1004	Česneková s krutony	cesnekovaskrutony	3, 9	Garlic Soup with Croutons	9
1247	150g Smažený kuřecí řízek, bramborová kaše, okurkový salát	150gsmazenykurecirizek,bramborovakase,okurkovysalat	1a, 3, 7, 9	150g Fried Chicken Schnitzel, mashed Potatoes, cucumber Salad	2
1248	150g Pikantní směs z vepřové panenky se zeleninou, jasmínová rýže	150gpikantnismeszveprovepanenkysezeleninou,jasminovaryze	1, 3, 6, 7, 9	150g Spicy Pork Loin Meat Mix with Vegetables, jasmine Rice	2
1249	300g Zeleninový salát s chřestem, sázeným vejcem a opečenou anglickou slaninou, opečený toast	300gzeleninovysalatschrestem,sazenymvejcemaopecenouanglickouslaninou,opecenytoast	1a, 3, 10	300g Vegetable Salad with Asparagus, Fried Egg and Roasted Bacon, toast	2
110	120g Hovězí po burgundsku s červeným vínem slaninou a baby cibulkami, jasmínová rýže	120ghovezipoburgundskuscervenymvinemslaninouababycibulkami,jasminovaryze	1a, 9, 10, 12	\N	2
1250	1 Sterilovaná hotovka ve skle  - Bramborový guláš	1sterilovanahotovkaveskle-bramborovygulas		1 Sterilovaná hotovka ve skle  - Bramborový guláš	5
1251	Sterilovaná polévka ve skle 0,7l -Slovenská kapustnice,Dýňová,Gulášová,Hovězí vývar	sterilovanapolevkaveskle0,7l-slovenskakapustnice,dynova,gulasova,hovezivyvar		Sterilovaná polévka ve skle 0,7l -Slovenská kapustnice,Dýňová,Gulášová,Hovězí vývar	5
1252	2 Sterilovaná hotovka ve skle  -Kuřecí kousky na pepři,Boloňská,Vepřový vrabec,Frankfurtská pečeně	2sterilovanahotovkaveskle-kurecikouskynapepri,bolonska,veprovyvrabec,frankfurtskapecene		2 Sterilovaná hotovka ve skle  -Kuřecí kousky na pepři,Boloňská,Vepřový vrabec,Frankfurtská pečeně	5
1474	3 Sterilovaná hotovka ve skle  -Kuřecí medailonky  liškovou omáčkou	3sterilovanahotovkaveskle-kurecimedailonkyliskovouomackou		3 Sterilovaná hotovka ve skle  -Kuřecí medailonky  liškovou omáčkou	5
107	120g Hovězí pečeně, smetanová koprová omáčka, houskový knedlík	120ghovezipecene,smetanovakoprovaomacka,houskovyknedlik	1a, 3, 7, 9	120g Roasted Beef, Creamy Dill Sauce, bread Dumplings	2
1758	300g Linguinny se špenátovým pestem, karamelizovanou šalotkou a feta sýrem, bazalkové pesto	300glinguinnysespenatovympestem,karamelizovanousalotkouafetasyrem,bazalkovepesto	1a, 3, 7, 9, 12	300g Linguine with Spinach Pesto, Caramelized Shallot and Feta Cheese, basil Pesto	1
1759	2 Sterilovaná hotovka ve skle  - Rajská s masovými kuličkami,Krkovice se steakovou omáčkou,Boloňská směs	2sterilovanahotovkaveskle-rajskasmasovymikulickami,krkovicesesteakovouomackou,bolonskasmes		2 Sterilovaná hotovka ve skle  - Rajská s masovými kuličkami,Krkovice se steakovou omáčkou,Boloňská směs	5
1760	Sterilovaná polévka ve skle 0,7l - Kuřecí vývar s trh.masem, Valašská kyselice s uz.masem, Kulajda, Fazolová s uz.masem, Dýňová se smet., Cibulačka, Steaková om., Pepřová om., Sugo di pomodoro	sterilovanapolevkaveskle0,7l-kurecivyvarstrh.masem,valasskakyselicesuz.masem,kulajda,fazolovasuz.masem,dynovasesmet.,cibulacka,steakovaom.,peprovaom.,sugodipomodoro		Sterilovaná polévka ve skle 0,7l - Kuřecí vývar s trh.masem, Valašská kyselice s uz.masem, Kulajda, Fazolová s uz.masem, Dýňová se smet., Cibulačka, Steaková om., Pepřová om., Sugo di pomodoro	5
1761	120g Vepřové medailonky s anglickou slaninou, smažené hranolky, zeleninová obloha	120gveprovemedailonkysanglickouslaninou,smazenehranolky,zeleninovaobloha	1a, 3, 5, 7, 9, 10, 11	120g Pork Noisettes with Bacon, french Fries (Fried Potato Chips), vegetable Garnish	6
104	120g Hovězí nudličky stroganoff se smetanou, žampiony a okurkami, basmati rýže	120ghovezinudlickystroganoffsesmetanou,zampionyaokurkami,basmatiryze	1a, 7, 9, 10, 12	\N	1
105	120g Hovězí nudličky stroganoff se smetanou, žampiony a okurkami, dušená rýže	120ghovezinudlickystroganoffsesmetanou,zampionyaokurkami,dusenaryze	1a, 7, 9, 10, 12	\N	2
106	120g Hovězí nudličky stroganoff se smetanou, žampiony a okurkami, jasmínová rýže	120ghovezinudlickystroganoffsesmetanou,zampionyaokurkami,jasminovaryze	1a, 7, 9, 10, 12	\N	2
108	120g Hovězí pečeně se šípkovou omáčkou, houskový knedlík	120ghovezipecenesesipkovouomackou,houskovyknedlik	1a, 3, 7, 9, 10	\N	2
1475	300g Čočka na kyselo s opékaným párkem, cibulkou, chléb, sterilovaný okurek	300gcockanakyselosopekanymparkem,cibulkou,chleb,sterilovanyokurek	1a, 10	300g Sour Lentils with Fried Sausage and Onions, bread, Gherkin	2
1476	150g Smažené cuketové medailonky, karotkové pyré	150gsmazenecuketovemedailonky,karotkovepyre	1a, 3, 7, 9	150g Fried Zucchini Noisettes, carrot Purée	2
1253	2 Sterilovaná hotovka ve skle  --Masové kuličky s rajskou omáčkou,Segedínský guláš,Kuřecí směs,Vepřový vrabec se zelím,Vepřová boloňská směs,Kuřecí kousky,Kuřecí na paprice	2sterilovanahotovkaveskle--masovekulickysrajskouomackou,segedinskygulas,kurecismes,veprovyvrabecsezelim,veprovabolonskasmes,kurecikousky,kurecinapaprice		2 Sterilovaná hotovka ve skle  --Masové kuličky s rajskou omáčkou,Segedínský guláš,Kuřecí směs,Vepřový vrabec se zelím,Vepřová boloňská směs,Kuřecí kousky,Kuřecí na paprice	5
1477	300g Fetuciny s tuňákem, bazalkou a rajčatovou omáčkou, parmazánová salsa	300gfetucinystunakem,bazalkouarajcatovouomackou,parmazanovasalsa	1a, 3, 4, 7, 9	300g Fettuccine Pasta with Tuna, Basil and Tomato Sauce, parmesan Salsa	2
1255	2 Sterilovaná hotovka ve skle 0,7l - Kuřecí medailonky  just, Boloňská vepř. směs, Moravský vrabec, zelí	2sterilovanahotovkaveskle0,7l-kurecimedailonkyjust,bolonskavepr.smes,moravskyvrabec,zeli		2 Sterilovaná hotovka ve skle 0,7l - Kuřecí medailonky  just, Boloňská vepř. směs, Moravský vrabec, zelí	5
1256	3 Sterilovaná hotovka ve skle 0,7l - Hov. svíčková omáčka, Medailónky z vepř panenky,steak.om., Hovězí guláš,  Krůtí medailonky,  Hov.Stroganoff	3sterilovanahotovkaveskle0,7l-hov.svickovaomacka,medailonkyzveprpanenky,steak.om.,hovezigulas,krutimedailonky,hov.stroganoff		3 Sterilovaná hotovka ve skle 0,7l - Hov. svíčková omáčka, Medailónky z vepř panenky,steak.om., Hovězí guláš,  Krůtí medailonky,  Hov.Stroganoff	5
1478	300g Veganské chilli concarne s fazolemi, sojovým masem a rajčaty, rýžový pilaf, bez lepku	300gveganskechilliconcarnesfazolemi,sojovymmasemarajcaty,ryzovypilaf,bezlepku	3, 6, 7, 9	300g Vegan Chilli Con Carne with Soya Meat, Beans and Tomatoes, rice Pilaf, gluten Free	2
1479	120g Grilované krůtí kousky, bramborové hranolky, medový dip, trhaný salát	120ggrilovanekrutikousky,bramborovehranolky,medovydip,trhanysalat	1a, 1b, 3, 5, 7, 9, 10, 11	120g Grilled Turkey Pieces, potato French Fries, honey Dip, Shredded Lettuce	6
1480	120g Porthaus z vepřové panenky s česnekem a sezamovou strouhankou, trhaný salát, bramborové hranolky	120gporthauszveprovepanenkyscesnekemasezamovoustrouhankou,trhanysalat,bramborovehranolky	1a, 1b, 3, 7, 9, 10, 11	120g Pork Undercut with Garlic and Sesame Crumbs, shredded Lettuce, potato French Fries	6
1481	400g Pizza SÝROVÁ s bylinkami,mozzarella, hermelín, uzený sýr	400gpizzasyrovasbylinkami,mozzarella,hermelin,uzenysyr	1a, 1b, 7	400g Cheese Pizza with Herbs, Edam Cheese,Blue Cheese,Smoked Cheese,Camembert	8
1482	120g Ciabatta s trhaným vepřovým masem, bramborové hranolky, salát Coleslaw	120gciabattastrhanymveprovymmasem,bramborovehranolky,salatcoleslaw	1a, 1b, 3, 7, 9	120g Ciabatta with Pulled Pork Meat, potato French Fries, coleslaw (Cabbage Salad)	6
1483	300g Smažené cuketové medailonky, karotkové pyré	300gsmazenecuketovemedailonky,karotkovepyre	1a, 3, 7, 9	300g Fried Zucchini Noisettes, carrot Purée	2
1484	150g Plněná vepřová kapsa klobásou a kysaným zelím, opečené brambory	150gplnenaveprovakapsaklobasouakysanymzelim,opecenebrambory	1a, 9	150g Pork Roll Stuffed with Smoked Sausage and Sauerkraut, roasted Potatoes	2
113	120g Hovězí Stroganov, dušená rýže	120ghovezistroganov,dusenaryze	1a, 7, 9, 10, 12	120g Sautéed Beef Meat, stewed Rice	2
1762	120g Přírodní vepřový plátek, jasmínová rýže	120gprirodniveprovyplatek,jasminovaryze	1a, 9, 10	120g Pork Slice au Naturel, Sauce, jasmine Rice	1
114	120g Krůtí medailonky s anglickou slaninou, pórkem a sušenými rajčaty, basmati rýže	120gkrutimedailonkysanglickouslaninou,porkemasusenymirajcaty,basmatiryze	1a, 7, 9	120g Turkey Noisettes with Bacon, Leek and Dried Tomatoes, basmati Rice	2
111	120g Hovězí po burgundsku s červeným vínem slaninou a baby cibulkami, mačkané brambory	120ghovezipoburgundskuscervenymvinemslaninouababycibulkami,mackanebrambory	1a, 7, 9, 10, 12	120g Beef, Vegetables, Sauce with Red Wine, Bacon and Baby Onions, crushed Potatoes	2
147	120g Kuřecí řízek, bramborový salát s majonézou	120gkurecirizek,bramborovysalatsmajonezou		\N	2
112	120g Hovězí stroganoff s okurkami, smetanou a žampiony, jasmínová rýže	120ghovezistroganoffsokurkami,smetanouazampiony,jasminovaryze	1a, 7, 9, 10, 12	\N	2
116	120g Krůtí medailonky s omáčkou z pečeného česneku, žampionů a smetany, smažené hranolky	120gkrutimedailonkysomackouzpecenehocesneku,zampionuasmetany,smazenehranolky	1a, 7, 9	\N	2
117	120g Krůtí nudličky na bylinkách s pórkem a smetanou, těstoviny fusilli	120gkrutinudlickynabylinkachsporkemasmetanou,testovinyfusilli	1a, 7, 9, 10, 12	\N	2
118	120g Krůtí plátek přírodní, smetanová nivová omáčka, opékané brambory	120gkrutiplatekprirodni,smetanovanivovaomacka,opekanebrambory	1a, 3, 5, 7, 9, 10, 11	\N	2
119	120g Krůtí plátek přírodní, smetanová nivová omáčka, smažené hranolky	120gkrutiplatekprirodni,smetanovanivovaomacka,smazenehranolky	1a, 3, 5, 7, 9, 10, 11	\N	2
120	120g Krůtí řízek v mandlové strouhance, bramborové hranolky, jogurtovo-bylinkový dip	120gkrutirizekvmandlovestrouhance,bramborovehranolky,jogurtovo-bylinkovydip	1a, 1b, 3, 7, 8, 8a	\N	6
121	120g Krůtí řízek v mandlové strouhance, šťouchané brambory	120gkrutirizekvmandlovestrouhance,stouchanebrambory	1a, 3, 7, 8, 8a	\N	2
1485	2 Sterilovaná hotovka ve skle  - Kuřecí kousky,Boloňská směs,Vepřový vrabec,Kuřecí kari	2sterilovanahotovkaveskle-kurecikousky,bolonskasmes,veprovyvrabec,kurecikari		2 Sterilovaná hotovka ve skle  - Kuřecí kousky,Boloňská směs,Vepřový vrabec,Kuřecí kari	5
1486	3 Sterilovaná hotovka ve skle  - Znojemské nudličky, Kuřecímedailonky, Svíčková omáčka	3sterilovanahotovkaveskle-znojemskenudlicky,kurecimedailonky,svickovaomacka		3 Sterilovaná hotovka ve skle  - Znojemské nudličky, Kuřecímedailonky, Svíčková omáčka	5
132	120g Kuřecí kari tandori masala s jogurtem a zázvorem, jasmínová rýže	120gkurecikaritandorimasalasjogurtemazazvorem,jasminovaryze	1, 7, 9, 10	120g Chicken Curry Tandoori Masala with Yogurt and Ginger, jasmine Rice	2
123	120g Krůtí výpečky se slaninou a česnekem, červené zelí s vínem a jablky, bramborový knedlík	120gkrutivypeckyseslaninouacesnekem,cervenezelisvinemajablky,bramborovyknedlik	1a, 1b, 3, 9, 10, 12	120g Turkey Meat with Bacon, Garlic, Lard, red Cabbage with Wine and Apples, potato Dumpling	2
143	120g Kuřecí prsa capresse s mozzarellou, rajčaty a bazalkovým pestem, mačkané brambory	120gkureciprsacapressesmozzarellou,rajcatyabazalkovympestem,mackanebrambory	1a, 3, 5, 7, 8, 8d, 9, 10, 11	120g Chicken Breasts Capresse with Mozzarella, Tomatoes and Basil Pesto, crushed Potatoes	2
1763	120g Hamburger s trhaným vepřovým masem, bramborové hranolky, trhaný salát, pikantní chipotle majonéza	120ghamburgerstrhanymveprovymmasem,bramborovehranolky,trhanysalat,pikantnichipotlemajoneza	1a, 1b, 3, 6, 7, 9, 10, 12, 13	120g Hamburger with Pulled Pork Meat, potato French Fries, trhaný salát, pikantní chipotle majonéza	6
129	120g Kuřecí kapsa plněná šunkou a nivou, bramborové hranolky	120gkurecikapsaplnenasunkouanivou,bramborovehranolky	1a, 1b, 7	120g Chicken Roll Stuffed with Ham and Blue Cheese, potato French Fries	6
124	120g Kuličky z mletého masa s rajskou omáčkou, těstoviny kolena	120gkulickyzmletehomasasrajskouomackou,testovinykolena	1a, 3, 7, 9, 10	\N	2
125	120g Kuřecí cordon blue se šunkou a sýrem, vařené brambory s máslem	120gkurecicordonbluesesunkouasyrem,varenebramborysmaslem	1a, 3, 7, 9, 10	\N	2
126	120g Kuřecí goujons, bramborové hranolky, sweet chilli dip	120gkurecigoujons,bramborovehranolky,sweetchillidip	1a, 1b, 3, 6, 7, 10	\N	6
127	120g Kuřecí goujons, bramborové hranolky, sweet chilli dip, trhaný salát	120gkurecigoujons,bramborovehranolky,sweetchillidip,trhanysalat	1a, 1b, 3, 6, 7, 9, 10	\N	6
130	120g Kuřecí kari Balti s kokosovým mlékem, mandlemi a koriandrem, dušená rýže	120gkurecikaribaltiskokosovymmlekem,mandlemiakoriandrem,dusenaryze	1, 8, 8a, 9, 10	\N	1
133	120g Kuřecí kousky "Tikka masala" s rajčaty, jogurtem a smetanou, basmati rýže	120gkurecikousky"tikkamasala"srajcaty,jogurtemasmetanou,basmatiryze	1a, 7, 9, 10	\N	2
1254	120g Kuřecí řízek v mandlové strouhance, šťouchané brambory	120gkurecirizekvmandlovestrouhance,stouchanebrambory	1a, 3, 7, 8, 8a	120g Chicken Schnitzel in Almond Breadcrumbs, mashed Potatoes	1
547	260g Pečené kuřecí stehno, dušená rýže	260gpecenekurecistehno,dusenaryze	1a, 9, 10	\N	1
134	120g Kuřecí kousky "Tikka masala" s rajčaty, jogurtem a smetanou, dušená rýže	120gkurecikousky"tikkamasala"srajcaty,jogurtemasmetanou,dusenaryze	1a, 7, 9, 10	\N	2
136	120g Kuřecí medailonky s omáčkou z lišek a žampionů, mačkané brambory	120gkurecimedailonkysomackouzlisekazampionu,mackanebrambory	1a, 3, 5, 7, 9, 10, 11	\N	2
138	120g Kuřecí nudličky, bramborová kaše, máslový hrášek	120gkurecinudlicky,bramborovakase,maslovyhrasek	1a, 1b, 7, 9, 10	\N	2
139	120g Kuřecí placičky s kari a medem, bramborové hranolky	120gkureciplacickyskariamedem,bramborovehranolky	3, 6, 9	\N	6
140	120g Kuřecí plátek na grilu, omáčka z modrého sýra, bramborové hranolky	120gkureciplateknagrilu,omackazmodrehosyra,bramborovehranolky	1a, 7, 9	\N	6
141	120g Kuřecí prsa capresse s mozzarellou, rajčaty a bazalkovým pestem, dušená rýže	120gkureciprsacapressesmozzarellou,rajcatyabazalkovympestem,dusenaryze	1a, 3, 5, 7, 8, 8d, 9, 10, 11	\N	1
142	120g Kuřecí prsa capresse s mozzarellou, rajčaty a bazalkovým pestem, jasmínová rýže	120gkureciprsacapressesmozzarellou,rajcatyabazalkovympestem,jasminovaryze	1a, 3, 5, 7, 8, 8c	\N	1
144	120g Kuřecí prsa na paprice, houskový knedlík	120gkureciprsanapaprice,houskovyknedlik	1a, 3, 7, 9	\N	2
145	120g Kuřecí prsa na paprice, vařené těstoviny - kolínka	120gkureciprsanapaprice,varenetestoviny-kolinka	1a, 3, 7, 9	\N	2
146	120g Kuřecí řízečky v mandlové strouhance, bramborové hranolky, zeleninová ozdoba	120gkurecirizeckyvmandlovestrouhance,bramborovehranolky,zeleninovaozdoba	1a, 1b, 3, 7, 8, 8a	\N	6
1265	Kapustová s bramborem	kapustovasbramborem	1a, 9	Cabbage Soup with Potatoes	9
1269	2 Sterilovaná hotovka ve skle  - Vepřový vrabec,Kuřecí kousky,Boloňská směs,Frankfurtská pečeně,Kuličky z mletého masa s rajskou om.	2sterilovanahotovkaveskle-veprovyvrabec,kurecikousky,bolonskasmes,frankfurtskapecene,kulickyzmletehomasasrajskouom.		2 Sterilovaná hotovka ve skle  - Vepřový vrabec,Kuřecí kousky,Boloňská směs,Frankfurtská pečeně,Kuličky z mletého masa s rajskou om.	5
1270	Sterilovaná polévka ve skle 0,7l -Hovězí vývar,Dýňová,Gulášová,Slovenská kapustnice	sterilovanapolevkaveskle0,7l-hovezivyvar,dynova,gulasova,slovenskakapustnice		Sterilovaná polévka ve skle 0,7l -Hovězí vývar,Dýňová,Gulášová,Slovenská kapustnice	5
1271	2 Sterilovaná hotovka ve skle  -Kuřecí kousky na pepři,Boloňská,Frankfurtská,Vepřový vrabec	2sterilovanahotovkaveskle-kurecikouskynapepri,bolonska,frankfurtska,veprovyvrabec		2 Sterilovaná hotovka ve skle  -Kuřecí kousky na pepři,Boloňská,Frankfurtská,Vepřový vrabec	5
624	2 Sterilovaná hotovka ve skle 0,7l - Segedínský guláš s v. masem, Boloňská vep. směs	2sterilovanahotovkaveskle0,7l-segedinskygulassv.masem,bolonskavep.smes		\N	5
1487	300g Čerstvé těstoviny s cuketou, smetanou a sýrem gran biraghi 	300gcerstvetestovinyscuketou,smetanouasyremgranbiraghi	1a, 1b, 7, 9	300g Fresh Pasta with Courgette, Grand Biraghi Semi-Hard Cheese and Cream	6
1488	130g Pečený filet z mořského pstruha s bylinkami, restovaná zelenina, grenaille brambory	130gpecenyfiletzmorskehopstruhasbylinkami,restovanazelenina,grenaillebrambory	1, 4, 7, 9, 10	130g Roasted Sea Trout Fillet with Herbs, roasted Vegetables, grenaille Potatoes	1
153	120g Kuřecí směs kung-pao s arašídy a zeleninou, jasmínová rýže	120gkurecismeskung-paosarasidyazeleninou,jasminovaryze	1, 3, 5, 6, 7, 9, 10, 11	120g Kung Pao Chicken Meat Mix with Peanuts and Vegetables, jasmine Rice	2
1764	150g Vepřová panenka na grilu, pepřová omáčka, bramborové hranolky	150gveprovapanenkanagrilu,peprovaomacka,bramborovehranolky	1a, 7, 9, 10, 12	150g Grilled Pork Tenderloin, peppercorn Sauce, potato French Fries	6
148	120g Kuřecí řízek Ondráš smažený v bramborákovém těstě, trhaný salát, bylinkový dip	120gkurecirizekondrassmazenyvbramborakovemteste,trhanysalat,bylinkovydip	1a, 3, 7, 9	\N	2
149	120g Kuřecí řízek v mandlové strouhance, bramborové hranolky, bylinkový dip	120gkurecirizekvmandlovestrouhance,bramborovehranolky,bylinkovydip	1a, 1b, 3, 7, 8, 8a	\N	6
150	120g Kuřecí řízek v parmazánové strouhance, bramborové hranolky, bylinkový dip	120gkurecirizekvparmazanovestrouhance,bramborovehranolky,bylinkovydip	1a, 1b, 3, 7	\N	6
151	120g Kuřecí řízek v sezamové strouhance, bramborové hranolky, jogurtovo-bylinkový dip	120gkurecirizekvsezamovestrouhance,bramborovehranolky,jogurtovo-bylinkovydip	1a, 1b, 3, 7, 11	\N	6
152	120g Kuřecí směs kung-pao s arašídy a zeleninou, dušená rýže	120gkurecismeskung-paosarasidyazeleninou,dusenaryze	1a, 1b, 3, 5, 6, 7, 9, 10, 11	\N	2
1038	Krémová slepičí s kari, zázvorem a koriandrem	kremovaslepiciskari,zazvoremakoriandrem	1a, 7, 9, 10, 12	Creamy Hen Soup with Curry, Ginger and Coriander	9
1489	300g Lasagne s vepřovým masem, rajčaty a sýrovou omáčkou	300glasagnesveprovymmasem,rajcatyasyrovouomackou	1a, 3, 7, 9	300g Lasagne with Pork Meat, Tomatoes and Cheese Sauce	2
1490	300g Koprová omáčka, 2 vejce, vařené brambory	300gkoprovaomacka,2vejce,varenebrambory	1a, 3, 7, 9	300g Dill Sauce, 2 Eggs, boiled Potatoes	2
1272	Sterilovaná polévka ve skle  0,7l - Gulášová, Bramboračka, Rajská z pečených paprik, Valašská kyselice	sterilovanapolevkaveskle0,7l-gulasova,bramboracka,rajskazpecenychpaprik,valasskakyselice		Sterilovaná polévka ve skle  0,7l - Gulášová, Bramboračka, Rajská z pečených paprik, Valašská kyselice	5
1491	130g Asijské nudle s lososem, zeleninou, sezamem a ústřicovou sojovou omáčkou	130gasijskenudleslososem,zeleninou,sezamemaustricovousojovouomackou	1a, 3, 4, 6, 7, 9, 10, 11	130g Asian Noodles with Salmon, Vegetables, Sesame and Oyster Soy Sauce	2
88	120g Hamburger s trhaným kuřecím masem, bramborové hranolky, zázvorová BBQ omáčka	120ghamburgerstrhanymkurecimmasem,bramborovehranolky,zazvorovabbqomacka	1a, 1b, 3, 5, 6, 7, 9, 10, 11, 12, 13	120g Hamburger with Pulled Chicken Meat, potato French Fries, ginger BBQ	6
1492	300g Konfitované vepřové žebra, sezónní coleslaw, česneková bageta s čedarem	300gkonfitovaneveprovezebra,sezonnicoleslaw,cesnekovabagetascedarem	1a, 1b, 7, 9, 10, 12	300g Konfitované vepřové žebra, sezónní coleslaw, česneková bageta s čedarem	6
1493	450g Pizza ANANASSO tomat, ananas, eidam, oregáno	450gpizzaananassotomat,ananas,eidam,oregano	1a, 1b, 7	450g Pizza ANANASSO Tomato Purée, Pineapple, Edam Cheese, Oregano	8
1494	120g Kuřecí plátek na grilu, pečená zelenina, americké brambory	120gkureciplateknagrilu,pecenazelenina,americkebrambory	9	120g Grilled Chicken Slice, roasted Vegetables, potato Wedges	6
1495	120g Porthaus z vepřové panenky s česnekem a sezamovou strouhankou, bramborové hranolky, tatarská omáčka	120gporthauszveprovepanenkyscesnekemasezamovoustrouhankou,bramborovehranolky,tatarskaomacka	1a, 3, 7, 9, 10	120g Pork Undercut with Garlic and Sesame Crumbs, potato French Fries, tartar Sauce	6
1496	120g Hovězí hamburger s čedarem a slaninou, smažené hranolky, pivní majonéza	120ghovezihamburgerscedaremaslaninou,smazenehranolky,pivnimajoneza	1a, 3, 7, 9, 10	120g Beef Hamburger with Cheddar Cheese and Bacon, french Fries (Fried Potato Chips), beer Mayonnaise	6
1497	300g Těstovinový salát se zeleninou a kuřecími kousky, jogurtovo - bylinkový dip	300gtestovinovysalatsezeleninouakurecimikousky,jogurtovo-bylinkovydip	1a, 3, 5, 7, 9, 10, 11	300g Pasta Salad with Vegetables and Chicken Pieces, herb Yogurt Dip	6
1068	Rajská s tarhoňou	rajskastarhonou	1a, 3, 9	Tomato Soup with Durum Wheat Pasta	9
1498	150g Kokosové kuřecí kari se zázvorem a koriandrem, dušená rýže	150gkokosovekurecikarisezazvoremakoriandrem,dusenaryze	1a, 9, 10	150g Kokosové kuřecí kari se zázvorem a koriandrem, stewed Rice	2
1499	300g Těstoviny s kuřecím masem a sýrovou omáčkou, sypané sýrem	300gtestovinyskurecimmasemasyrovouomackou,sypanesyrem	1a, 3, 7, 9	300g Pasta with Chicken Meat and Cheese Sauce, sprinkled with Cheese	2
1765	120g Hamburger s trhaným vepřovým masem a čedarem, smažené hranolky, pivní majonéza	120ghamburgerstrhanymveprovymmasemacedarem,smazenehranolky,pivnimajoneza	1a, 3, 6, 7, 9, 10, 11, 13	120g Hamburger with Pulled Pork and Cheddar Cheese, french Fries (Fried Potato Chips), beer Mayonnaise	6
1766	300g Grilované žampiony, římský salát s okurkami, cherry rajčaty a kysanou smetanou	300ggrilovanezampiony,rimskysalatsokurkami,cherryrajcatyakysanousmetanou	3, 5, 7, 9, 10, 11	300g Grilled Champignons, romaine Lettuce with Cucumbers, Cherry Tomatoes and Sour Cream	6
1257	240g Pečené kuře ala bažant se zeleninou, divokým kořením a anglickou slaninou, jasmínová rýže	240gpecenekurealabazantsezeleninou,divokymkorenimaanglickouslaninou,jasminovaryze	1a, 3, 5, 7, 9, 10, 11	240g Roasted Chicken with Vegetables, Wild Spices and Bacon , jasmine Rice	2
302	130g Pečený losos na kari se zeleninou , vaječné nudle	130gpecenylososnakarisezeleninou,vajecnenudle	1a, 3, 4, 6, 7, 9, 10	130g Roasted Salmon with Curry and Vegetables, egg Noodles	2
1258	300g Veganské zeleninové ragů s uzeným tofu a pečenou paprikou, jasmínová rýže, bez lepku	300gveganskezeleninoveragusuzenymtofuapecenoupaprikou,jasminovaryze,bezlepku	6, 9	300g Vegan Vegetable Ragout with Smoked Tofu (Bean Curd) and Roasted Sweet Peppers, jasmine Rice, gluten Free	2
183	120g Přírodní kuřecí plátek, basmati rýže	120gprirodnikureciplatek,basmatiryze	1a, 9, 10	\N	1
1500	Sterilovaná polévka ve skle 0,7l - Rajská, Hovězí vývar	sterilovanapolevkaveskle0,7l-rajska,hovezivyvar		Sterilovaná polévka ve skle 0,7l - Rajská, Hovězí vývar	5
1501	120g Smažený kuřecí řízek, bramborový salát s majonézou	120gsmazenykurecirizek,bramborovysalatsmajonezou	1a, 1b, 3, 7, 9, 10	120g Fried Chicken Schnitzel, potato Salad with Mayonnaise	2
1767	150g Vepřové maso po Asijsku na špejli, pečené čínské nudle	150gveprovemasopoasijskunaspejli,pecenecinskenudle	1a, 6, 9, 10	150g Pork Skewer with Asian Spices, baked Noodles	2
1768	300g Zeleninový salát s grilovaným camembertem, opečená bageta, brusinkový dip	300gzeleninovysalatsgrilovanymcamembertem,opecenabageta,brusinkovydip	1a, 7, 10	300g Vegetable Salad with Grilled Camembert Cheese, toasted Baguette, cranberry Dip	2
157	120g Kuřecí steak s camembertem a pečenou kapií, šťouchané brambory	120gkurecisteakscamembertemapecenoukapii,stouchanebrambory	1a, 3, 5, 7, 9, 10, 11	120g Chicken Steak with Camembert Cheese and Roasted Sweet Capsicum, mashed Potatoes	2
1259	120g Medailonky z vepřové panenky, bramborové hranolky, salát Coleslaw	120gmedailonkyzveprovepanenky,bramborovehranolky,salatcoleslaw	1a, 1b, 3, 5, 7, 9, 10, 11	120g Pork Undercut Noisettes, potato French Fries, coleslaw (Cabbage Salad)	6
843	390g Pizza TRE FORMAGGI tomat, mozzarella, niva, uzený sýr	390gpizzatreformaggitomat,mozzarella,niva,uzenysyr	1a, 1b, 7	390g Pizza TRE FORMAGGI Tomato Purée, Edam Cheese, Blue Cheese, Smoked Cheese	8
1260	100g Vepřová panenka v bramboráku, trhaný salát, sýrový dip	100gveprovapanenkavbramboraku,trhanysalat,syrovydip	1a, 3, 7, 9	100g Pork Undercut in Fried Potato Pancake, shredded Lettuce, cheese Dip	6
1280	100g Smažený camembert, trhaný salát s cherry rajčaty a okurkami, perský dresink	100gsmazenycamembert,trhanysalatscherryrajcatyaokurkami,perskydresink		100g Fried Camembert Cheese, shredded Lettuce with Cherry Potatoes and Cucumbers, perský dresink	6
1261	300g Veganský čočkový salát s tofu nudličkami	300gveganskycockovysalatstofunudlickami	6, 9	300g Vegan Lentil Salad with 'Plant Protein' Noodles	6
498	200g Steak z vepřové krkovice, opékané brambory, steaková omáčka	200gsteakzveprovekrkovice,opekanebrambory,steakovaomacka	1a, 3, 5, 7, 9, 10, 11	200g Pork Neck Steak, roasted Potatoes, steak Sauce	2
1262	300g Veganské zeleninové ragů s uzeným tofu a pečenou paprikou, jasmínová rýže	300gveganskezeleninoveragusuzenymtofuapecenoupaprikou,jasminovaryze	6, 9	300g Vegan Vegetable Ragout with Smoked Tofu (Bean Curd) and Roasted Sweet Peppers, jasmine Rice	2
1263	120g Tortilla plněná kuřecí směsí se zeleninou, zeleninová ozdoba, smetanový dip	120gtortillaplnenakurecismesisezeleninou,zeleninovaozdoba,smetanovydip	1, 5, 7, 9, 10, 11	120g Tortilla Filled with Chicken Noodles and Vegetables, vegetable Garnish, creamy Dip	6
1264	300g POKE BOWL s trhaným vepřovým masem 	300gpokebowlstrhanymveprovymmasem	1a, 1b, 3, 5, 7, 9, 10, 11	300g Poke Bowl with Pulled Pork Meat	6
154	120g Kuřecí směs kung-pao s arašídy a zeleninou, opékané brambory	120gkurecismeskung-paosarasidyazeleninou,opekanebrambory	1, 3, 5, 6, 7, 9, 10, 11	\N	1
155	120g Kuřecí špíz s anglickou slaninou, paprikou a cibulí, dušená rýže	120gkurecispizsanglickouslaninou,paprikouacibuli,dusenaryze	1a, 1b, 9, 10	\N	2
156	120g Kuřecí steak s camembertem a pečenou kapií, dušená rýže	120gkurecisteakscamembertemapecenoukapii,dusenaryze	1a, 1b, 3, 5, 7, 9, 10, 11	\N	2
159	120g Linguinny s kuřecím masem, cherry rajčaty, chilli a sýrem gran biraghi	120glinguinnyskurecimmasem,cherryrajcaty,chilliasyremgranbiraghi	1a, 1b, 3, 6, 7, 9, 10	\N	2
160	120g Losos NAMBANZUKE s nakládanou zeleninou, jasmínová rýže	120glososnambanzukesnakladanouzeleninou,jasminovaryze	1a, 1b, 3, 4, 6, 7, 9	\N	6
161	120g Marinovaná vepřová kotleta, pepřová omáčka, pečené grenaile	120gmarinovanaveprovakotleta,peprovaomacka,pecenegrenaile	1a, 3, 5, 7, 9, 10, 11, 12	\N	1
162	120g Marinovaná vepřová kotleta, smetanová koňaková omáčka, dušená rýže	120gmarinovanaveprovakotleta,smetanovakonakovaomacka,dusenaryze	1a, 3, 5, 7, 9, 10, 11	\N	1
163	120g Marinované kuřecí řízky v jogurtu, smažené v panko strouhance, bramborové hranolky	120gmarinovanekurecirizkyvjogurtu,smazenevpankostrouhance,bramborovehranolky	1a, 1b, 3, 7	\N	6
164	120g Medailonky z vepřové panenky, smetanová koňaková omáčka, šťouchané brambory s cibulí	120gmedailonkyzveprovepanenky,smetanovakonakovaomacka,stouchanebramboryscibuli	1a, 3, 5, 7, 9, 10, 11	\N	2
165	120g Medailonky z vepřové panenky na slanině a rozmarýnu, dušená rýže	120gmedailonkyzveprovepanenkynaslaninearozmarynu,dusenaryze	1, 3, 5, 7, 9, 10, 11	\N	2
1273	Kroupová se zeleninou	kroupovasezeleninou	1c, 9	Barley Soup with Vegetables	9
1502	120g Porthaus z vepřové panenky s česnekem a sezamovou strouhankou, bramborové hranolky, trhaný salát	120gporthauszveprovepanenkyscesnekemasezamovoustrouhankou,bramborovehranolky,trhanysalat	1a, 1b, 3, 7, 9, 10, 11	120g Pork Undercut with Garlic and Sesame Crumbs, potato French Fries, shredded Lettuce	6
1286	2 Sterilovaná hotovka ve skle  -Kuřecí kousky na pepři,Frankfurtská pečeně,Boloňská směs,Vepřový vrabec	2sterilovanahotovkaveskle-kurecikouskynapepri,frankfurtskapecene,bolonskasmes,veprovyvrabec		2 Sterilovaná hotovka ve skle  -Kuřecí kousky na pepři,Frankfurtská pečeně,Boloňská směs,Vepřový vrabec	5
1503	Sterilovaná polévka ve skle 0,7l - Rajská,Kuřecí krémová,Cibulačka,Hovězí vývar,Boršč	sterilovanapolevkaveskle0,7l-rajska,kurecikremova,cibulacka,hovezivyvar,borsc		Sterilovaná polévka ve skle 0,7l - Rajská,Kuřecí krémová,Cibulačka,Hovězí vývar,Boršč	5
1504	2 Sterilovaná hotovka ve skle  -Masové kuličky s rajskou omáčkou,Vepřová krkovice s pepřovou omáčkou,Kuřecí kousky	2sterilovanahotovkaveskle-masovekulickysrajskouomackou,veprovakrkovicespeprovouomackou,kurecikousky		2 Sterilovaná hotovka ve skle  -Masové kuličky s rajskou omáčkou,Vepřová krkovice s pepřovou omáčkou,Kuřecí kousky	5
1505	3 Sterilovaná hotovka ve skle  -Chow-mein z vepřové panenky,Hovězí nudličky po znojemsku,Krůtí medailonky	3sterilovanahotovkaveskle-chow-meinzveprovepanenky,hovezinudlickypoznojemsku,krutimedailonky		3 Sterilovaná hotovka ve skle  -Chow-mein z vepřové panenky,Hovězí nudličky po znojemsku,Krůtí medailonky	5
169	120g Mozaiková sekaná se šunkou a sýrem, bramborová kaše, sterilovaný okurek	120gmozaikovasekanasesunkouasyrem,bramborovakase,sterilovanyokurek	1a, 3, 7, 9, 10	120g Minced Meat with Ham and Cheese , mashed Potatoes, gherkin	2
739	300g Teplý těstovinový salát z pečené máslové dýně, šalotky, středomořské zeleniny a feta sýrem	300gteplytestovinovysalatzpecenemaslovedyne,salotky,stredomorskezeleninyafetasyrem	1a, 3, 7, 9	300g Warm Pasta Salad with Roasted Butternut Squash, Shallots, Mediterranean Vegetables and Feta Cheese	2
647	300g Chana masala s pečenou paprikou, tofu a mangetout, jasmínová rýže, bez lepku	300gchanamasalaspecenoupaprikou,tofuamangetout,jasminovaryze,bezlepku	6, 9, 10	300g Chana Masala with Roasted Peppers, Tofu and Mangetout, jasmine Rice, gluten Free	2
520	250g Boloňské špagety s vepřovým masem, strouhaný sýr	250gbolonskespagetysveprovymmasem,strouhanysyr	1a, 3, 6, 7, 9, 10	250g Spaghetti Bolognese with Pork, grated Cheese	2
1031	Hrachová s uzeninou	hrachovasuzeninou	1a, 9	Pea Soup with Summer Sausage	9
230	120g Sous-vide kuřecí roláda se špenátem a slaninou, jasmínová rýže	120gsous-videkureciroladasespenatemaslaninou,jasminovaryze		\N	1
166	120g Medailonky z vepřové panenky se smetanovou koňakovou omáčkou, šťouchané brambory s cibulí	120gmedailonkyzveprovepanenkysesmetanovoukonakovouomackou,stouchanebramboryscibuli	1a, 3, 5, 7, 9, 10, 11	\N	2
210	120g Smažené kuřecí medailonky, bramborové hranolky	120gsmazenekurecimedailonky,bramborovehranolky	1a, 3, 7, 8, 8a	\N	6
170	120g Myslivecká hovězí pečeně se zeleninou, smetanou a slaninou, houskový knedlík	120gmysliveckahovezipecenesezeleninou,smetanouaslaninou,houskovyknedlik	1a, 3, 7, 9, 10	120g Roasted and Stewed Beef with Vegetables, Cream Sauce and Bacon, bread Dumplings	2
1287	2 Sterilovaná hotovka ve skle  - Masové kuličky s rajskou omáčkou,Segedínský guláš,Kuřecí směs,Vepřový vrabec se zelím,Kuřecí kousky	2sterilovanahotovkaveskle-masovekulickysrajskouomackou,segedinskygulas,kurecismes,veprovyvrabecsezelim,kurecikousky		2 Sterilovaná hotovka ve skle  - Masové kuličky s rajskou omáčkou,Segedínský guláš,Kuřecí směs,Vepřový vrabec se zelím,Kuřecí kousky	5
1288	3 Sterilovaná hotovka ve skle  -Chow-mein z vepřové panenky,Hovězí pečeně s koprovou omáčkou,Svíčková,Krůtí ragů	3sterilovanahotovkaveskle-chow-meinzveprovepanenky,hovezipeceneskoprovouomackou,svickova,krutiragu		3 Sterilovaná hotovka ve skle  -Chow-mein z vepřové panenky,Hovězí pečeně s koprovou omáčkou,Svíčková,Krůtí ragů	5
1289	Sterilovaná polévka ve skle 0,7l - Vývar, Kapustová, Kyselice s uz.masem, Z restovaných paprik s rajčaty, Rozbaš hrachová  s masem a raj., Gulášová s vepř.masem	sterilovanapolevkaveskle0,7l-vyvar,kapustova,kyselicesuz.masem,zrestovanychpapriksrajcaty,rozbashrachovasmasemaraj.,gulasovasvepr.masem		Soya Cheese with Onion	5
1290	3 Sterilovaná hotovka ve skle 0,7l - Hov. svíčková omáčka, Medailónky z vepř panenky, Hov.Stroganoff	3sterilovanahotovkaveskle0,7l-hov.svickovaomacka,medailonkyzveprpanenky,hov.stroganoff		3 Sterilovaná hotovka ve skle 0,7l - Hov. svíčková omáčka, Medailónky z vepř panenky, Hov.Stroganoff	5
1506	120g Porthaus z vepřové panenky s česnekem a sezamovou strouhankou, americké brambory, tatarská omáčka	120gporthauszveprovepanenkyscesnekemasezamovoustrouhankou,americkebrambory,tatarskaomacka	1a, 3, 7, 9, 10	120g Pork Undercut with Garlic and Sesame Crumbs, potato Wedges, tartar Sauce	6
1769	2 Sterilovaná hotovka ve skle  - Boloňská směs,Krkovice se steakovou omáčkou,Rajská s masovými kuličkami	2sterilovanahotovkaveskle-bolonskasmes,krkovicesesteakovouomackou,rajskasmasovymikulickami		2 Sterilovaná hotovka ve skle  - Boloňská směs,Krkovice se steakovou omáčkou,Rajská s masovými kuličkami	5
171	120g Nudličky z vepřové panenky se zeleninou, zázvorem a sezamem, rýžové nudle	120gnudlickyzveprovepanenkysezeleninou,zazvoremasezamem,ryzovenudle	1a, 1b, 3, 5, 6, 7, 9, 10, 11	\N	6
173	120g Pečený filet z nilského okouna, citronová nádivka s bazalkou, pyré z pečené karotky	120gpecenyfiletznilskehookouna,citronovanadivkasbazalkou,pyrezpecenekarotky	1a, 4, 5, 6, 7, 9, 10, 11	\N	2
175	120g Pečený vepřový vrabec, dušený špenát, vařené brambory	120gpecenyveprovyvrabec,dusenyspenat,varenebrambory	1a, 3, 7, 9, 10	\N	2
176	120g Pečený vepřový vrabec, karamelizované bavorské zelí s  jablky, bramborové halušky	120gpecenyveprovyvrabec,karamelizovanebavorskezelisjablky,bramborovehalusky	1a, 3, 9, 10, 12	\N	2
177	120g Pečený vepřový vrabec, karamelizované bavorské zelí s  jablky, bramborové noky	120gpecenyveprovyvrabec,karamelizovanebavorskezelisjablky,bramborovenoky	1a, 3, 9, 10	\N	2
638	300g Bulgureto s robi masem, brokolicí, cuketou, kápií a bylinkovým pestem, strouhaný sýr	300gbulguretosrobimasem,brokolici,cuketou,kapiiabylinkovympestem,strouhanysyr	1a, 6, 7	\N	1
639	300g Bulgureto s robi masem, zeleninou a pečenými rajčaty, sýr gran biraghi	300gbulguretosrobimasem,zeleninouapecenymirajcaty,syrgranbiraghi	1a, 6, 7	\N	2
248	120g Vepřové nudličky se zeleninou, bramborové hranolky	120gveprovenudlickysezeleninou,bramborovehranolky	1a, 9	\N	6
181	120g Plněný paprikový lusk v rajské omáčce, těstoviny fusilli	120gplnenypaprikovyluskvrajskeomacce,testovinyfusilli	1a, 3, 9	120g Bell Pepper Stuffed with Minced Meat, Tomato Sauce, pasta Twists (Fusilli)	1
178	120g Pikantní krůtí nudličky se zázvorem a zeleninou, kari rýže, bez lepku	120gpikantnikrutinudlickysezazvoremazeleninou,kariryze,bezlepku	6, 9, 10	120g Turkey Noodles with Ginger and Vegetables, curried Rice, gluten Free	2
1507	120g Smažený kuřecí řízek, bramborová kaše se smetanou	120gsmazenykurecirizek,bramborovakasesesmetanou	1a, 3, 7	120g Fried Chicken Schnitzel, mashed Potatoes with Cream	2
1508	120g Výpečky z divočáka, červené zelí s vínem a jablky, bramborový knedlík	120gvypeckyzdivocaka,cervenezelisvinemajablky,bramborovyknedlik	1a, 3, 9, 10, 12	120g Roast Wild Boar, red Cabbage with Wine and Apples, potato Dumpling	2
1509	300g Zeleninový hrnec s čočkou, pohankou, kroupami a uzeným tofu, bylinkový kuskus	300gzeleninovyhrnecscockou,pohankou,kroupamiauzenymtofu,bylinkovykuskus	1a, 6, 9, 10	300g Vegetable Casserole with Lentils, Buckwheat, Barley and Smoked Tofu (Bean Curd) , herb Couscous	2
1510	300g Nudle s mákem, vanilkovým cukrem a přepuštěným máslem	300gnudlesmakem,vanilkovymcukremaprepustenymmaslem	1a, 3, 7	300g Noodles with Poppy Seeds, Vanilla Sugar and Melted Butter	2
1511	Výpečky z divočáka, červené zelí s vínem a jablky, bramborový knedlík	vypeckyzdivocaka,cervenezelisvinemajablky,bramborovyknedlik	1a, 3, 9, 10, 12	Výpečky z divočáka, red Cabbage with Wine and Apples, potato Dumpling	2
1512	100g Smažený sýr, vařené brambory	100gsmazenysyr,varenebrambory		100g Fried Cheese, boiled Potatoes	6
1513	150g Sekaná pečeně, bramborová kaše, okurkový salát	150gsekanapecene,bramborovakase,okurkovysalat	1a, 3, 7, 9, 10	150g Roasted Minced Meat, mashed Potatoes, cucumber Salad	2
191	120g Přírodní vepřový řízek, šťouchané brambory, tatarská omáčka	120gprirodniveprovyrizek,stouchanebrambory,tatarskaomacka	1a, 3, 6, 7, 9, 10	120g Pork Schnitzel au Naturel, mashed Potatoes, tartar Sauce	2
1771	2 Sterilovaná hotovka ve skle  - Boloňská směs,Mozaiková sekaná	2sterilovanahotovkaveskle-bolonskasmes,mozaikovasekana		\N	5
1770	Sterilovaná polévka ve skle  0,7l - Z restovaných paprik,Gulášová,Brokolicový chowder,Kuřecí,Dýňová,Kulajda,Jemná pepřová omáčka,Sugo di Pomodora	sterilovanapolevkaveskle0,7l-zrestovanychpaprik,gulasova,brokolicovychowder,kureci,dynova,kulajda,jemnapeprovaomacka,sugodipomodora		Sterilovaná polévka ve skle  0,7l - Z restovaných paprik,Gulášová,Brokolicový chowder,Kuřecí,Dýňová,Kulajda,Jemná pepřová omáčka,Sugo di Pomodora	5
1296	300g Špagety carbonara s pančetou, vejci a strouhaným sýrem gran biraghi	300gspagetycarbonaraspancetou,vejciastrouhanymsyremgranbiraghi		300g Špagety carbonara s pančetou, vejci a strouhaným sýrem gran biraghi	6
179	120g Pikantní kuřecí medailonky, americké brambory, zeleninová obloha	120gpikantnikurecimedailonky,americkebrambory,zeleninovaobloha	1, 3, 9	\N	6
180	120g Pikantní vepřová pečeně se zeleninou, bramborové hranolky	120gpikantniveprovapecenesezeleninou,bramborovehranolky	9, 10	\N	6
182	120g Porthaus z vepřové panenky s česnekem a sezamovou strouhankou, bramborové hranolky, dip z modrého sýra	120gporthauszveprovepanenkyscesnekemasezamovoustrouhankou,bramborovehranolky,dipzmodrehosyra	1a, 3, 7, 9, 11	\N	6
184	120g Přírodní kuřecí plněná kapsa se šunkou a nivou, bramborové hranolky	120gprirodnikureciplnenakapsasesunkouanivou,bramborovehranolky	1a, 1b, 7	\N	6
185	120g Přírodní plněná kuřecí kapsa se zeleninovou nádivkou s pohankou a jablky, dušená rýže	120gprirodniplnenakurecikapsasezeleninovounadivkouspohankouajablky,dusenaryze	1a, 3, 9, 10	\N	1
186	120g Přírodní plněná kuřecí kapsa se zeleninovou nádivkou s pohankou a jablky, opékané brambory	120gprirodniplnenakurecikapsasezeleninovounadivkouspohankouajablky,opekanebrambory	3, 7, 9	\N	1
187	120g Přírodní plněná kuřecí kapsa se zeleninovou nádivkou s pohankou a jablky, smetanové brambory, bez lepku	120gprirodniplnenakurecikapsasezeleninovounadivkouspohankouajablky,smetanovebrambory,bezlepku	3, 7, 9	\N	2
188	120g Přírodní plněná kuřecí kapsa se zeleninovou nádivkou s pohankou a jablky, šťouchané brambory s cibulí	120gprirodniplnenakurecikapsasezeleninovounadivkouspohankouajablky,stouchanebramboryscibuli	1a, 3, 7, 10	\N	2
189	120g Přírodní vepřová kotleta, šťouchané brambory	120gprirodniveprovakotleta,stouchanebrambory	1a, 7, 10	\N	2
190	120g Přírodní vepřový řízek, šťouchané brambory	120gprirodniveprovyrizek,stouchanebrambory	1a, 3, 7, 9, 10	\N	2
192	120g Ražniči z kuřecího masa s anglickou slaninou, cibulí a paprikami, dušená rýže	120graznicizkurecihomasasanglickouslaninou,cibuliapaprikami,dusenaryze	1a, 9, 10	\N	2
193	120g Ražniči z kuřecího masa s klobásou, cibulí a paprikami, basmati rýže	120graznicizkurecihomasasklobasou,cibuliapaprikami,basmatiryze	1a, 9, 10	\N	1
194	120g Ražniči z kuřecího masa s klobásou, cibulí a paprikami, bylinková omáčka, bramborové hranolky	120graznicizkurecihomasasklobasou,cibuliapaprikami,bylinkovaomacka,bramborovehranolky	1a, 1b, 7, 9, 10	\N	6
195	120g Restované nudličky z krůtího masa se středomořskou zeleninou, rýžový pilaf	120grestovanenudlickyzkrutihomasasestredomorskouzeleninou,ryzovypilaf	1a, 1b, 3, 6, 7, 9, 10	\N	2
196	120g Restované nudličky z krůtího masa se středomořskou zeleninou, rýžový pilaf, bez lepku	120grestovanenudlickyzkrutihomasasestredomorskouzeleninou,ryzovypilaf,bezlepku	3, 6, 7, 9, 10	\N	2
1514	2 Sterilovaná hotovka ve skle  - Kuřecí kousky,Boloňská směs,Kuřecí kari	2sterilovanahotovkaveskle-kurecikousky,bolonskasmes,kurecikari		2 Sterilovaná hotovka ve skle  - Kuřecí kousky,Boloňská směs,Kuřecí kari	5
1304	Sterilovaná polévka ve skle 0,7l -Gulášová,Hovězí vývar,Dýňová,Slovenská kapustnice	sterilovanapolevkaveskle0,7l-gulasova,hovezivyvar,dynova,slovenskakapustnice		Sterilovaná polévka ve skle 0,7l -Gulášová,Hovězí vývar,Dýňová,Slovenská kapustnice	5
1305	2 Sterilovaná hotovka ve skle  -Boloňská směs,Vepřový vrabec,Frankfurtská pečeně,Kuřecí kousky na pepři	2sterilovanahotovkaveskle-bolonskasmes,veprovyvrabec,frankfurtskapecene,kurecikouskynapepri		2 Sterilovaná hotovka ve skle  -Boloňská směs,Vepřový vrabec,Frankfurtská pečeně,Kuřecí kousky na pepři	5
1515	3 Sterilovaná hotovka ve skle  - Znojemské nudličky, Svíčková omáčka, Kuřecí medailonky	3sterilovanahotovkaveskle-znojemskenudlicky,svickovaomacka,kurecimedailonky		3 Sterilovaná hotovka ve skle  - Znojemské nudličky, Svíčková omáčka, Kuřecí medailonky	5
197	120g Řízečky z panenky v panko strouhance, bramborové hranolky, bylinková creme fraiche	120grizeckyzpanenkyvpankostrouhance,bramborovehranolky,bylinkovacremefraiche	1a, 1b, 3, 7, 11	120g Undercut Schnitzels in Panko Crumbs, potato French Fries, herb Creme Fraiche	6
1772	2 Sterilovaná hotovka ve skle  - Boloňská směs,Mozaiková sekaná,Frankfurtská pečeně	2sterilovanahotovkaveskle-bolonskasmes,mozaikovasekana,frankfurtskapecene		2 Sterilovaná hotovka ve skle  - Boloňská směs,Mozaiková sekaná,Frankfurtská pečeně	5
1773	Sterilovaná polévka ve skle 0,7l -- Brokolicová,Fazolová,Dýňová,Z restovaných paprik,Sugo di Pomodoro,Pepřová omáčka	sterilovanapolevkaveskle0,7l--brokolicova,fazolova,dynova,zrestovanychpaprik,sugodipomodoro,peprovaomacka		Sterilovaná polévka ve skle 0,7l -- Brokolicová,Fazolová,Dýňová,Z restovaných paprik,Sugo di Pomodoro,Pepřová omáčka	5
1774	2 Sterilovaná hotovka ve skle  - Vrabec se zelím, Vepř.krkovice s pepř.om., Segedínský guláš, Boloňská směs	2sterilovanahotovkaveskle-vrabecsezelim,vepr.krkovicespepr.om.,segedinskygulas,bolonskasmes		2 Sterilovaná hotovka ve skle  - Vrabec se zelím, Vepř.krkovice s pepř.om., Segedínský guláš, Boloňská směs	5
1775	3 Sterilovaná hotovka ve skle  - Chow -main z vepř.panenky, Rajská s hov.masem	3sterilovanahotovkaveskle-chow-mainzvepr.panenky,rajskashov.masem		3 Sterilovaná hotovka ve skle  - Chow -main z vepř.panenky, Rajská s hov.masem	5
198	120g Řízečky z panenky v panko strouhance, opékané brambory, sweet chilli majonéza	120grizeckyzpanenkyvpankostrouhance,opekanebrambory,sweetchillimajoneza	1a, 3, 6, 7, 10, 11	\N	6
199	120g Řízečky z vepřové panenky, bramborové hranolky, česnekový dip	120grizeckyzveprovepanenky,bramborovehranolky,cesnekovydip	1a, 1b, 3, 7	\N	6
200	120g Řízečky z vepřové panenky, opékané brambory, sweet chilli majonéza	120grizeckyzveprovepanenky,opekanebrambory,sweetchillimajoneza	1a, 3, 6, 7, 10	\N	6
268	120g Zvěřinový guláš ze srnčího masa, houskový knedlík	120gzverinovygulaszesrncihomasa,houskovyknedlik	1a, 3, 7, 9, 10	\N	1
1306	300g Kynuté knedlíky s jahodami, skořicová drobenka, přepuštěné máslo	300gkynuteknedlikysjahodami,skoricovadrobenka,prepustenemaslo		300g Yeast Dumplings with Strawberries, cinnamon Crumble, melted Butter	2
845	3 Sterilovaná hotovka ve skle  -- Hovězí nudličky po znojemsku,Hovězí guláš,Hovězí pečeně s rajskou omáčkou,Vepřové medailonky se steakovou omáčkou,Hovězí stroganoff,Svíčková,Krůtí medailonky	3sterilovanahotovkaveskle--hovezinudlickypoznojemsku,hovezigulas,hovezipecenesrajskouomackou,veprovemedailonkysesteakovouomackou,hovezistroganoff,svickova,krutimedailonky		\N	5
1516	150g Kuřecí steak s bylinkovou omáčkou, americké brambory	150gkurecisteaksbylinkovouomackou,americkebrambory	1a, 1b, 7, 9	150g Chicken Steak in Herbal Sauce, potato Wedges	6
1776	120g Přírodní vepřový řízek, smažené hranolky, zeleninová ozdoba	120gprirodniveprovyrizek,smazenehranolky,zeleninovaozdoba	1a, 9, 10	120g Pork Schnitzel au Naturel, french Fries (Fried Potato Chips), vegetable Garnish	1
303	130g Pečený losos s citronovým pepřem, fazolky na másle, pečené grenaile	130gpecenylososscitronovympeprem,fazolkynamasle,pecenegrenaile	4, 7	\N	2
204	120g Sekaná vepřová pečeně, rajská omáčka, těstoviny dvojkolena	120gsekanaveprovapecene,rajskaomacka,testovinydvojkolena	1a, 1b, 3, 7, 9, 10	\N	2
205	120g Smažená vepřová krkovička, bramborové hranolky, tatarská omáčka	120gsmazenaveprovakrkovicka,bramborovehranolky,tatarskaomacka	1a, 3, 7, 10	\N	6
1274	120g Pečené masové kuličky, rajská omáčka, těstoviny kolena	120gpecenemasovekulicky,rajskaomacka,testovinykolena	1a, 3, 7, 9, 10	120g Oven-baked Meatballs, tomato Sauce, elbow Maccaroni	2
1517	120g Pikantní krůtí nudličky se zázvorem a zeleninou, dušená rýže	120gpikantnikrutinudlickysezazvoremazeleninou,dusenaryze	6, 9, 10	120g Turkey Noodles with Ginger and Vegetables, stewed Rice	2
1777	Zelňačka s uzeným masem	zelnackasuzenymmasem	1a, 7, 9, 10	Sauerkraut Soup with Smoked Meat	9
1778	120g Salát s kuřecími goujony, čerstvou zeleninou a sweet chilli majonézou	120gsalatskurecimigoujony,cerstvouzeleninouasweetchillimajonezou	1a, 1b, 3, 6, 7, 9, 10	120g Salad with Chicken Goujons, Fresh Vegetables and Sweet Chilli Mayonnaise	6
1779	150g Kuřecí Cordon Blue se šunkou a sýrem, šťouchané brambory	150gkurecicordonbluesesunkouasyrem,stouchanebrambory	1a, 3, 7, 9, 10	150g Chicken Cordon Bleu with Ham and Cheese, mashed Potatoes	2
439	150g Trhaná vepřová krkovice marinovaná v teriyaki omáčce s česnekem a chilli, jasmínová rýže	150gtrhanaveprovakrkovicemarinovanavteriyakiomaccescesnekemachilli,jasminovaryze	1a, 3, 6, 7, 9, 10	150g Pulled Pork Neck Marinated in Teriyaki Sauce with Garlic and Chilli, jasmine Rice	2
1275	120g Kuřecí prso na barevném pepři se smetanovou omáčkou, šťouchané brambory	120gkureciprsonabarevnempeprisesmetanovouomackou,stouchanebrambory	1a, 3, 5, 7, 9, 10, 11	120g Chicken Breast with Peppercorns and Creamy Sauce, mashed Potatoes	2
1276	300g Míchané vaječné nudle se stir-fry zeleninou, bok choi a tofu po sečuánsku	300gmichanevajecnenudlesestir-fryzeleninou,bokchoiatofuposecuansku	1a, 3, 6, 7, 9, 10	300g Míchané vaječné nudle se stir-fry zeleninou, bok choi a tofu po sečuánsku	2
1277	130g Smažený hejk v panko strouhance, karotkové pyré	130gsmazenyhejkvpankostrouhance,karotkovepyre	1a, 3, 4, 5, 6, 7, 9, 10, 11	130g Sea Pike Fried in Panko Crumbs, carrot Purée	2
1278	120g Medové kuřecí kousky s pórkem a paprikou, jasmínová rýže, bez lepku	120gmedovekurecikouskysporkemapaprikou,jasminovaryze,bezlepku	6, 9, 10	120g Chicken Bites with Honey, Leek and Sweet Pepper, jasmine Rice, gluten Free	2
1279	120g Bruselská bageta-kuřecí kousky, hořčičná mayo, niva, karamelizovaná cibule, bramborové hranolky	120gbruselskabageta-kurecikousky,horcicnamayo,niva,karamelizovanacibule,bramborovehranolky	1a, 1b, 3, 7, 10	120g Bruselská bageta-kuřecí kousky, hořčičná mayo, niva, karamelizovaná cibule, potato French Fries	6
977	480g Pizza BELLO tomat,v.šunka, anglická slanina,mozzarella,žampiony,černé olivy	480gpizzabellotomat,v.sunka,anglickaslanina,mozzarella,zampiony,cerneolivy	1a, 1b, 7	480g Pizza BELLO Tomato Purée, Ham, Bacon, Champignons, Black Olives	8
975	470g Pizza AL TONNO tomat, tuňák, cibule,mozzarella	470gpizzaaltonnotomat,tunak,cibule,mozzarella	1a, 1b, 4, 7	470g Pizza AL TONNO Tomato Purée, Tuna, Onion, Edam Cheese	8
1281	120g Pečené masové kuličky, rajská omáčka, těstoviny	120gpecenemasovekulicky,rajskaomacka,testoviny	1a, 3, 7, 9, 10	120g Oven-baked Meatballs, tomato Sauce, Pasta	2
1282	120g Medové kuřecí kousky s pórkem a paprikou, jasmínová rýže	120gmedovekurecikouskysporkemapaprikou,jasminovaryze	6, 9, 10	120g Chicken Bites with Honey, Leek and Sweet Pepper, jasmine Rice	2
1307	Slepičí s játrovou rýží a zeleninou	slepicisjatrovouryziazeleninou	1a, 3, 9	Hen Soup with Small Liver Pieces and Vegetables	9
211	120g Smažené kuřecí medailonky, bramborové hranolky, sweet chilli dip	120gsmazenekurecimedailonky,bramborovehranolky,sweetchillidip	1a, 1b, 3, 5, 6, 7, 8, 8a, 9, 10, 11	120g Fried Chicken Noisettes, chips with Sweet Chilli Dip	6
1518	120g Zapečená vepřová kotleta se zeleninovou směsí a sýrem, mačkané brambory	120gzapecenaveprovakotletasezeleninovousmesiasyrem,mackanebrambory	1a, 7, 9, 10	120g Baked Pork Chop with Mixed Vegetables and Cheese, crushed Potatoes	2
1315	3 Sterilovaná hotovka ve skle  - Vepřové medailonky se steakovou om.,Hovězí svíčková,Krůtí medailonky,Znojemské hovězí nudličky,Kuřecí medailonky	3sterilovanahotovkaveskle-veprovemedailonkysesteakovouom.,hovezisvickova,krutimedailonky,znojemskehovezinudlicky,kurecimedailonky		3 Sterilovaná hotovka ve skle  - Vepřové medailonky se steakovou om.,Hovězí svíčková,Krůtí medailonky,Znojemské hovězí nudličky,Kuřecí medailonky	5
1519	300g Míchané tofu se zeleninou, bulgurem a peperonátou, sýr gran biraghi	300gmichanetofusezeleninou,bulguremapeperonatou,syrgranbiraghi	1a, 6, 7	300g Mixed Tofu with Vegetables, Bulgur and Peperonata, gran Biraghi Cheese	2
1317	Sterilovaná polévka ve skle 0,- Hovězí vývar,Dýňová,Slovenská kapustnice,Gulášová	sterilovanapolevkaveskle0,-hovezivyvar,dynova,slovenskakapustnice,gulasova		Sterilovaná polévka ve skle 0,- Hovězí vývar,Dýňová,Slovenská kapustnice,Gulášová	5
1520	130g Pečený filet z duhového pstruha na kmíně a česneku, pyré z mrkve, zázvoru a brambor, máslová omáčka	130gpecenyfiletzduhovehopstruhanakmineacesneku,pyrezmrkve,zazvoruabrambor,maslovaomacka	1, 4, 7, 9, 10, 12	130g Roasted Rainbow Trout Fillet with Caraway and Garlic, potato Purée with Carrot and Ginger, butter Sauce	2
1521	300g Proteinové krůtí ragů s luštěninami a zeleninou, rýžový pilaf, bez lepku	300gproteinovekrutiraguslusteninamiazeleninou,ryzovypilaf,bezlepku	9	300g Protein Turkey Ragout with Legumes and Vegetables, rice Pilaf, gluten Free	2
1522	120g Grilovaná vepřová panenka, bramborové hranolky, trhaný salát, bylinkový dip	120ggrilovanaveprovapanenka,bramborovehranolky,trhanysalat,bylinkovydip	1a, 1b, 7, 9, 10	120g Grilled Pork Undercut, potato French Fries, shredded Lettuce, Herbal Dip	6
1523	100g Hermelín na grilu, trhaný salát, brusinkový dip	100ghermelinnagrilu,trhanysalat,brusinkovydip	1a, 7, 9	100g Grilled Camembert, shredded Lettuce, cranberry Dip	6
1524	Zapečená vepřová kotleta se zeleninovou směsí a sýrem, mačkané brambory	zapecenaveprovakotletasezeleninovousmesiasyrem,mackanebrambory	1a, 7, 9, 10	Baked Pork Chop with Mixed Vegetables and Cheese, crushed Potatoes	2
1525	350g Míchané tofu se zeleninou, bulgurem a peperonátou, sýr gran biraghi	350gmichanetofusezeleninou,bulguremapeperonatou,syrgranbiraghi	1a, 6, 7	350g Mixed Tofu with Vegetables, Bulgur and Peperonata, gran Biraghi Cheese	2
1526	Proteinové krůtí ragů s luštěninami a zeleninou, rýžový pilaf, bez lepku	proteinovekrutiraguslusteninamiazeleninou,ryzovypilaf,bezlepku	9	Protein Turkey Ragout with Legumes and Vegetables, rice Pilaf, gluten Free	2
1527	120g Kuřecí goujons, opékané brambory, sweet chilli majonéza	120gkurecigoujons,opekanebrambory,sweetchillimajoneza	1a, 3, 7, 10	120g Chicken Goujons, roasted Potatoes, sweet Chilli Mayonnaise	6
1528	100g Grilovaný camembert, trhaný salát s cherry rajčaty a okurkami, jogurtový dip	100ggrilovanycamembert,trhanysalatscherryrajcatyaokurkami,jogurtovydip	1, 3, 5, 7, 9, 10, 11	100g Grilled Camembert, shredded Lettuce with Cherry Potatoes and Cucumbers, yogurt Dip	6
1529	150g Medailonky z vepřové panenky, pepřová omáčka, smažené hranolky	150gmedailonkyzveprovepanenky,peprovaomacka,smazenehranolky	1a, 3, 5, 7, 9, 10, 11, 12	150g Pork Undercut Noisettes, peppercorn Sauce, french Fries (Fried Potato Chips)	2
1530	120g Grilovaný camembert v anglické slanině, vařené brambory, trhané saláty	120ggrilovanycamembertvanglickeslanine,varenebrambory,trhanesalaty	1, 3, 5, 7, 9, 10, 11	120g Grilled Camembert Cheese Wrapped in Bacon, boiled Potatoes, shredded Lettuce	2
1531	300g Těstovinový salát se zeleninou, kuřecí kousky, bylinkový dresink	300gtestovinovysalatsezeleninou,kurecikousky,bylinkovydresink	1a, 3, 9	300g Pasta Salad with Vegetables, chicken Pieces, herb Dressing	2
1780	3 Sterilovaná hotovka ve skle  - Hovězí guláš,Hovězí pečeně s koprovou om.,Chow - Mein z vepřové panenky	3sterilovanahotovkaveskle-hovezigulas,hovezipeceneskoprovouom.,chow-meinzveprovepanenky		3 Sterilovaná hotovka ve skle  - Hovězí guláš,Hovězí pečeně s koprovou om.,Chow - Mein z vepřové panenky	5
1781	Sterilovaná polévka ve skle 0,7l -- Brokolicová,Fazolová,Dýňová,Kyselice,Kuřecí vývar,Z restovaných paprik,Sugo di Pomodoro,Pepřová omáčka	sterilovanapolevkaveskle0,7l--brokolicova,fazolova,dynova,kyselice,kurecivyvar,zrestovanychpaprik,sugodipomodoro,peprovaomacka		Sterilovaná polévka ve skle 0,7l -- Brokolicová,Fazolová,Dýňová,Kyselice,Kuřecí vývar,Z restovaných paprik,Sugo di Pomodoro,Pepřová omáčka	5
1782	2 Sterilovaná hotovka ve skle  -Vepřová boloňská směs,Vepřová pečeně s frankfurtskou omáčkou	2sterilovanahotovkaveskle-veprovabolonskasmes,veprovapecenesfrankfurtskouomackou		2 Sterilovaná hotovka ve skle  -Vepřová boloňská směs,Vepřová pečeně s frankfurtskou omáčkou	5
349	150g Kuřecí prsa plněná mozzarellou a sušenými rajčaty, šťouchané brambory, bazalková omáčka	150gkureciprsaplnenamozzarellouasusenymirajcaty,stouchanebrambory,bazalkovaomacka		\N	2
209	120g Smažené kuřecí kousky marinované v jogurtu, opékané brambory, sweet chilli majonéza	120gsmazenekurecikouskymarinovanevjogurtu,opekanebrambory,sweetchillimajoneza	1a, 3, 6, 7, 10	\N	6
707	300g Ragú z červené řepy s batáty, dýní a baby karotkami, dušená rýže, bez lepku	300graguzcervenerepysbataty,dyniababykarotkami,dusenaryze,bezlepku	9, 12	\N	2
212	120g Smažené kuřecí medailonky, bramborové hranolky, trhaný salát	120gsmazenekurecimedailonky,bramborovehranolky,trhanysalat	1a, 3, 7, 8, 8a, 9	\N	6
213	120g Smažené kuřecí medailonky, opékané brambory, smetanový dip	120gsmazenekurecimedailonky,opekanebrambory,smetanovydip	1a, 3, 7, 10	\N	6
214	120g Smažené kuřecí řízečky, opékané brambory, smetanový dip	120gsmazenekurecirizecky,opekanebrambory,smetanovydip	1a, 3, 7	\N	6
216	120g Smažené rybí filé s citronem, vařené brambory, trhaný salát	120gsmazenerybifilescitronem,varenebrambory,trhanysalat	1a, 3, 4, 7, 9, 10	\N	2
344	150g Kuřecí kung-pao, dušená rýže	150gkurecikung-pao,dusenaryze	1, 3, 5, 6, 7, 9, 10, 11	\N	2
226	120g Smažený sýr, vařené brambory, tatarská omáčka	120gsmazenysyr,varenebrambory,tatarskaomacka	1a, 3, 7, 9, 10	120g Fried Cheese, boiled Potatoes, tartar Sauce	2
220	120g Smažený řízek z vepřové kotlety, bramborový salát s jablky	120gsmazenyrizekzveprovekotlety,bramborovysalatsjablky	1a, 3, 7, 9, 10	120g Fried Pork Cutlet Schnitzel, potato Salad with Apples	2
1532	3 Sterilovaná hotovka ve skle  - Znojemské hovězí nudličky,Chow-Mein z vepřové panenky,Medailonky z vepřové panenky	3sterilovanahotovkaveskle-znojemskehovezinudlicky,chow-meinzveprovepanenky,medailonkyzveprovepanenky		3 Sterilovaná hotovka ve skle  - Znojemské hovězí nudličky,Chow-Mein z vepřové panenky,Medailonky z vepřové panenky	5
1533	3 Sterilovaná hotovka ve skle  - Kuřecí medailonky, Znojemské nudličky	3sterilovanahotovkaveskle-kurecimedailonky,znojemskenudlicky		3 Sterilovaná hotovka ve skle  - Kuřecí medailonky, Znojemské nudličky	5
1783	3 Sterilovaná hotovka ve skle  -Hovězí pečeně s rajskou omáčkou,Chow-mein z vepřové panenky	3sterilovanahotovkaveskle-hovezipecenesrajskouomackou,chow-meinzveprovepanenky		3 Sterilovaná hotovka ve skle  -Hovězí pečeně s rajskou omáčkou,Chow-mein z vepřové panenky	5
1784	2 Sterilovaná hotovka ve skle 0,7l - Frankfurtska vepř.pečeně, Boloňská vepř. směs, Vepř.krkovice s pepř.omáčkou	2sterilovanahotovkaveskle0,7l-frankfurtskavepr.pecene,bolonskavepr.smes,vepr.krkovicespepr.omackou		2 Sterilovaná hotovka ve skle 0,7l - Frankfurtska vepř.pečeně, Boloňská vepř. směs, Vepř.krkovice s pepř.omáčkou	5
1785	3 Sterilovaná hotovka ve skle 0,7l - Chow-mein z vepř.panenky, Hov.maso, rajská omáčka, Krůtí ragu se smet.a zelen., Hovězí po burgunsku	3sterilovanahotovkaveskle0,7l-chow-meinzvepr.panenky,hov.maso,rajskaomacka,krutiragusesmet.azelen.,hovezipoburgunsku		3 Sterilovaná hotovka ve skle 0,7l - Chow-mein z vepř.panenky, Hov.maso, rajská omáčka, Krůtí ragu se smet.a zelen., Hovězí po burgunsku	5
1786	120g Steak z vepřové pečeně, pepřová omáčka, opékané brambory	120gsteakzveprovepecene,peprovaomacka,opekanebrambory	1a, 5, 7, 9, 10, 11, 12	120g Roasted Pork Steak, peppercorn Sauce, roast Potatoes	1
919	3 Sterilovaná hotovka ve skle  -  Vepřové medailonky s jemnou steakovou om.,Krůtí medailonky,Hovězí guláš	3sterilovanahotovkaveskle-veprovemedailonkysjemnousteakovouom.,krutimedailonky,hovezigulas		\N	5
359	150g Kuřecí řízek Ondráš smažený v bramborákovém těstě, trhaný salát	150gkurecirizekondrassmazenyvbramborakovemteste,trhanysalat		\N	2
361	150g Kuřecí směs na kari se zeleninou, pečené kari nudle	150gkurecismesnakarisezeleninou,pecenekarinudle		\N	6
217	120g Smažený holandský řízek, vařené brambory s máslem, sterilovaný okurek	120gsmazenyholandskyrizek,varenebramborysmaslem,sterilovanyokurek	1a, 3, 7, 9	\N	2
218	120g Smažený holandský řízek s goudou, bramborová kaše	120gsmazenyholandskyrizeksgoudou,bramborovakase	1a, 3, 7, 9	\N	2
219	120g Smažený kuřecí řízek, vařené brambory s máslem	120gsmazenykurecirizek,varenebramborysmaslem	1a, 3, 7, 9, 10	\N	2
222	120g Smažený řízek z vepřové panenky, bramborové hranolky	120gsmazenyrizekzveprovepanenky,bramborovehranolky	1a, 1b, 3, 7	\N	6
223	120g Smažený řízek z vepřové panenky, bramborové hranolky, česnekový dip	120gsmazenyrizekzveprovepanenky,bramborovehranolky,cesnekovydip	1a, 1b, 3, 7	\N	6
224	120g Smažený řízek z vepřové panenky, bramborový salát s majonézou	120gsmazenyrizekzveprovepanenky,bramborovysalatsmajonezou	1a, 1b, 3, 7, 9, 10	\N	6
225	120g Smažený řízek z vepřové panenky, šťouchané brambory	120gsmazenyrizekzveprovepanenky,stouchanebrambory	1a, 3, 7	\N	2
1323	300g Tvarohové knedlíky ovocné, mandlová strouhanka, přepuštěné máslo	300gtvarohoveknedlikyovocne,mandlovastrouhanka,prepustenemaslo		300g Quark Dumplings Filled with Fruits, almond Breadcrumbs, Melted Butter	2
1534	2 Sterilovaná hotovka ve skle  -Masové kuličky s rajskou omáčkou,Vepřová krkovice s pepřovou omáčkou	2sterilovanahotovkaveskle-masovekulickysrajskouomackou,veprovakrkovicespeprovouomackou		2 Sterilovaná hotovka ve skle  -Masové kuličky s rajskou omáčkou,Vepřová krkovice s pepřovou omáčkou	5
1535	100g Hermelín na grilu, bramborové hranolky, trhaný salát, brusinkový dip	100ghermelinnagrilu,bramborovehranolky,trhanysalat,brusinkovydip	7, 9, 12	100g Grilled Camembert, potato French Fries, shredded Lettuce, Cranberry Dip	6
1536	300g Proteinové krůtí ragů s luštěninami a zeleninou, rýžový pilaf	300gproteinovekrutiraguslusteninamiazeleninou,ryzovypilaf	9	300g Protein Turkey Ragout with Legumes and Vegetables, rice Pilaf	2
1787	300g Zeleninový hrnec s čočkou, pohankou, kroupami a uzeným tofu, dušená rýže	300gzeleninovyhrnecscockou,pohankou,kroupamiauzenymtofu,dusenaryze	1a, 3, 6, 7, 9, 10	300g Vegetable Casserole with Lentils, Buckwheat, Barley and Smoked Tofu (Bean Curd) , stewed Rice	1
1788	300g Luštěninové ragů s pečenou podzimní zeleninou a rajčaty, dušená rýže, bez lepku	300glusteninoveraguspecenoupodzimnizeleninouarajcaty,dusenaryze,bezlepku	9, 10	300g Lentil Ragout with Roasted Autumn Vegetables and Tomatoes, stewed Rice, gluten Free	1
227	120g Smažený vepřový karbenátek, mačkané brambory, kyselý okurek	120gsmazenyveprovykarbenatek,mackanebrambory,kyselyokurek	1a, 3, 7, 9, 10	\N	2
1537	Mrkvová se zakysanou smetanou a dýňovými semínky 	mrkvovasezakysanousmetanouadynovymiseminky	7, 9	Carrot Soup with Sour Cream and Pumpkin Seeds	9
1538	300g Bramborové knedlíky plněné uzeným masem s dušeným zelím a osmaženou cibulkou	300gbramboroveknedlikyplneneuzenymmasemsdusenymzelimaosmazenoucibulkou	1a, 3, 9, 10	300g Potato Dumplings Stuffed with Smoked Meat, with Stewed Cabbage and Fried Onion	2
1324	Slepičí vývar s játrovou rýží a nudlemi	slepicivyvarsjatrovouryzianudlemi		Chicken Broth with Liver Rice and Noodles	9
1539	240g Nadívané kuřecí stehno s jarní nádivkou, přírodní šťáva s bylinkami, jasmínová rýže	240gnadivanekurecistehnosjarninadivkou,prirodnistavasbylinkami,jasminovaryze	1a, 3, 5, 7, 9, 10, 11	240g Stuffed Chicken Leg with Spring Stuffing, herb Sauce, jasmínová rýže	2
1540	200g Smažené žampiony, vařené brambory, tatarská omáčka	200gsmazenezampiony,varenebrambory,tatarskaomacka	1a, 3, 7, 10	200g Fried Champignons, boiled Potatoes, tartar Sauce	2
1541	130g Pečená bylinková treska, rattatouille ze středomořské zeleniny, mačkané brambory s pórkem	130gpecenabylinkovatreska,rattatouillezestredomorskezeleniny,mackanebramborysporkem	1, 4, 5, 6, 7, 9, 10, 11	130g Roasted Codfish with Herbs, ratatouille with Mediterranean Vegetables, crushed Potatoes with Leek	2
1542	150g Smetanové kuřecí kousky s dýní, batáty a karotkou, jasmínová rýže, bez lepku	150gsmetanovekurecikouskysdyni,batatyakarotkou,jasminovaryze,bezlepku	7, 9	150g Creamy Chicken Bites with Pumpkin, Sweet Potato and Carrot, jasmine Rice, gluten Free	2
521	250g Bramborové knedlíky plněné uzeným masem s dušeným zelím a osmaženou cibulkou	250gbramboroveknedlikyplneneuzenymmasemsdusenymzelimaosmazenoucibulkou	1a, 3, 9, 10	250g Potato Dumplings Stuffed with Smoked Meat, with Stewed Cabbage and Fried Onion	2
1543	300g Smažené žampiony, vařené brambory, tatarská omáčka	300gsmazenezampiony,varenebrambory,tatarskaomacka	1a, 3, 7, 10	300g Fried Champignons, boiled Potatoes, tartar Sauce	2
1544	Mrkvový krém	mrkvovykrem	1a, 7, 9	Carrot Custard	9
1545	150g Vepřová roláda plněná směsí z mletého masa, špenátu a žampionů, bramborová kaše, okurkový salát	150gveprovaroladaplnenasmesizmletehomasa,spenatuazampionu,bramborovakase,okurkovysalat	1a, 7, 9	150g Vepřová roláda plněná směsí z mletého masa, špenátu a žampionů, mashed Potatoes, cucumber Salad	2
1546	150g Kuřecí špíz s anglickou slaninou, paprikou a cibulí, dušená rýže, okurkový salát	150gkurecispizsanglickouslaninou,paprikouacibuli,dusenaryze,okurkovysalat	1, 3, 5, 7, 9, 10, 11	150g Chicken Skewer with Bacon, Peppers and Onions, stewed Rice, cucumber Salad	2
1547	300g Zeleninový salát s pečeným květákem, chřestem a kuřecími kousky, opečená bageta	300gzeleninovysalatspecenymkvetakem,chrestemakurecimikousky,opecenabageta	1a, 7	300g Zeleninový salát s pečeným květákem, chřestem a kuřecími kousky, toasted Baguette	2
1789	300g Chana masala s pečenou paprikou, tofu a mangetout, dušená rýže	300gchanamasalaspecenoupaprikou,tofuamangetout,dusenaryze	6, 9, 10	300g Chana Masala with Roasted Peppers, Tofu and Mangetout, stewed Rice	2
427	150g Směs z vepřové panenky na kari se zeleninou, smažené krokety	150gsmeszveprovepanenkynakarisezeleninou,smazenekrokety		\N	2
229	120g Sous - vide kuřecí roláda se slaninou a špenátem, dušená rýže	120gsous-videkureciroladaseslaninouaspenatem,dusenaryze	1a, 1b, 3, 6, 7, 9, 12	\N	1
231	120g Sous-vide kuřecí roláda se špenátem a slaninou, jasmínová rýže, tymiánový jus	120gsous-videkureciroladasespenatemaslaninou,jasminovaryze,tymianovyjus	1, 3, 6, 7, 9, 12	\N	2
233	120g Španělský ptáček, jasmínová rýže	120gspanelskyptacek,jasminovaryze	1a, 3, 7, 9, 10	\N	2
237	120g Tortilla s kuřecím masem a zeleninou, dip z kysané smetany, zeleninová obloha	120gtortillaskurecimmasemazeleninou,dipzkysanesmetany,zeleninovaobloha	1a, 3, 5, 7, 9, 10, 11	120g Tortilla Filled with Chicken Meat and Vegetables, sour Cream Dip, vegetable Garnish	6
1548	Sterilovaná polévka ve skle  0,7l - Gulášová,Valašská kyselice,Z restovaných paprik,Boršč,Cibulačka,Slovenská kapustnica,Brokolicový krémový chowder,Kuřecí,Jemná pepřová omáčka	sterilovanapolevkaveskle0,7l-gulasova,valasskakyselice,zrestovanychpaprik,borsc,cibulacka,slovenskakapustnica,brokolicovykremovychowder,kureci,jemnapeprovaomacka		Sterilovaná polévka ve skle  0,7l - Gulášová,Valašská kyselice,Z restovaných paprik,Boršč,Cibulačka,Slovenská kapustnica,Brokolicový krémový chowder,Kuřecí,Jemná pepřová omáčka	5
1549	2 Sterilovaná hotovka ve skle  - Kuřecí kousky,Kuřecí kari	2sterilovanahotovkaveskle-kurecikousky,kurecikari		2 Sterilovaná hotovka ve skle  - Kuřecí kousky,Kuřecí kari	5
1550	120g Zapečená vepřová kotleta se zeleninovou směsí, mačkané brambory	120gzapecenaveprovakotletasezeleninovousmesi,mackanebrambory	1a, 7, 9, 10	120g Scalloped Pork Cutlet with Vegetable Mix, crushed Potatoes	1
1551	3 Sterilovaná hotovka ve skle  -Hovězí svíčková,Kuřecí medailonky,Znojemské nudličky	3sterilovanahotovkaveskle-hovezisvickova,kurecimedailonky,znojemskenudlicky		3 Sterilovaná hotovka ve skle  -Hovězí svíčková,Kuřecí medailonky,Znojemské nudličky	5
239	120g Toskánské pappardelle s vepřovým masem, rajčaty a strouhaným sýrem	120gtoskanskepappardellesveprovymmasem,rajcatyastrouhanymsyrem	1a, 3, 6, 7, 9, 10, 11, 12	120g Toscani Pappardelle with Pork Meat, Tomatoes and Cheese Crumbs	2
1790	120g Smažený kuřecí řízek, bramborová kaše s máslem	120gsmazenykurecirizek,bramborovakasesmaslem	1a, 3, 7	120g Fried Chicken Schnitzel, mashed Potatoes with Butter	2
1791	120g Uzená pečeně se smetanovou křenovou omáčkou, houskový knedlík	120guzenapecenesesmetanovoukrenovouomackou,houskovyknedlik	1a, 3, 7, 9	120g Smoked Pork Roast with Creamy Horseradish Sauce, bread Dumplings	2
1792	300g Sýrové tortelliny s pestem ze sušených rajčat s bazalkou, rukolou a strouhaným sýrem	300gsyrovetortellinyspestemzesusenychrajcatsbazalkou,rukolouastrouhanymsyrem	1a, 3, 7, 9	300g Cheese Tortellini with Pesto Sauce (Dried Tomatoes, Basil), Rocket Salad and Cheese Crumbs	2
1793	300g Palačinky s marmeládou, karamelovou omáčkou butter - scotch a šlehačkou	300gpalacinkysmarmeladou,karamelovouomackoubutter-scotchaslehackou	1a, 3, 7	300g Pancakes with Jam, Butterscotch Caramel Custard and Whipped Cream	2
1794	120g Vepřové medailonky s pepřovou omáčkou, bramborové hranolky	120gveprovemedailonkyspeprovouomackou,bramborovehranolky	1a, 1b, 3, 5, 7, 9, 10, 11, 12	120g Pork Noisettes with Peppercorn Sauce, potato French Fries	6
1795	370g Pizza LUCIA tomat, klobása, feferonky, niva,mozzarella	370gpizzaluciatomat,klobasa,feferonky,niva,mozzarella	1a, 1b, 7, 10	370g Pizza LUCIA Tomato Purée, Sausage Hot Pepper, Blue Cheese, Edam Cheese	8
1796	100g Smažený hermelín, vařené brambory, tatarská omáčka	100gsmazenyhermelin,varenebrambory,tatarskaomacka	1a, 3, 7, 10	100g Fried Camembert Cheese, boiled Potatoes, tartar Sauce	6
1797	350g Sýrové tortelliny s pestem ze sušených rajčat s bazalkou, rukolou a strouhaným sýrem	350gsyrovetortellinyspestemzesusenychrajcatsbazalkou,rukolouastrouhanymsyrem	1a, 3, 7, 9	350g Cheese Tortellini with Pesto Sauce (Dried Tomatoes, Basil), Rocket Salad and Cheese Crumbs	2
1798	150g Smažené sýrové trio, bramborové hranolky, tatarská omáčka	150gsmazenesyrovetrio,bramborovehranolky,tatarskaomacka	1a, 3, 7, 12	150g Fried Cheese, potato French Fries, Tartar Sauce	6
818	350g Kynuté knedlíky s borůvkami, zakysaná smetana se strouhanou čokoládou	350gkynuteknedlikysboruvkami,zakysanasmetanasestrouhanoucokoladou	1a, 3, 6, 7	350g Yeast Dumplings with Bilberries, sour Cream with Chocolate Crumbs	2
235	120g Tortilla plněná kuřecí směsí se zeleninou, bramborové hranolky, bylinková kysaná smetana	120gtortillaplnenakurecismesisezeleninou,bramborovehranolky,bylinkovakysanasmetana	1a, 1b, 3, 6, 7, 9, 10	\N	6
232	120g Španělský ptáček, dušená rýže	120gspanelskyptacek,dusenaryze	1a, 3, 9, 10	120g Beef Meat with Egg, Bacon and Cucumber, stewed Rice	2
215	120g Smažené kuřecí stripsy v mandlové strouhance, bramborové hranolky, pepřový dip	120gsmazenekurecistripsyvmandlovestrouhance,bramborovehranolky,peprovydip	1a, 1b, 3, 7, 8, 8a, 9, 12	120g Fried Almond-Crusted Chicken Strips, potato French Fries, peppercorn Dip	6
206	120g Smažené kuřecí goujons v kukuřičné krustě, opékané brambory, sweet chilli majonéza	120gsmazenekurecigoujonsvkukuricnekruste,opekanebrambory,sweetchillimajoneza	1a, 3, 5, 6, 7, 9, 10, 11, 12	120g Fried Chicken Goujons in Cornflake Crust, roasted Potatoes, sweet Chilli Mayonnaise	6
234	120g Špikovaná hovězí pečeně, svíčková omáčka, houskový knedlík	120gspikovanahovezipecene,svickovaomacka,houskovyknedlik	1a, 3, 7, 9, 10	120g Larded Beef Roast, Cream Sauce, bread Dumplings	2
221	120g Smažený řízek z vepřové kotlety, vařené brambory s máslem	120gsmazenyrizekzveprovekotlety,varenebramborysmaslem	1a, 3, 7, 9, 10	120g Fried Pork Cutlet Schnitzel, boiled Potatoes with Butter	2
201	120g Řízky z panenky v mandlové panko strouhance, bramborové hranolky, bylinkový dip	120grizkyzpanenkyvmandlovepankostrouhance,bramborovehranolky,bylinkovydip	1a, 1b, 3, 7, 8, 8a	120g Almond-Panko Crusted Pork Tenderloin Schnitzels, potato French Fries, herb Dip	6
743	300g Těstovinový salát se zeleninou, tofu a eidamem, dresink	300gtestovinovysalatsezeleninou,tofuaeidamem,dresink	1a, 3, 6, 7, 9	\N	6
238	120g Tortilla s kuřecím masem a zeleninou, dip z kysané smetany, zeleninová ozdoba	120gtortillaskurecimmasemazeleninou,dipzkysanesmetany,zeleninovaozdoba	1a, 3, 5, 7, 9, 10, 11	\N	6
1333	2 Sterilovaná hotovka ve skle  - Kuřecí kousky,Boloňská směs,Frankfurtská pečeně,Kuličky z mletého masa s rajskou om.	2sterilovanahotovkaveskle-kurecikousky,bolonskasmes,frankfurtskapecene,kulickyzmletehomasasrajskouom.		2 Sterilovaná hotovka ve skle  - Kuřecí kousky,Boloňská směs,Frankfurtská pečeně,Kuličky z mletého masa s rajskou om.	5
1334	Sterilovaná polévka ve skle 0,7l - Hovězí vývar, Dýňová, Kapistnice, Gulášová, Kyselice	sterilovanapolevkaveskle0,7l-hovezivyvar,dynova,kapistnice,gulasova,kyselice		Sterilovaná polévka ve skle 0,7l - Hovězí vývar, Dýňová, Kapistnice, Gulášová, Kyselice	5
1335	2 Sterilovaná hotovka ve skle  - Vepřový vrabec, Boloňská směs, Kuřecí kousky na pepři	2sterilovanahotovkaveskle-veprovyvrabec,bolonskasmes,kurecikouskynapepri		2 Sterilovaná hotovka ve skle  - Vepřový vrabec, Boloňská směs, Kuřecí kousky na pepři	5
1073	Sendvič se sýrem, Sendvič s angl.slaninou, BIO tvaroh s musli, Michaná vejce - pečivo	sendvicsesyrem,sendvicsangl.slaninou,biotvarohsmusli,michanavejce-pecivo		\N	4
1552	Sterilovaná polévka ve skle  0,7l - Gulášová,Valašská kyselice,Z restovaných paprik,Boršč,Cibulačka,Slovenská kapustnica,Brokolicový krémový chowder,Kuřecí,Rajská,Hovězí,Telecí vývar,Jemná pepřová omáčka	sterilovanapolevkaveskle0,7l-gulasova,valasskakyselice,zrestovanychpaprik,borsc,cibulacka,slovenskakapustnica,brokolicovykremovychowder,kureci,rajska,hovezi,telecivyvar,jemnapeprovaomacka		Sterilovaná polévka ve skle  0,7l - Gulášová,Valašská kyselice,Z restovaných paprik,Boršč,Cibulačka,Slovenská kapustnica,Brokolicový krémový chowder,Kuřecí,Rajská,Hovězí,Telecí vývar,Jemná pepřová omáčka	5
1553	2 Sterilovaná hotovka ve skle  - Kuřecí kousky,Kuřecí kari,Kuličky s mletého masa s rajskou om.	2sterilovanahotovkaveskle-kurecikousky,kurecikari,kulickysmletehomasasrajskouom.		2 Sterilovaná hotovka ve skle  - Kuřecí kousky,Kuřecí kari,Kuličky s mletého masa s rajskou om.	5
1554	3 Sterilovaná hotovka ve skle  - Znojemské hovězí nudličky,Chow-Mein z vepřové panenky,Medailonky z vepřové panenky,Hovězí guláš,Krůtí ragů,Hovězí po burgundsku	3sterilovanahotovkaveskle-znojemskehovezinudlicky,chow-meinzveprovepanenky,medailonkyzveprovepanenky,hovezigulas,krutiragu,hovezipoburgundsku		3 Sterilovaná hotovka ve skle  - Znojemské hovězí nudličky,Chow-Mein z vepřové panenky,Medailonky z vepřové panenky,Hovězí guláš,Krůtí ragů,Hovězí po burgundsku	5
1555	Sterilovaná polévka ve skle 0,7l - Rajská,Cibulačka,Hovězí vývar,Boršč,Kuřecí vývar	sterilovanapolevkaveskle0,7l-rajska,cibulacka,hovezivyvar,borsc,kurecivyvar		Sterilovaná polévka ve skle 0,7l - Rajská,Cibulačka,Hovězí vývar,Boršč,Kuřecí vývar	5
1556	3 Sterilovaná hotovka ve skle  - Chow-mein s z vepřové panenky,Krůtí medailonky	3sterilovanahotovkaveskle-chow-meinszveprovepanenky,krutimedailonky		3 Sterilovaná hotovka ve skle  - Chow-mein s z vepřové panenky,Krůtí medailonky	5
1557	Sterilovaná polévka ve skle 0,7l - Z restovaných paprik, Kuřecí krémová, Brokolicový krém, Cibulačka, Hov.vývar s byl.noky, Borsč, Gulášová s vep.masem	sterilovanapolevkaveskle0,7l-zrestovanychpaprik,kurecikremova,brokolicovykrem,cibulacka,hov.vyvarsbyl.noky,borsc,gulasovasvep.masem		Sterilovaná polévka ve skle 0,7l - Z restovaných paprik, Kuřecí krémová, Brokolicový krém, Cibulačka, Hov.vývar s byl.noky, Borsč, Gulášová s vep.masem	5
462	150g Zapečené kuřecí prso s peperonátou a smetanou, bramborová kaše	150gzapecenekureciprsospeperonatouasmetanou,bramborovakase		\N	2
463	150g Zapečené kuřecí prso s peperonátou a smetanou, smažené hranolky	150gzapecenekureciprsospeperonatouasmetanou,smazenehranolky		\N	2
467	1 Sterilovaná hotovka ve skle  -BIO hovězí,Bramborový guláš	1sterilovanahotovkaveskle-biohovezi,bramborovygulas		\N	5
469	1 Sterilovaná hotovka ve skle  - BIO hovězí vývar,Bramborový guláš	1sterilovanahotovkaveskle-biohovezivyvar,bramborovygulas		\N	5
470	1 Sterilovaná hotovka ve skle  -BIO kuřecí vývar	1sterilovanahotovkaveskle-biokurecivyvar		\N	5
471	1 Sterilovaná hotovka ve skle  - BIO vývar	1sterilovanahotovkaveskle-biovyvar		\N	5
472	1 Sterilovaná hotovka ve skle  - Bramborový guláš,BIO hovězí vývar	1sterilovanahotovkaveskle-bramborovygulas,biohovezivyvar		\N	5
473	1 Sterilovaná hotovka ve skle  - Hovězí vývar BIO	1sterilovanahotovkaveskle-hovezivyvarbio		\N	5
474	1 Sterilovaná hotovka ve skle  - Hovězí vývar BIO,Veganský DHAL ze žlutého hrachu	1sterilovanahotovkaveskle-hovezivyvarbio,veganskydhalzezlutehohrachu		\N	5
475	1 Sterilovaná hotovka ve skle  - Veganský DHAL ze žlutého hrachu,BIO Hovězí vývar s trhaným masem a zeleninou	1sterilovanahotovkaveskle-veganskydhalzezlutehohrachu,biohovezivyvarstrhanymmasemazeleninou		\N	5
476	1 Sterilovaná hotovka ve skle  - Veganský DHAL ze žlutého hrachu,BIO Hovězí vývar s trhaným masem a zeleninou,Bramborový guláš	1sterilovanahotovkaveskle-veganskydhalzezlutehohrachu,biohovezivyvarstrhanymmasemazeleninou,bramborovygulas		\N	5
478	1 Sterilovaná hotovka ve skle 0,7l - Bio hovězí vývar s trh.masem a zel.	1sterilovanahotovkaveskle0,7l-biohovezivyvarstrh.masemazel.		\N	5
481	1 Sterilovaná hotovka ve skle 0,7l - Bramborový guláš1 Sterilovaná hotovka ve skle 0,7l - Bramborový guláš-	1sterilovanahotovkaveskle0,7l-bramborovygulas1sterilovanahotovkaveskle0,7l-bramborovygulas-		\N	5
482	1 Sterilovaná polévka ve skle 0,7l - Bio hovězí vývar s trh.masem a zel.	1sterilovanapolevkaveskle0,7l-biohovezivyvarstrh.masemazel.		\N	5
240	120g Vegetariánská zeleninová korma s kokosovým krémem a mandlemi, biryami rýže, bez lepku	120gvegetarianskazeleninovakormaskokosovymkrememamandlemi,biryamiryze,bezlepku	7, 8, 8a, 9, 10	\N	2
242	120g Vepřová kapsa plněná modrým sýrem, opékané brambory	120gveprovakapsaplnenamodrymsyrem,opekanebrambory	1a, 7, 9	\N	6
243	120g Vepřová panenka s op.slaninou, americké brambory, pikantní dip	120gveprovapanenkasop.slaninou,americkebrambory,pikantnidip	1a, 7, 9, 10	\N	6
244	120g Vepřová pečeně se sázeným vejcem, bramborové hranolky, tatarská omáčka	120gveprovapecenesesazenymvejcem,bramborovehranolky,tatarskaomacka	1a, 3, 7, 9, 10	\N	6
245	120g Vepřové medailonky s anglickou slaninou, bramborové hranolky	120gveprovemedailonkysanglickouslaninou,bramborovehranolky	1a, 3, 5, 7, 9, 10, 11	\N	6
252	120g Vídeňská roštěná s restovanou cibulí, jasmínová rýže	120gvidenskarostenasrestovanoucibuli,jasminovaryze	1a, 9, 10	120g Stewed Beef Steak with Roasted Onion, jasmine Rice	2
1336	Sterilovaná polévka ve skle  0,7l - Gulášová,Dýňová,Valašská kyselice,Z restovaných paprik,Telecí,Hovězí vývar,Slovenská kapustnica,Rajská,Boršč,Jemná pepřová omáčka	sterilovanapolevkaveskle0,7l-gulasova,dynova,valasskakyselice,zrestovanychpaprik,teleci,hovezivyvar,slovenskakapustnica,rajska,borsc,jemnapeprovaomacka		Sterilovaná polévka ve skle  0,7l - Gulášová,Dýňová,Valašská kyselice,Z restovaných paprik,Telecí,Hovězí vývar,Slovenská kapustnica,Rajská,Boršč,Jemná pepřová omáčka	5
1337	1 Sterilovaná hotovka ve skle  - Bramborový guláš,Bramborové kari Aloo-Bhaji,BIO Hovězí vývar	1sterilovanahotovkaveskle-bramborovygulas,bramborovekarialoo-bhaji,biohovezivyvar		1 Sterilovaná hotovka ve skle  - Bramborový guláš,Bramborové kari Aloo-Bhaji,BIO Hovězí vývar	5
1338	3 Sterilovaná hotovka ve skle  - Hovězí svíčková,Krůtí medailonky,Znojemské hovězí nudličky,Kuřecí medailonky	3sterilovanahotovkaveskle-hovezisvickova,krutimedailonky,znojemskehovezinudlicky,kurecimedailonky		3 Sterilovaná hotovka ve skle  - Hovězí svíčková,Krůtí medailonky,Znojemské hovězí nudličky,Kuřecí medailonky	5
1339	Sterilovaná polévka ve skle 0,7l --Dýňová,Kapustová,Z restovaných paprik	sterilovanapolevkaveskle0,7l--dynova,kapustova,zrestovanychpaprik		Sterilovaná polévka ve skle 0,7l --Dýňová,Kapustová,Z restovaných paprik	5
1558	2 Sterilovaná hotovka ve skle  - Rajská s kuličkami, F Vrabec se zelím, Vepř.krkovice s pepř.om.,Segedínský guláš	2sterilovanahotovkaveskle-rajskaskulickami,fvrabecsezelim,vepr.krkovicespepr.om.,segedinskygulas		2 Sterilovaná hotovka ve skle  - Rajská s kuličkami, F Vrabec se zelím, Vepř.krkovice s pepř.om.,Segedínský guláš	5
1559	3 Sterilovaná hotovka ve skle  - Chow -main z vepř.panenky, Svíčková om., Znojemské nudličky, Chilli con carne, Kuř.medailonky s liškovou omáčkou	3sterilovanahotovkaveskle-chow-mainzvepr.panenky,svickovaom.,znojemskenudlicky,chilliconcarne,kur.medailonkysliskovouomackou		3 Sterilovaná hotovka ve skle  - Chow -main z vepř.panenky, Svíčková om., Znojemské nudličky, Chilli con carne, Kuř.medailonky s liškovou omáčkou	5
1342	1 Sterilovaná hotovka ve skle  - Bramborový guláš, Brambor.kari Aloo- bhaji	1sterilovanahotovkaveskle-bramborovygulas,brambor.karialoo-bhaji		1 Sterilovaná hotovka ve skle  - Bramborový guláš, Brambor.kari Aloo- bhaji	5
1343	2 Sterilovaná hotovka ve skle 0,7l - Masové kuličky, rajská om., Kuřecí just, Boloňská vepř. směs, Moravský vrabec, zelí	2sterilovanahotovkaveskle0,7l-masovekulicky,rajskaom.,kurecijust,bolonskavepr.smes,moravskyvrabec,zeli		2 Sterilovaná hotovka ve skle 0,7l - Masové kuličky, rajská om., Kuřecí just, Boloňská vepř. směs, Moravský vrabec, zelí	5
1344	3 Sterilovaná hotovka ve skle 0,7l - Krůtí medailonky, Hov. svíčková omáčka, Medailónky z vepř panenky, Hov.Stroganoff	3sterilovanahotovkaveskle0,7l-krutimedailonky,hov.svickovaomacka,medailonkyzveprpanenky,hov.stroganoff		3 Sterilovaná hotovka ve skle 0,7l - Krůtí medailonky, Hov. svíčková omáčka, Medailónky z vepř panenky, Hov.Stroganoff	5
1560	150g Vepřová roláda z mletého masa plněná směsí ze špenátu, žampionů a sýru, bramborová kaše, okurkový salát	150gveprovaroladazmletehomasaplnenasmesizespenatu,zampionuasyru,bramborovakase,okurkovysalat		150g Vepřová roláda z mletého masa plněná směsí ze špenátu, žampionů a sýru, mashed Potatoes, cucumber Salad	2
1799	3 Sterilovaná hotovka ve skle  - Hovězí guláš,Chow - Mein z vepřové panenky	3sterilovanahotovkaveskle-hovezigulas,chow-meinzveprovepanenky		3 Sterilovaná hotovka ve skle  - Hovězí guláš,Chow - Mein z vepřové panenky	5
493	200g Pečené uzené koleno, červené zelí, bramborový knedlík	200gpeceneuzenekoleno,cervenezeli,bramborovyknedlik		\N	1
911	3 Sterilovaná hotovka ve skle  -Vepřové medailonky,Kuřecí medailonky	3sterilovanahotovkaveskle-veprovemedailonky,kurecimedailonky		\N	5
250	120g Vídeňská roštěná, dušená rýže	120gvidenskarostena,dusenaryze	1a, 1b, 9, 10	\N	2
251	120g Vídeňská roštěná s restovanou cibulí, dušená rýže	120gvidenskarostenasrestovanoucibuli,dusenaryze	1a, 9, 10	\N	1
253	120g Zapečená vepřová kotleta s čedarem a brokolicí , mačkané brambory	120gzapecenaveprovakotletascedaremabrokolici,mackanebrambory	1a, 7, 9, 10	\N	2
254	120g Zapečená vepřová kotleta s pečenou kapií a sýrem, basmati rýže	120gzapecenaveprovakotletaspecenoukapiiasyrem,basmatiryze	1a, 6, 9, 10	\N	1
255	120g Zapečená vepřová kotleta s pečenou kapií a sýrem, dušená rýže	120gzapecenaveprovakotletaspecenoukapiiasyrem,dusenaryze	1a, 1b, 7, 9, 10	\N	2
256	120g Zapečená vepřová kotleta s pečenou kapií a sýrem, šťouchané brambory	120gzapecenaveprovakotletaspecenoukapiiasyrem,stouchanebrambory	1a, 7, 9, 10	\N	2
259	120g Zapečené kuřecí prso se šunkou a sýrem, přírodní šťáva s bylinkami, dušená rýže	120gzapecenekureciprsosesunkouasyrem,prirodnistavasbylinkami,dusenaryze	1a, 3, 5, 7, 9, 10, 11	\N	2
260	120g Zapečený kuřecí steak se šunkou a sýrem, dušená rýže	120gzapecenykurecisteaksesunkouasyrem,dusenaryze	1a, 7, 9, 10	\N	2
261	120g Zapečený kuřecí steak se šunkou a sýrem, jasmínová rýže	120gzapecenykurecisteaksesunkouasyrem,jasminovaryze	1a, 7, 9, 10	\N	2
1291	Gulášová z hovězího masa	gulasovazhovezihomasa	1a, 9, 10	Beef Goulash Soup 	9
1292	120g Vepřové výpečky, dušené bílé zelí, bramborový knedlík	120gveprovevypecky,dusenebilezeli,bramborovyknedlik	1a, 3, 9, 10	120g Pork with Cabbage, Onion, Garlic, Lard, stewed White Cabbage, Potato Dumpling	2
1293	120g Chilli con-carne z kuřecího masa s fazolemi a zeleninou, jasmínová rýže	120gchillicon-carnezkurecihomasasfazolemiazeleninou,jasminovaryze	1a, 3, 7, 9	120g Chicken Meat in Spicy Sauce with Beans and Vegetables, jasmine Rice	2
1294	200g Smažené cuketové medailonky, mačkané brambory, tatarská omáčka	200gsmazenecuketovemedailonky,mackanebrambory,tatarskaomacka	1a, 3, 7, 9, 10	200g Fried Zucchini Noisettes, crushed Potatoes, tartar Sauce	2
1295	150g Drůbeží játra na cibulce, slanině a tymiánu, jasmínová rýže, bez lepku	150gdrubezijatranacibulce,slanineatymianu,jasminovaryze,bezlepku	9, 10	150g Drůbeží játra na cibulce, slanině a tymiánu, jasmine Rice, gluten Free	2
1340	120g Smažený řízek z vepřové kotlety, šťouchané brambory	120gsmazenyrizekzveprovekotlety,stouchanebrambory	1a, 3, 7	120g Fried Pork Cutlet Schnitzel, mashed Potatoes	1
1345	120g Vepřové kostky na kmíně, česneku a slanině, dušená rýže	120gveprovekostkynakmine,cesnekuaslanine,dusenaryze		120g Pork Cubes with Caraway, Garlic and Bacon, stewed Rice	1
1146	Sterilovaná polévka ve skle 0,7l - Kulajda, Gulášová s vepř. masem, Kuř.vývar se zel.a masem, Z rest.paprik s rajč.a smetanou	sterilovanapolevkaveskle0,7l-kulajda,gulasovasvepr.masem,kur.vyvarsezel.amasem,zrest.papriksrajc.asmetanou		\N	5
1160	Sterilovaná polévka ve skle 0,7l - Rajská	sterilovanapolevkaveskle0,7l-rajska		Sterilovaná polévka ve skle 0,7l -Rajská	5
1561	Kroupová s uzeným masem	kroupovasuzenymmasem	1c, 9	Barley Soup with Smoked Meat	9
1562	120g Kuřecí madras kari se zázvorem, čili a paprikou, basmati rýže	120gkurecimadraskarisezazvorem,ciliapaprikou,basmatiryze	1a, 7, 9	120g Chicken Madras Curry with Ginger, Chilli and Sweet Peppers, basmati Rice	2
1563	300g Špagety s hovězím boloňským ragů a sýrem gran biraghi	300gspagetyshovezimbolonskymraguasyremgranbiraghi	1a, 1b, 3, 6, 7, 9, 10, 12	300g Spaghetti Bolognese with Beef Ragout and Gran Biraghi Cheese	2
1564	300g Penne s rajčaty, jarní cibulkou, špenátem a strouhanou mozzarelou, bylinkové pesto	300gpennesrajcaty,jarnicibulkou,spenatemastrouhanoumozzarelou,bylinkovepesto	1a, 3, 7, 8, 8a, 9	300g Penne with Tomatoes, Spring Onion, Spinach and Mozzarella Crumbs, herb Pesto	2
1565	150g Smažené rybí filé v sezamové strouhance, mačkané brambory	150gsmazenerybifilevsezamovestrouhance,mackanebrambory	1a, 3, 4, 7, 11	150g Fried Fish Fillet in Sesame Breadcrumbs, crushed Potatoes	2
1566	300g Veganské zeleninové ragů s uzeným tofu a pečenou paprikou, opékané grenaille brambory	300gveganskezeleninoveragusuzenymtofuapecenoupaprikou,opekanegrenaillebrambory	6, 9	300g Vegan Vegetable Ragout with Smoked Tofu (Bean Curd) and Roasted Sweet Peppers, roasted Grenaille Potatoes	2
1567	Smažené rybí filé v sezamové strouhance, mačkané brambory	smazenerybifilevsezamovestrouhance,mackanebrambory	1a, 3, 4, 7, 11	Fried Fish Fillet in Sesame Breadcrumbs, crushed Potatoes	2
1568	Sterilovaná polévka ve skle  0,7l - Valašská kyselice,	sterilovanapolevkaveskle0,7l-valasskakyselice,		Sterilovaná polévka ve skle  0,7l - Valašská kyselice,	5
1569	2 Sterilovaná hotovka ve skle  - Rajská s kuličkami, , Vrabec se zelím, Vepř.krkovice s pepř.om., Segedínský guláš	2sterilovanahotovkaveskle-rajskaskulickami,,vrabecsezelim,vepr.krkovicespepr.om.,segedinskygulas		2 Sterilovaná hotovka ve skle  - Rajská s kuličkami, , Vrabec se zelím, Vepř.krkovice s pepř.om., Segedínský guláš	5
1570	120g Pikantní směs z vepřové panenky, bramboráčky	120gpikantnismeszveprovepanenky,bramboracky	1a, 3, 6, 7, 9	150g Spicy Pork Loin Meat Mix	2
1573	120g Smetanové krůtí ragú se slaninou, pórkem a sušenými rajčaty, basmati rýže	120gsmetanovekrutiraguseslaninou,porkemasusenymirajcaty,basmatiryze	1a, 7, 9, 10, 12	120g Cream Turkey Ragout with Bacon, Leek and Dried Tomatoes, basmati Rice	1
1574	120g Ražniči z kuřecího masa s anglickou slaninou, cibulí a paprikami, basmati rýže	120graznicizkurecihomasasanglickouslaninou,cibuliapaprikami,basmatiryze	1a, 9, 10	120g Marinated and Roasted Chicken Skewer with Bacon, Onion and Peppers, basmati Rice	1
1575	120g Španělský ptáček, basmati rýže	120gspanelskyptacek,basmatiryze	1a, 3, 9, 10	120g Beef Meat with Egg, Bacon and Cucumber, basmati Rice	1
1576	3 Sterilovaná hotovka ve skle  - Chow -main z vepř.panenky, Znojemské nudličky, Chilli con carne, Kuř.medailonky s liškovou omáčkou	3sterilovanahotovkaveskle-chow-mainzvepr.panenky,znojemskenudlicky,chilliconcarne,kur.medailonkysliskovouomackou		3 Sterilovaná hotovka ve skle  - Chow -main z vepř.panenky, Znojemské nudličky, Chilli con carne, Kuř.medailonky s liškovou omáčkou	5
1800	130g Fish and chips - treska v pivním těstě s hranolkami, sweet chilli dip	130gfishandchips-treskavpivnimtesteshranolkami,sweetchillidip	1a, 3, 4, 6, 7, 12	130g Fish and Chips - Codfish in Beer Batter with French Fries, sweet Chilli Dip	6
1297	490g Pizza SPINACI S RICOTTOU, tomat, špenát listový, mozzarella, ricotta, sušená rajčata	490gpizzaspinacisricottou,tomat,spenatlistovy,mozzarella,ricotta,susenarajcata	1a, 1b, 7	490g Pizza with Tomato Purée, Leaf Spinach, Edam Cheese, Ricotta and Dried Tomatoes	8
1298	100g Smažené krabí tyčinky, vařené brambory, sweet chilli dip	100gsmazenekrabitycinky,varenebrambory,sweetchillidip	1a, 3, 4	100g Fried Crab Sticks, boiled Potatoes, sweet Chilli Dip	6
501	240g Konfitované kachní stehno, bramborový knedlík	240gkonfitovanekachnistehno,bramborovyknedlik	1a, 3, 9, 10, 12	\N	2
1571	3 Sterilovaná hotovka ve skle  -Znojemské nudličky,Kuřecí medailonky	3sterilovanahotovkaveskle-znojemskenudlicky,kurecimedailonky		3 Sterilovaná hotovka ve skle  -Znojemské nudličky,Kuřecí medailonky	5
1572	120g Zapečená vepřová kotleta se zeleninovou směsí a sýrem, basmati rýže	120gzapecenaveprovakotletasezeleninovousmesiasyrem,basmatiryze	1a, 7, 9, 10	120g Baked Pork Chop with Mixed Vegetables and Cheese, basmati Rice	1
262	120g Zapečený kuřecí steak s kápií a sýrem , mačkané brambory	120gzapecenykurecisteakskapiiasyrem,mackanebrambory	1a, 7, 9	120g Baked Chicken Steak with Sweet Pepper and Cheese, crushed Potatoes	2
1577	3 Sterilovaná hotovka ve skle 0,7l - Medailonky z v. panenky s ang.slan.a rozmarýnem	3sterilovanahotovkaveskle0,7l-medailonkyzv.panenkysang.slan.arozmarynem		3 Sterilovaná hotovka ve skle 0,7l - Medailonky z v. panenky s ang.slan.a rozmarýnem	5
1801	3 Sterilovaná hotovka ve skle  - Chow - Mein z vepřové panenky,Hovězí po burgundsku,Krůtí medailonky,Vepřové medailonky	3sterilovanahotovkaveskle-chow-meinzveprovepanenky,hovezipoburgundsku,krutimedailonky,veprovemedailonky		3 Sterilovaná hotovka ve skle  - Chow - Mein z vepřové panenky,Hovězí po burgundsku,Krůtí medailonky,Vepřové medailonky	5
1354	Šopský salát	sopskysalat		Šopský salát	3
1355	Okurkový salát	okurkovysalat		Okurkový salát	3
1180	Sterilovaná polévka ve skle  0,7l - Z restovaných paprik,Brokolicová,Kuřecí vývar,Sýrová,Kapustová,Dyňová,Masový vývar,Kukuřiční chowder	sterilovanapolevkaveskle0,7l-zrestovanychpaprik,brokolicova,kurecivyvar,syrova,kapustova,dynova,masovyvyvar,kukuricnichowder		\N	5
1185	Sterilovaná polévka ve skle 0.7l- Rajská s těstovinou	sterilovanapolevkaveskle0.7l-rajskastestovinou		\N	5
1299	150g Vepřové výpečky, dušené zelí se slaninou, bramborový knedlík	150gveprovevypecky,dusenezeliseslaninou,bramborovyknedlik	1a, 3, 9, 10	150g Pork with Cabbage, Onion, Garlic, Lard, stewed Cabbage with Bacon, Potato Dumplings	2
1300	200g Drůbeží játra na cibulce, slanině a tymiánu, jasmínová rýže	200gdrubezijatranacibulce,slanineatymianu,jasminovaryze	9, 10	200g Drůbeží játra na cibulce, slanině a tymiánu, jasmine Rice	2
1301	100g Smažený sýr, vařené brambory, sweet chilli dip	100gsmazenysyr,varenebrambory,sweetchillidip	1a, 3, 7, 10, 11	100g Fried Cheese, boiled Potatoes, sweet Chilli Dip	6
1302	300g Těstoviny s vepřovými nudličkami, cuketou a žampinony sypané sýrem gran biraghi	300gtestovinysveprovyminudlickami,cuketouazampinonysypanesyremgranbiraghi	1a, 7, 9	300g Farfalle Pasta with Pork Noodles, Zucchini and Champignons Sprinkled with Gran Biraghi Cheese	2
1303	300g Řecký salát s olivami, červenou cibulí, okurkami, cherry rajčaty a feta sýrem, kuřecí kousky, pita chléb	300greckysalatsolivami,cervenoucibuli,okurkami,cherryrajcatyafetasyrem,kurecikousky,pitachleb	1a, 7	300g Greek Salad with Olives, Red Onion, Cucumbers, Cherry Tomatoes and Feta Cheese, chicken Pieces, pitta Bread	2
263	120g Znojemské masové kuličky s okurkami a slaninou, dušená rýže, bez lepku	120gznojemskemasovekulickysokurkamiaslaninou,dusenaryze,bezlepku	3, 7, 9, 10	\N	2
264	120g Znojemské masové kuličky s okurkami a slaninou, jasmínová rýže, bez lepku	120gznojemskemasovekulickysokurkamiaslaninou,jasminovaryze,bezlepku	3, 7, 9, 10	\N	2
814	350g Džuveč z kuřecího masa se strouhaným sýrem	350gdzuveczkurecihomasasestrouhanymsyrem	7, 9	350g Stewed Chicken Meat with Grated Cheese	2
265	120g Zvěřinový guláš z dančího a srnčího masa, houskový knedlík	120gzverinovygulaszdancihoasrncihomasa,houskovyknedlik	1a, 3, 7, 9, 10	\N	1
266	120g Zvěřinový guláš z dančího a srnčího masa, špekový knedlík	120gzverinovygulaszdancihoasrncihomasa,spekovyknedlik	1a, 3, 7, 9, 10	\N	2
267	120g Zvěřinový guláš z daňka a divočáka s cibulí, houskový knedlík	120gzverinovygulaszdankaadivocakascibuli,houskovyknedlik	1a, 3, 9, 10	\N	2
333	150g Kuřecí gyros se zeleninou, smažené hranolky, česnekový dresink	150gkurecigyrossezeleninou,smazenehranolky,cesnekovydresink	1a, 9, 10	\N	2
269	120g Zvěřinový guláš ze srnčího masa, vídeňská cibulka, karlovarský knedlík	120gzverinovygulaszesrncihomasa,videnskacibulka,karlovarskyknedlik	1a, 3, 7, 9, 10	\N	2
1346	Beskydská kyselice s čabajkou	beskydskakyselicescabajkou	1a, 7, 9, 10	Sauerkraut Soup with Smoked Salami	9
1578	150g Smetanové kuřecí kousky s dýní, batáty a karotkou, dušená rýže	150gsmetanovekurecikouskysdyni,batatyakarotkou,dusenaryze	7, 9	150g Creamy Chicken Bites with Pumpkin, Sweet Potato and Carrot, stewed Rice	2
280	130g Filet z okouna s bylinkovou nádivkou, vinná omáčka, grenaille brambory	130gfiletzokounasbylinkovounadivkou,vinnaomacka,grenaillebrambory	1a, 4, 5, 6, 7, 9, 10, 11, 12	130g Fillet of Perch with Herb Filling, wine Sauce, grenaille Potatoes	2
283	130g Filet z tilápie nilské se špenátovou nádivkou, vinná omáčka, grenaille se šalotkou a bazalkou	130gfiletztilapienilskesespenatovounadivkou,vinnaomacka,grenaillesesalotkouabazalkou	1a, 4, 7, 12	130g Spinach Stuffed Nile Tilapia Fillet, wine Sauce, grenaille Potatoes with Shallot and Basil	2
290	130g Fish and chips - treska v pivním těstě s hranolkami, sweet-chilli majonéza	130gfishandchips-treskavpivnimtesteshranolkami,sweet-chillimajoneza	1a, 4, 7, 12	130g Fish and Chips - Codfish in Beer Batter with French Fries, sweet Chilli Mayonnaise	6
271	130g Filet z candáta s bylinkovou tapenádou, dýňové pyré s karotkou a smetanou	130gfiletzcandatasbylinkovoutapenadou,dynovepyreskarotkouasmetanou	1, 4, 5, 6, 7, 9, 10, 11	\N	2
1010	Dýňová se smetanou a koriandrem	dynovasesmetanouakoriandrem	1a, 7, 9	\N	9
258	120g Zapečené kuřecí medailonky se šunkou a sýrem brie, šťouchané brambory	120gzapecenekurecimedailonkysesunkouasyrembrie,stouchanebrambory	7, 9	120g Scalloped Chicken Noisettes with Ham and Brie Cheese, mashed Potatoes	2
257	120g Zapečené kuřecí medailonky s bylinkami,šunkou a sýrem brie, dušená rýže	120gzapecenekurecimedailonkysbylinkami,sunkouasyrembrie,dusenaryze	1a, 7, 9	120g Scalloped Chicken Noisettes with Herbs, Ham and Brie Cheese, stewed Rice	2
273	130g Filet ze pstruha, máslová omáčka, šťouchané brambory	130gfiletzepstruha,maslovaomacka,stouchanebrambory	4, 7, 9, 10, 12	\N	1
275	130g Filet ze pstruha se šafránovo - máslovou omáčkou, pečenou baby karotkou a bulgurem	130gfiletzepstruhasesafranovo-maslovouomackou,pecenoubabykarotkouabulgurem	1a, 4, 7, 9, 10, 11, 12	\N	2
276	130g Filet ze štiky s bylinkovou nádivkou, omáčka z hrubozrnné hořčici a medu, opékané brambory	130gfiletzestikysbylinkovounadivkou,omackazhrubozrnnehorciciamedu,opekanebrambory	1a, 4, 5, 6, 7, 9, 10, 11	\N	2
277	130g Filet ze štiky s bylinkovou nádivkou a omáčkou z hrubozrnné hořčice, šťouchané brambory	130gfiletzestikysbylinkovounadivkouaomackouzhrubozrnnehorcice,stouchanebrambory	1a, 4, 5, 6, 7, 9, 10	\N	1
278	130g Filet ze štiky s bylinkovou nádivkou a omáčkou z hrubozrnné hořčice, zeleninové medové ragů	130gfiletzestikysbylinkovounadivkouaomackouzhrubozrnnehorcice,zeleninovemedoveragu	1a, 4, 5, 6, 7, 9, 10, 11	\N	2
279	130g Filet z okouna s bylinkovou nádivkou, grenaille brambory	130gfiletzokounasbylinkovounadivkou,grenaillebrambory	1a, 4, 7, 9	\N	1
281	130g Filet z okouna s bylinkovou nádivkou, vinná omáčka, opékané brambory	130gfiletzokounasbylinkovounadivkou,vinnaomacka,opekanebrambory	1a, 4, 5, 6, 7, 9, 10, 11, 12	\N	2
282	130g Filet z tilápie nilské se špenátovou nádivkou, grenaille se šalotkou a bazalkou	130gfiletztilapienilskesespenatovounadivkou,grenaillesesalotkouabazalkou	1a, 4, 7, 12	\N	2
284	130g Filet z tilápie nilské se špenátovou nádivkou, vinná omáčka, opékané brambory	130gfiletztilapienilskesespenatovounadivkou,vinnaomacka,opekanebrambory	1a, 4, 7, 12	\N	1
285	130g Filet z tilápie smažený v panko strouhance, krémová bramborová kaše	130gfiletztilapiesmazenyvpankostrouhance,kremovabramborovakase	1a, 1b, 3, 4, 5, 6, 7, 9, 10, 11	\N	2
286	130g Filet z tilápie smažený v panko strouhance, šťouchané brambory	130gfiletztilapiesmazenyvpankostrouhance,stouchanebrambory	1a, 3, 4, 5, 6, 7, 9, 10, 11	\N	1
287	130g Filet z tilápie smažený v panko strouhance, vařené brambory	130gfiletztilapiesmazenyvpankostrouhance,varenebrambory	1a, 3, 4, 5, 6, 7, 9, 10	\N	1
288	130g Filet z tresky s restovanou zeleninou, opékané brambory	130gfiletztreskysrestovanouzeleninou,opekanebrambory	1a, 4, 5, 6, 7, 9, 10, 11	\N	1
289	130g Filé ze pstruha s bylinkovou nádivkou, vinná omáčka, pečené grenaile	130gfilezepstruhasbylinkovounadivkou,vinnaomacka,pecenegrenaile	1a, 4, 7, 9, 12	\N	2
1802	Sterilovaná polévka ve skle 0,7l - Kuřecí vývar s trh.masem, Kulajda, Fazolová s uz.masem, Dýňová se smet., Cibulačka, Steaková om., Pepřová om., Sugo di pomodoro	sterilovanapolevkaveskle0,7l-kurecivyvarstrh.masem,kulajda,fazolovasuz.masem,dynovasesmet.,cibulacka,steakovaom.,peprovaom.,sugodipomodoro		Sterilovaná polévka ve skle 0,7l - Kuřecí vývar s trh.masem, Kulajda, Fazolová s uz.masem, Dýňová se smet., Cibulačka, Steaková om., Pepřová om., Sugo di pomodoro	5
1803	2 Sterilovaná hotovka ve skle 0,7l - Frankfurtska vepř.pečeně, Boloňská vepř. směs	2sterilovanahotovkaveskle0,7l-frankfurtskavepr.pecene,bolonskavepr.smes		2 Sterilovaná hotovka ve skle 0,7l - Frankfurtska vepř.pečeně, Boloňská vepř. směs	5
291	130g Kousky tmavé tresky s rajčaty, jarní cibulí a baby špenátem, basmati rýže	130gkouskytmavetreskysrajcaty,jarnicibuliababyspenatem,basmatiryze	1a, 3, 4, 6, 7, 9, 10	\N	2
292	130g Kousky tmavé tresky s rajčaty, jarní cibulí a baby špenátem, bylinkové těstoviny	130gkouskytmavetreskysrajcaty,jarnicibuliababyspenatem,bylinkovetestoviny	1a, 3, 4, 6, 7, 9, 10	\N	2
293	130g Marinovaný losos s máslovým hráškem, grenaille brambory	130gmarinovanylosossmaslovymhraskem,grenaillebrambory	1a, 4, 7, 10	\N	2
294	130g Marinovaný losos s máslovým hráškem, pečené grenaile	130gmarinovanylosossmaslovymhraskem,pecenegrenaile	1a, 4, 7, 10	\N	2
297	130g Pečený filet z lososovitého pstruha s bylinkami a máslovou omáčkou, grenaille brambory	130gpecenyfiletzlososovitehopstruhasbylinkamiamaslovouomackou,grenaillebrambory	1, 4, 7, 9, 10, 12	\N	2
298	130g Pečený filet z mořského pstruha s bylinkami,grilovanou zeleninou a grenaille bramborami	130gpecenyfiletzmorskehopstruhasbylinkami,grilovanouzeleninouagrenaillebramborami	1, 4, 7, 9, 10	\N	2
300	130g Pečený filet z tresky s fazolkami na medu a hrubozrnné hořčici, pečené grenaile	130gpecenyfiletztreskysfazolkaminameduahrubozrnnehorcici,pecenegrenaile	1a, 4, 5, 6, 7, 9, 11, 12	\N	2
295	130g Medailonky z platýse obecného s kapari a bylinkovým máslem, pečené grenaile	130gmedailonkyzplatyseobecnehoskapariabylinkovymmaslem,pecenegrenaile	1, 4, 5, 6, 7, 9, 10, 11	130g Flatfish Noisettes with Caper and Herb Butter, roasted Grenaille Potatoes	2
274	130g Filet ze pstruha s bylinkovou nádivkou, vinná omáčka, pečené grenaile	130gfiletzepstruhasbylinkovounadivkou,vinnaomacka,pecenegrenaile	1a, 4, 7, 9, 12	130g Trout Fillet with Herb Stuffing, wine Sauce, roasted Grenaille Potatoes	2
306	130g Pečený marinovaný losos, fazolky se šalotkou, opékané brambory	130gpecenymarinovanylosos,fazolkysesalotkou,opekanebrambory	4, 7, 8, 8a, 9, 10	\N	2
308	130g Smažená marinovaná treska v bylinkové strouhance, karotkové pyré	130gsmazenamarinovanatreskavbylinkovestrouhance,karotkovepyre	1a, 3, 4, 7, 9	\N	2
309	130g Smažená marinovaná treska v bylinkové strouhance, šťouchané brambory	130gsmazenamarinovanatreskavbylinkovestrouhance,stouchanebrambory	1a, 3, 7, 9	\N	1
1579	Valašská kyselica s klobásou	valasskakyselicasklobasou	1a, 7, 9, 10	Sauerkraut Soup with Sausage	9
1580	150g Silný hovězí guláš s černým pivem a cibulí, houskový knedlík	150gsilnyhovezigulasscernympivemacibuli,houskovyknedlik	1a, 3, 9, 10	150g Rich Beef Goulash with Dark Beer and Onions, bread Dumplings	2
310	130g Smažený filet z mníka mořského, pečené grenaile, pikantní chipotle majonéza	130gsmazenyfiletzmnikamorskeho,pecenegrenaile,pikantnichipotlemajoneza	1, 3, 4, 6, 7, 9, 10, 12, 13	\N	1
311	130g Smažený karbanátek z lososa, šťouchané brambory s cibulí a petrželkou, sweet chilli dip	130gsmazenykarbanatekzlososa,stouchanebramboryscibuliapetrzelkou,sweetchillidip	1a, 3, 4, 5, 6, 7, 9, 10, 11	\N	2
312	130g Thajské kokosové kari s lososem a zeleninou, citronová rýže	130gthajskekokosovekarislososemazeleninou,citronovaryze	1, 4, 9, 10	130g Thai Coconut Curry with Salmon and Vegetables, lemon Rice	2
313	130g Vaječné nudle WOK se zeleninou, grilovaným lososem a teriyaki omáčkou	130gvajecnenudlewoksezeleninou,grilovanymlososemateriyakiomackou	1a, 1b, 3, 4, 6, 7, 9, 10, 12	\N	6
315	150g Chilli con carne z hovězího masa s kukuřicí, rajčaty a fazolemi, pita chléb	150gchilliconcarnezhovezihomasaskukurici,rajcatyafazolemi,pitachleb	1a, 3, 7, 9	\N	2
316	150g Ciabatta s grilovanou zeleninou, mozzarelou a ranchero dresinkem, bramborové hranolky	150gciabattasgrilovanouzeleninou,mozzarelouarancherodresinkem,bramborovehranolky	1a, 1b, 3, 7, 9	\N	6
1308	120g Ražniči z kuřecího masa s anglickou slaninou, cibulí a paprikami, jasmínová rýže	120graznicizkurecihomasasanglickouslaninou,cibuliapaprikami,jasminovaryze	1a, 9, 10	120g Marinated and Roasted Chicken Skewer with Bacon, Onion and Peppers, jasmine Rice	2
1309	300g Plněné pečené brambory se zeleninou, fazolemi, čočkou beluga a balkánským sýrem, trhaný salát, dip z kysané smetany	300gplnenepecenebramborysezeleninou,fazolemi,cockoubelugaabalkanskymsyrem,trhanysalat,dipzkysanesmetany	7, 9	300g Plněné pečené brambory se zeleninou, fazolemi, čočkou beluga a balkánským sýrem, shredded Lettuce, sour Cream Dip	2
1310	120g Ražniči z kuřecího masa s anglickou slaninou, cibulí a paprikami	120graznicizkurecihomasasanglickouslaninou,cibuliapaprikami	1a, 9, 10	120g Marinated and Roasted Chicken Skewer with Bacon, Onion and Peppers	2
1311	120g Grilované kuřecí kousky, zeleninová ozdoba, smažené hranolky	120ggrilovanekurecikousky,zeleninovaozdoba,smazenehranolky	1a, 3, 5, 7, 9, 10, 11	120g Grilled Chicken Pieces, vegetable Garnish, french Fries (Fried Potato Chips)	6
1312	150g Kuřecí medailonky se sýrovou omáčkou, smažené hranolky	150gkurecimedailonkysesyrovouomackou,smazenehranolky	1a, 3, 5, 7, 9, 10, 11	150g Chicken Noisettes with Cheese Sauce, french Fries (Fried Potato Chips)	2
1313	300g Kotlíkový guláš s vepřovým masem, klobásou, bramborami, cibulí a chilli, kmínový chléb	300gkotlikovygulassveprovymmasem,klobasou,bramborami,cibuliachilli,kminovychleb	1, 9, 10	300g Kotlíkový guláš s vepřovým masem, klobásou, bramborami, cibulí a chilli, caraway Seed Bread	2
1314	300g Zeleninový salát s cherry rajčaty, ředkvičkami a slunečnicovým semínkem , sýr Halloumi	300gzeleninovysalatscherryrajcaty,redkvickamiaslunecnicovymseminkem,syrhalloumi	7, 9	300g Zeleninový salát s cherry rajčaty, ředkvičkami a slunečnicovým semínkem , sýr Halloumi	2
317	150g Cikánská pečeně z vepřové krkovice, těstoviny	150gcikanskapecenezveprovekrkovice,testoviny	1a, 3, 9, 10	\N	2
318	150g Dušená vepřová krkovice s vejci po Vietnamsku, dušená rýže	150gdusenaveprovakrkovicesvejcipovietnamsku,dusenaryze	3, 6, 9	\N	2
319	150g Filetovaná vepřová panenka, hořčicová omáčka, pečené brambory	150gfiletovanaveprovapanenka,horcicovaomacka,pecenebrambory	1a, 7, 9, 10	\N	2
301	130g Pečený filet z tresky s fazolkami na medu a hrubozrnné hořčici, šťouchané brambory	130gpecenyfiletztreskysfazolkaminameduahrubozrnnehorcici,stouchanebrambory	1a, 4, 5, 6, 7, 9, 10, 11, 12	130g Baked Cod Fillet with Green Beans in Honey and Wholegrain Mustard, mashed Potatoes	1
320	150g Fritované rybí filé s mandlemi a sezamem, batátové pyré	150gfritovanerybifilesmandlemiasezamem,batatovepyre	1, 3, 4, 7, 8, 8a, 9, 11	\N	2
322	150g Glazované Meatballs Hoi-sin se zeleninou a sezamem, dušená rýže	150gglazovanemeatballshoi-sinsezeleninouasezamem,dusenaryze	3, 6, 7, 9, 10, 11, 12, 13	\N	2
323	150g Grilovaná krkovička, pepřová omáčka, smažené hranolky	150ggrilovanakrkovicka,peprovaomacka,smazenehranolky	1a, 3, 5, 7, 9, 10, 11, 12	\N	6
324	150g Grilovaná krkovička marinovaná v tymiánu, bramborové hranolky, pepřový dip	150ggrilovanakrkovickamarinovanavtymianu,bramborovehranolky,peprovydip	1a, 1b, 3, 5, 7, 9, 10, 11, 12	\N	6
325	150g Grilovaná vepřová krkovice, steakové hranolky, pepřový dip	150ggrilovanaveprovakrkovice,steakovehranolky,peprovydip	1a, 3, 5, 7, 9, 10, 11, 12	\N	6
326	150g Grilovaná vepřová panenka, hořčicová omáčka, smažené hranolky	150ggrilovanaveprovapanenka,horcicovaomacka,smazenehranolky	1a, 3, 5, 7, 9, 10, 11	\N	2
314	150g Čevapčiči s cibulí a hořčicí, vařené brambory, tatarská omáčka	150gcevapciciscibuliahorcici,varenebrambory,tatarskaomacka	1a, 3, 7, 9, 10	150g Serbian Kebab with Onion and Mustard, boiled Potatoes, tartar Sauce	2
321	150g Fritované rybí filé s mandlemi a sezamem, krémová bramborová kaše	150gfritovanerybifilesmandlemiasezamem,kremovabramborovakase	1a, 3, 4, 7, 8, 8a, 11	150g Fried Fish Fillet with Almonds and Sesame, creamy Mashed Potatoes	2
356	150g Kuřecí prsní steak, zeleninový kuskus, rajčatová omáčka	150gkureciprsnisteak,zeleninovykuskus,rajcatovaomacka	1a, 9	150g Chicken Breast Steak, vegetable Couscous, tomato Sauce	2
1581	120g Chow - mein z vepřové panenky s brokolicí, mrkví, žampiony  a sezamem, jasmínová rýže	120gchow-meinzveprovepanenkysbrokolici,mrkvi,zampionyasezamem,jasminovaryze	1a, 3, 5, 6, 7, 9, 10, 11	120g Pork Undercut Chow Mein with Broccoli, Carrot  and Sesame, jasmine Rice	2
327	150g Grilovaný kuřecí steak s bylinkovým máslem, pečená zelenina, bramborové hranolky	150ggrilovanykurecisteaksbylinkovymmaslem,pecenazelenina,bramborovehranolky	1a, 1b, 3, 5, 7, 9, 10, 11	\N	6
328	150g Indická Tikka masala s kuřecím masem, dušená rýže	150gindickatikkamasalaskurecimmasem,dusenaryze	1a, 7, 9, 10	\N	2
1316	130g Smažený hejk v panko strouhance, šťouchané brambory	130gsmazenyhejkvpankostrouhance,stouchanebrambory	1a, 3, 4, 5, 6, 7, 9, 10, 11	130g Sea Pike Fried in Panko Crumbs, mashed Potatoes	1
1318	300g Plněné pečené brambory se zeleninou, fazolemi, čočkou beluga a balkánským sýrem, dip z kysané smetany	300gplnenepecenebramborysezeleninou,fazolemi,cockoubelugaabalkanskymsyrem,dipzkysanesmetany	7, 9	300g Plněné pečené brambory se zeleninou, fazolemi, čočkou beluga a balkánským sýrem, sour Cream Dip	2
329	150g Kotlíkový guláš s hovězím masem, klobásou, kápií a bramborem, kmínový chléb	150gkotlikovygulasshovezimmasem,klobasou,kapiiabramborem,kminovychleb	1, 9, 10	\N	2
330	150g Krůtí medailonky s anglickou slaninou, pórkem a sušenými rajčaty, basmati rýže	150gkrutimedailonkysanglickouslaninou,porkemasusenymirajcaty,basmatiryze	1a, 7, 9	\N	2
331	150g Krůtí medailonky s nivovou omáčkou, bramborové hranolky	150gkrutimedailonkysnivovouomackou,bramborovehranolky	1a, 7, 9	\N	6
332	150g Kuřecí Cordon Bleu, bramborové hranolky	150gkurecicordonbleu,bramborovehranolky	1a, 1b, 3, 7	\N	6
334	150g Kuřecí játra na víně se slaninou a cibulkou, dušená rýže	150gkurecijatranavineseslaninouacibulkou,dusenaryze	1a, 9, 12	\N	2
335	150g Kuřecí kapsa plněná šunkou a nivou, bramborové hranolky	150gkurecikapsaplnenasunkouanivou,bramborovehranolky	1a, 1b, 7	\N	6
336	150g Kuřecí kapsa plněná šunkou a nivou, bramborové hranolky, zeleninová ozdoba	150gkurecikapsaplnenasunkouanivou,bramborovehranolky,zeleninovaozdoba	1a, 7, 9	\N	6
337	150g Kuřecí kapsa plněná sušenými rajčaty a mozzarelou, bramborové hranolky	150gkurecikapsaplnenasusenymirajcatyamozzarelou,bramborovehranolky	7, 9	\N	6
338	150g Kuřecí kapsa plněná sušenými rajčaty a mozzarelou, kuskus se zeleninou	150gkurecikapsaplnenasusenymirajcatyamozzarelou,kuskussezeleninou	1a, 7, 9, 10	\N	6
307	130g Řízky z tmavé tresky v panko strouhance , bramborové pyré s karotkou	130grizkyztmavetreskyvpankostrouhance,bramborovepyreskarotkou	1a, 3, 4, 7	130g Panko-Crusted Black Cod Fillets, patato Purée with Carrots	2
340	150g Kuřecí kari s cizrnou a batáty, jasmínová rýže	150gkurecikariscizrnouabataty,jasminovaryze	1a, 9	\N	2
341	150g Kuřecí kousky "sweet and sour" s medem, chilli a zeleninou, dušená rýže, bez lepku	150gkurecikousky"sweetandsour"smedem,chilliazeleninou,dusenaryze,bezlepku	6, 9, 10	\N	2
342	150g Kuřecí kousky "sweet and sour" s medem, chilli a zeleninou, jasmínová rýže	150gkurecikousky"sweetandsour"smedem,chilliazeleninou,jasminovaryze	6, 9, 10	\N	2
345	150g Kuřecí kung-pao, restované čínské nudle	150gkurecikung-pao,restovanecinskenudle	1a, 3, 5, 6, 7, 9, 10, 11	\N	2
346	150g Kuřecí medailonky se sýrovou omáčkou, bramborové hranolky	150gkurecimedailonkysesyrovouomackou,bramborovehranolky	1a, 7, 9	\N	6
347	150g Kuřecí medailonky s houbovou omáčkou, opečené brambory	150gkurecimedailonkyshoubovouomackou,opecenebrambory	1, 3, 5, 7, 9, 10, 11	\N	2
350	150g Kuřecí prsa sous-vide s ratatouille zeleninou, bramborová kaše	150gkureciprsasous-videsratatouillezeleninou,bramborovakase	1, 3, 5, 7, 9, 10, 11	\N	2
351	150g Kuřecí prsa sous-vide s ratatouille zeleninou, šťouchané brambory	150gkureciprsasous-videsratatouillezeleninou,stouchanebrambory	1, 3, 5, 7, 9, 10, 11	\N	2
352	150g Kuřecí prsa v sýrovém těstíčku, vařené brambory	150gkureciprsavsyrovemtesticku,varenebrambory	1a, 3, 7, 9, 10	\N	2
353	150g Kuřecí prsa v sýrovém těstíčku, vařené brambory, trhaný salát	150gkureciprsavsyrovemtesticku,varenebrambory,trhanysalat	1a, 3, 7, 9, 10	\N	2
1319	300g Plněné pečené brambory se zeleninou, fazolemi, čočkou beluga a balkánským sýrem, trhané saláty, dip z kysané smetany	300gplnenepecenebramborysezeleninou,fazolemi,cockoubelugaabalkanskymsyrem,trhanesalaty,dipzkysanesmetany	7, 9	300g Plněné pečené brambory se zeleninou, fazolemi, čočkou beluga a balkánským sýrem, shredded Lettuce, sour Cream Dip	2
1320	120g Sekaná vepřová pečeně, rajská omáčka, těstoviny kolena	120gsekanaveprovapecene,rajskaomacka,testovinykolena	1a, 1b, 3, 7, 9, 10	120g Minced Pork Meat, tomato Sauce, elbow Maccaroni	2
1321	240g Pečené kuře ala bažant se zeleninou, divokým kořením a anglickou slaninou, dušená rýže	240gpecenekurealabazantsezeleninou,divokymkorenimaanglickouslaninou,dusenaryze	1a, 1b, 3, 5, 7, 9, 10, 11	240g Roasted Chicken with Vegetables, Wild Spices and Bacon , stewed Rice	2
1322	120g Přírodní vepřová kotleta, vařené brambory s máslem	120gprirodniveprovakotleta,varenebramborysmaslem	1a, 1b, 9, 10	120g Pork Cutlet au Naturel, boiled Potatoes with Butter	2
354	150g Kuřecí prsní steak, grilovaná zelenina, šťouchané brambory	150gkureciprsnisteak,grilovanazelenina,stouchanebrambory	1, 3, 5, 7, 9, 10, 11	\N	2
355	150g Kuřecí prsní steak, omáčka z gorgonzoly, americké brambory	150gkureciprsnisteak,omackazgorgonzoly,americkebrambory	1a, 7, 9	\N	2
357	150g Kuřecí prsní steak marinovaný v jogurtu a bylinkách, smažené bramborové dukátky, česnekový dresink	150gkureciprsnisteakmarinovanyvjogurtuabylinkach,smazenebramborovedukatky,cesnekovydresink	1a, 7, 9	\N	2
358	150g Kuřecí prsní steak marinovaný v teriyaki omáčce, zeleninový kuskus	150gkureciprsnisteakmarinovanyvteriyakiomacce,zeleninovykuskus	1a, 3, 5, 6, 7, 9, 10, 11	\N	2
362	150g Kuřecí směs pikantní, smažené krokety	150gkurecismespikantni,smazenekrokety	1a, 9	\N	2
26	100g Smažený kuřecí řízek, bramborový salát s kápií	100gsmazenykurecirizek,bramborovysalatskapii		\N	2
363	150g Kuřecí špíz s anglickou slaninou, cibulí a klobásou, bramborové hranolky	150gkurecispizsanglickouslaninou,cibuliaklobasou,bramborovehranolky	1a, 9, 10	\N	6
364	150g Kuřecí špíz s anglickou slaninou, cibulí a klobásou, vařené brambory, česnekový dresink	150gkurecispizsanglickouslaninou,cibuliaklobasou,varenebrambory,cesnekovydresink	1a, 7, 9, 10	\N	2
365	150g Kuřecí špíz s anglickou slaninou, paprikou a cibulí, americké brambory, trhaný salát	150gkurecispizsanglickouslaninou,paprikouacibuli,americkebrambory,trhanysalat	1, 3, 5, 7, 9, 10, 11	\N	2
366	150g Kuřecí steak na bylinkách, žampionové ragů, vařené brambory	150gkurecisteaknabylinkach,zampionoveragu,varenebrambory	1a, 7, 9, 10, 12	\N	2
367	150g Kuřecí steak na grilu, bylinková omáčka, smažené hranolky	150gkurecisteaknagrilu,bylinkovaomacka,smazenehranolky	1a, 3, 5, 7, 9, 10, 11	\N	6
368	150g Kuřecí steak na medu a tymiánu s cherry rajčaty a sweet chilli omáčkou, dušená rýže	150gkurecisteaknameduatymianuscherryrajcatyasweetchilliomackou,dusenaryze	1, 6, 9, 10	\N	2
369	150g Kuřecí steak na medu a tymiánu s cherry rajčaty a sweet chilli omáčkou, jasmínová rýže	150gkurecisteaknameduatymianuscherryrajcatyasweetchilliomackou,jasminovaryze	1, 6, 9, 10	\N	2
370	150g Kuřecí steak na medu a tymiánu s cherry rajčaty a sweet chilli omáčkou, šťouchané brambory	150gkurecisteaknameduatymianuscherryrajcatyasweetchilliomackou,stouchanebrambory	1, 6, 9, 10	\N	2
371	150g Kuřecí závitek v anglické slanině plněný chřestem , šťouchané brambory	150gkurecizavitekvanglickeslanineplnenychrestem,stouchanebrambory	1a, 7, 9	\N	2
372	150g Losos na grilu, opékané brambory, koprový dip	150glososnagrilu,opekanebrambory,koprovydip	4, 7, 10	\N	6
373	150g Marinovaná vepřová kotleta, grilovaná zelenina, opékané brambory	150gmarinovanaveprovakotleta,grilovanazelenina,opekanebrambory	1, 6, 9, 10	\N	6
374	150g Marinovaná vepřová kotleta, opékané brambory, pepřový dip	150gmarinovanaveprovakotleta,opekanebrambory,peprovydip	1a, 3, 5, 7, 9, 10, 11, 12	\N	6
376	150g Marinovaná vepřová kotleta, smažené hranolky, pepřový dip	150gmarinovanaveprovakotleta,smazenehranolky,peprovydip	1a, 3, 7, 9, 10, 12	\N	6
377	150g Marinované kuřecí kousky teryiaki se zeleninou a zázvorem , dušená rýže	150gmarinovanekurecikouskyteryiakisezeleninouazazvorem,dusenaryze	1a, 1b, 3, 6, 7, 9, 10	\N	2
378	150g Marinované kuřecí kousky teryiaki se zeleninou a zázvorem , jasmínová rýže	150gmarinovanekurecikouskyteryiakisezeleninouazazvorem,jasminovaryze	1a, 1b, 3, 6, 7, 9, 10	\N	2
379	150g Marinované kuřecí kousky teryiaki se zeleninou a zázvorem , opékané brambory	150gmarinovanekurecikouskyteryiakisezeleninouazazvorem,opekanebrambory	1, 3, 6, 7, 9, 10	\N	2
380	150g Medailonky z vepřové panenky, fazolový lusk se slaninou, vařené brambory	150gmedailonkyzveprovepanenky,fazolovyluskseslaninou,varenebrambory	1, 3, 5, 7, 9, 10, 11	\N	2
381	150g Medailonky z vepřové panenky, pečené brambory, fazolové lusky	150gmedailonkyzveprovepanenky,pecenebrambory,fazolovelusky	1, 3, 5, 7, 9, 10, 11	\N	2
382	150g Medailonky z vepřové panenky s pepřovou omáčkou, smažené hranolky	150gmedailonkyzveprovepanenkyspeprovouomackou,smazenehranolky	1a, 7, 9	\N	2
384	150g Mix gril s kuřecím a vepřovým  masem , americké brambory, pepřový dip	150gmixgrilskurecimaveprovymmasem,americkebrambory,peprovydip	1a, 3, 5, 7, 9, 10, 11, 12	\N	6
385	150g Mix gril s kuřecím a vepřovým  masem , bramborové hranolky, pepřový dip	150gmixgrilskurecimaveprovymmasem,bramborovehranolky,peprovydip	1a, 1b, 3, 5, 7, 9, 10, 11, 12	\N	6
386	150g Mix gril s kuřecím a vepřovým  masem , opékané brambory, pepřový dip	150gmixgrilskurecimaveprovymmasem,opekanebrambory,peprovydip	1a, 3, 5, 7, 9, 10, 11, 12	\N	6
389	150g Musaka s bramborami, vepřovým masem, lilkem a sýrem, trhaný salát	150gmusakasbramborami,veprovymmasem,lilkemasyrem,trhanysalat	1a, 7, 9, 10	\N	2
390	150g Pečená treska tmavá, máslová omáčka s bílým vínem, pečené bylinkové grenaille	150gpecenatreskatmava,maslovaomackasbilymvinem,pecenebylinkovegrenaille	1, 4, 5, 6, 7, 9, 10, 11, 12	\N	2
391	150g Pečená vepřová krkovice po Asijsku s chilli, medem a zázvorem, dušená rýže	150gpecenaveprovakrkovicepoasijskuschilli,medemazazvorem,dusenaryze	6, 9	\N	2
393	150g Pečený marinovaný tofu špíz s jarní cibulí, pórkem a paprikou, bylinkový dip	150gpecenymarinovanytofuspizsjarnicibuli,porkemapaprikou,bylinkovydip	1, 3, 5, 6, 7, 9, 10, 11	\N	2
394	150g Pečený marinovaný tofu špíz s jarní cibulí, pórkem a paprikou, dušená rýže	150gpecenymarinovanytofuspizsjarnicibuli,porkemapaprikou,dusenaryze	3, 5, 6, 7, 9, 10, 11	\N	2
392	150g Pečené rybí filé s bylinkovou omáčkou, smetanová bramborová kaše	150gpecenerybifilesbylinkovouomackou,smetanovabramborovakase	1a, 4, 5, 6, 7, 9, 10, 11	150g Roasted Fish Fillet with Herb Sauce, creamy Mashed Potatoes	2
395	150g Pečený marinovaný tofu špíz s jarní cibulí, pórkem a paprikou, jasmínová rýže	150gpecenymarinovanytofuspizsjarnicibuli,porkemapaprikou,jasminovaryze	1, 3, 5, 6, 7, 9, 10, 11	\N	2
396	150g Pečený marinovaný tofu špíz s jarní cibulí, pórkem a paprikou, rýžový pilaf	150gpecenymarinovanytofuspizsjarnicibuli,porkemapaprikou,ryzovypilaf	1a, 3, 5, 6, 7, 9, 10, 11	\N	1
397	150g Pečený marinovaný tofu špíz s jarní cibulí, pórkem a paprikou, rýžový pilaf, bez lepku	150gpecenymarinovanytofuspizsjarnicibuli,porkemapaprikou,ryzovypilaf,bezlepku	3, 5, 6, 7, 9, 10, 11	\N	2
398	150g Pečený marinovaný tofu špíz s jarní cibulí, pórkem a paprikou, rýžový pilaf, bylinkový dip	150gpecenymarinovanytofuspizsjarnicibuli,porkemapaprikou,ryzovypilaf,bylinkovydip	1, 3, 5, 6, 7, 9, 10, 11	\N	1
399	150g Pečený marinovaný tofu špíz s jarní cibulí, pórkem a paprikou, rýžový pilaf, bylinkový dip, bez lepku	150gpecenymarinovanytofuspizsjarnicibuli,porkemapaprikou,ryzovypilaf,bylinkovydip,bezlepku	3, 5, 6, 7, 9, 10, 11	\N	2
400	150g Pikantní kuřecí směs s chilli, ananasem, mrkví  a teriyaki omáčkou, jasmínová rýže	150gpikantnikurecismesschilli,ananasem,mrkviateriyakiomackou,jasminovaryze	1, 3, 6, 7, 9	\N	2
401	150g Pikantní kuřecí směs se žampiony a kápií, bramboráčky	150gpikantnikurecismessezampionyakapii,bramboracky	1a, 3, 6, 7, 9	\N	2
1013	Fazolová s uzeninou	fazolovasuzeninou	1a, 9	\N	9
387	150g Mix gril s kuřecím a vepřovým  masem , steakové hranolky, pepřový dip	150gmixgrilskurecimaveprovymmasem,steakovehranolky,peprovydip	1a, 3, 5, 7, 9, 10, 11, 12	150g Grilled Chicken, Pork and Beef Meat, french Fries in Steak Seasoning, peppercorn Dip	6
964	450g Pizza AL FUNGHI tomat, žampiony,mozzarella	450gpizzaalfunghitomat,zampiony,mozzarella	1a, 1b, 7	450g Pizza AL FUNGHI Tomato Purée,Champignons, Edam Cheese	8
689	300g Pad Thai s brokolicí, paprikou, čínským zelím, vaječnými nudlemi, zázvorem a teryiaki omáčkou	300gpadthaisbrokolici,paprikou,cinskymzelim,vajecnyminudlemi,zazvoremateryiakiomackou	1a, 1b, 3, 6, 7, 8, 9, 10	300g Pad Thai with Broccoli, Bell Pepper, Chinese Cabbage, Egg Noodles, Ginger and Teriyaki Sauce	2
402	150g Pikantní směs s vepřovými játry, žampiony, kápií a slaninou, jasmínová rýže	150gpikantnismessveprovymijatry,zampiony,kapiiaslaninou,jasminovaryze	1, 3, 6, 7, 9	\N	2
404	150g Pomalu pečená trhaná krkovice na pivu, bramborová kaše, trhané saláty	150gpomalupecenatrhanakrkovicenapivu,bramborovakase,trhanesalaty	1a, 7, 9, 10	\N	2
405	150g Pomalu pečená trhaná krkovice na pivu, bramborová kaše, trhaný salát	150gpomalupecenatrhanakrkovicenapivu,bramborovakase,trhanysalat	1a, 7, 9, 10	\N	2
407	150g Přírodní rybí filé na másle a kmínu, bramborové pyré s dýní	150gprirodnirybifilenamasleakminu,bramborovepyresdyni	1, 4, 5, 6, 7, 9, 10, 11	\N	2
408	150g Pstruh lososovitý ala Wellington se špenátem a mascarpone, grenaille brambory	150gpstruhlososovityalawellingtonsespenatemamascarpone,grenaillebrambory	1, 4, 7, 9, 10, 12	\N	2
409	150g Pstruh lososovitý ala Wellington se špenátem a mascarpone, pečené grenaile	150gpstruhlososovityalawellingtonsespenatemamascarpone,pecenegrenaile	1a, 3, 4, 7, 9	\N	2
410	150g Restovaná jasmínová rýže se zeleninou, marinované kuřecí prsa v teryiaki omáčce	150grestovanajasminovaryzesezeleninou,marinovanekureciprsavteryiakiomacce	1, 6, 7, 9, 10	\N	2
411	150g Restované čínské nudle, kuřecí prsa marinované v teriyaki omáčce	150grestovanecinskenudle,kureciprsamarinovanevteriyakiomacce	1a, 3, 6, 7, 9, 10	\N	2
412	150g Rozlítaný španělský ptáček, jasmínová rýže	150grozlitanyspanelskyptacek,jasminovaryze	1a, 3, 9, 10	\N	2
414	150g Sekaná pečeně, bramborová kaše, rajčatový salát s cibulkou	150gsekanapecene,bramborovakase,rajcatovysalatscibulkou	1a, 3, 7, 9, 10	\N	2
415	150g Smažená bylinková treska v sezamové strouhance, batátové pyré	150gsmazenabylinkovatreskavsezamovestrouhance,batatovepyre	1a, 3, 4, 7, 9, 11	\N	2
416	150g Smažená sýrová jehla s goudou, hermelínem a eidamem, bramborové hranolky, česnekové aioli	150gsmazenasyrovajehlasgoudou,hermelinemaeidamem,bramborovehranolky,cesnekoveaioli	1a, 1b, 3, 7	\N	6
417	150g Smažené cuketové medailonky, karotkové pyré, bylinkový dip	150gsmazenecuketovemedailonky,karotkovepyre,bylinkovydip	1a, 3, 7, 9	\N	2
418	150g Smažené cuketové medailonky, mačkané brambory, tatarská omáčka	150gsmazenecuketovemedailonky,mackanebrambory,tatarskaomacka	1a, 3, 7, 9, 10	\N	2
421	150g Smažené vepřové medailonky, bramborový salát s vejci a majonézou	150gsmazeneveprovemedailonky,bramborovysalatsvejciamajonezou	1a, 3, 7, 9, 10	\N	6
422	150g Smažené vepřové řízečky z panenky, bramborové hranolky, tatarská omáčka	150gsmazeneveproverizeckyzpanenky,bramborovehranolky,tatarskaomacka	1a, 3, 7, 10	\N	6
423	150g Smažený holandský řízek se sýrem, bramborová kaše, kyselý okurek	150gsmazenyholandskyrizeksesyrem,bramborovakase,kyselyokurek	1a, 3, 7, 9, 10	\N	2
424	150g Smažený holandský řízek se sýrem, šťouchané brambory, trhaný salát	150gsmazenyholandskyrizeksesyrem,stouchanebrambory,trhanysalat	1a, 3, 7, 9	\N	2
425	150g Smažený kuřecí řízek, vařené brambory, okurkový salát	150gsmazenykurecirizek,varenebrambory,okurkovysalat	1a, 3, 7, 9, 10	\N	2
426	150g Smažený řízek z kuřecího stehna, bramborový salát s kápií	150gsmazenyrizekzkurecihostehna,bramborovysalatskapii	1a, 3, 7, 8, 8a, 9, 10	\N	2
428	150g Smetanová křenová omáčka s uzeným masem, houskový knedlík	150gsmetanovakrenovaomackasuzenymmasem,houskovyknedlik	1a, 3, 7, 9	\N	2
429	150g Smetanové kuřecí nudličky na rozmarýnu a bazalce, dušená rýže	150gsmetanovekurecinudlickynarozmarynuabazalce,dusenaryze	7, 9	\N	2
431	150g Šneci z vepřové panenky na špejli s cibulí a anglickou slaninou, smažené bramborové dukátky, česnekový dip	150gsnecizveprovepanenkynaspejliscibuliaanglickouslaninou,smazenebramborovedukatky,cesnekovydip	1a, 3, 7, 9	\N	2
433	150g Špagety se špenátem, cherry rajčaty a kuřecími kousky sypané sýrem gran biraghi	150gspagetysespenatem,cherryrajcatyakurecimikouskysypanesyremgranbiraghi	1a, 3, 7, 9	\N	2
434	150g Špíz z vepřové panenky se slaninou, cibulí a kápií, šťouchané brambory	150gspizzveprovepanenkyseslaninou,cibuliakapii,stouchanebrambory	1a, 7, 9	\N	2
436	150g Steak z vepřové krkovice, vařené brambory, tatarská omáčka	150gsteakzveprovekrkovice,varenebrambory,tatarskaomacka	1a, 5, 7, 9, 10, 11	\N	1
838	370g POKE BOWL s tuňákem	370gpokebowlstunakem	1a, 1b, 3, 4, 6, 7, 9, 10, 11	370g Poke Bowl with Tuna	6
437	150g Steak z vepřové krkovice marinované v tymiánu, opékané brambory, jemná pepřová omáčka	150gsteakzveprovekrkovicemarinovanevtymianu,opekanebrambory,jemnapeprovaomacka	1a, 3, 5, 7, 9, 10, 11, 12	150g Pork Neck Steak with Thyme Marinade, roasted Potatoes, fine Peppercorn Sauce	2
440	150g Uzená vepřová pečeně, bramborová kaše, rajčatový salát s cibulkou	150guzenaveprovapecene,bramborovakase,rajcatovysalatscibulkou	7	\N	2
1325	120g Vepřové kousky na paprice a smetaně, bramborové noky	120gveprovekouskynapapriceasmetane,bramborovenoky	1a, 3, 7, 9	120g Vepřové kousky na paprice a smetaně, potato Gnocchi	2
1326	120g Kuřecí medailonky s hermelínem, sušenými rajčaty a bazalkovým pestem, mačkané brambory	120gkurecimedailonkyshermelinem,susenymirajcatyabazalkovympestem,mackanebrambory	1a, 7, 9	120g Chicken Noisettes with Camembert Cheese, Dried Tomatoes and Basil Pesto, crushed Potatoes	2
1327	300g Zeleninová směs s brokolicí, květákem, cuketou a pečenými rajčaty, bylinkový bulgur	300gzeleninovasmessbrokolici,kvetakem,cuketouapecenymirajcaty,bylinkovybulgur	1a, 9, 10	300g Zeleninová směs s brokolicí, květákem, cuketou a pečenými rajčaty, bulgur with Herbs	2
430	150g Smetanové kuřecí nudličky na rozmarýnu a bazalce, pečené batáty	150gsmetanovekurecinudlickynarozmarynuabazalce,pecenebataty	7, 9	150g Creamy Chicken Strips with Rosemary and Basil, roasted Sweet Potatoes	2
455	150g Vepřové výpečky, dušený listový špenát, bramborový knedlík	150gveprovevypecky,dusenylistovyspenat,bramborovyknedlik	1a, 3, 7, 9, 10	150g Pork with Cabbage, Onion, Garlic, Lard, stewed Leaf Spinach, potato Dumpling	2
1328	300g Čerstvé těstoviny-Cacio e Pepe-pecorino sýr, bílý pepř, rukola, olivový olej	300gcerstvetestoviny-cacioepepe-pecorinosyr,bilypepr,rukola,olivovyolej	1a, 1b, 3, 9	300g Čerstvé těstoviny-Cacio e Pepe-pecorino sýr, bílý pepř, rukola, olivový olej	6
1329	120g Vepřové medailonky s anglickou slaninou, smažené hranolky, pepřový dip	120gveprovemedailonkysanglickouslaninou,smazenehranolky,peprovydip	1a, 3, 5, 6, 7, 9, 11	120g Pork Noisettes with Bacon, french Fries (Fried Potato Chips), peppercorn Dip	6
1330	150g Vepřové výpečky, dušený listový špenát, vařené brambory	150gveprovevypecky,dusenylistovyspenat,varenebrambory	1a, 3, 7, 9, 10	150g Pork with Cabbage, Onion, Garlic, Lard, stewed Leaf Spinach, boiled Potatoes	2
1331	150g Kuřecí gyros, smažené hranolky, bylinkový dresink s česnekem	150gkurecigyros,smazenehranolky,bylinkovydresinkscesnekem	3, 9, 10	150g Kuřecí gyros, french Fries (Fried Potato Chips), herb Dressing with Garlic	2
1332	300g Římský salát s paprikou a cherry rajčaty, sázené vejce, opečená anglická slanina, opečený toast	300grimskysalatspaprikouacherryrajcaty,sazenevejce,opecenaanglickaslanina,opecenytoast	1a, 3, 10	300g Římský salát s paprikou a cherry rajčaty, sázené vejce, opečená anglická slanina, toast	2
1017	Frankfurtská	frankfurtska	1a, 9	\N	9
441	150g Variace řízků z vepřové panenky a kuřecího prsa, šťouchané brambory, rajčatový salát s cibulkou	150gvariacerizkuzveprovepanenkyakurecihoprsa,stouchanebrambory,rajcatovysalatscibulkou	1a, 3, 7, 9	\N	2
413	150g Segedínský guláš, houskový knedlík	150gsegedinskygulas,houskovyknedlik	1a, 3, 7, 9, 10	150g Goulash with Sauerkraut, Onion, Red Pepper, bread Dumplings	2
435	150g Steak z vepřové krkovice, opékané brambory, steaková omáčka	150gsteakzveprovekrkovice,opekanebrambory,steakovaomacka	1a, 3, 5, 7, 9, 10, 11	150g Pork Neck Steak, roasted Potatoes, steak Sauce	2
444	150g Vepřová krkovice v pikantní omáčce, dušená rýže	150gveprovakrkovicevpikantniomacce,dusenaryze	1a, 7, 9, 10	\N	2
445	150g Vepřová panenka na grilu, hořčicová omáčka, bramborové hranolky	150gveprovapanenkanagrilu,horcicovaomacka,bramborovehranolky	1a, 7, 9, 10, 12	\N	6
446	150g Vepřová pečeně po Anglicku, hořčicová omáčka, americké brambory	150gveprovapecenepoanglicku,horcicovaomacka,americkebrambory	1a, 7, 9, 10	\N	2
447	150g Vepřová pečeně po Anglicku s cuketu a mrkví, pečené brambory	150gveprovapecenepoanglickuscuketuamrkvi,pecenebrambory	1a, 9, 10	\N	2
448	150g Vepřová pečeně s cibulovým chutney a čedarem, vařené brambory, česnekový dip	150gveprovapecenescibulovymchutneyacedarem,varenebrambory,cesnekovydip	1a, 7, 9, 10, 12	\N	2
449	150g Vepřová směs kung pao, smažené hranolky	150gveprovasmeskungpao,smazenehranolky	1, 3, 5, 6, 7, 9, 10, 11	\N	2
450	150g Vepřové kousky na kari s kokosovým mlékem, dušená rýže	150gveprovekouskynakariskokosovymmlekem,dusenaryze	1a, 9, 10	\N	2
451	150g Vepřové masové kuličky plněné sýrem s rajčatovou omáčkou, těstoviny	150gveprovemasovekulickyplnenesyremsrajcatovouomackou,testoviny	1a, 3, 7, 9, 10	\N	2
452	150g Vepřové medailonky s pepřovou omáčkou, bramborové hranolky	150gveprovemedailonkyspeprovouomackou,bramborovehranolky	1a, 1b, 3, 5, 7, 9, 10, 11, 12	\N	6
453	150g Vepřové výpečky, dušené bílé zelí, houskový knedlík	150gveprovevypecky,dusenebilezeli,houskovyknedlik	1a, 3, 9, 10	\N	2
454	150g Vepřové výpečky, dušené zelí, houskový knedlík	150gveprovevypecky,dusenezeli,houskovyknedlik	1a, 3, 9, 10	\N	2
457	150g Vepřový závitek plněný anglickou slaninou a hermelínem, jasmínová rýže	150gveprovyzavitekplnenyanglickouslaninouahermelinem,jasminovaryze	1a, 7	\N	2
458	150g Vepřový závitek plněný anglickou slaninou a hermelínem, vařené brambory	150gveprovyzavitekplnenyanglickouslaninouahermelinem,varenebrambory	1a, 7, 9, 10	\N	2
459	150g Zapečená vepřová krkovice s cibulí a čedarem, smažené hranolky	150gzapecenaveprovakrkovicescibuliacedarem,smazenehranolky	1a, 7, 9	\N	2
460	150g Zapečená vepřová pečeně s cibulí a čedarem, vařené brambory	150gzapecenaveprovapecenescibuliacedarem,varenebrambory	1a, 7, 9, 10	\N	2
461	150g Zapečené kuřecí prso s cuketou, rajčaty a sýrem  , bramborová kaše	150gzapecenekureciprsoscuketou,rajcatyasyrem,bramborovakase	1a, 3, 5, 7, 9, 10, 11	\N	2
464	150g Zapečený kuřecí steak s anglickou slaninou a mozzarellou , šťouchané brambory s jarní cibulí	150gzapecenykurecisteaksanglickouslaninouamozzarellou,stouchanebramborysjarnicibuli	1a, 7, 9	\N	2
465	180g Veganský pšeničný wrap se zelenými fazolemi a salátem	180gveganskypsenicnywrapsezelenymifazolemiasalatem	1a, 1b, 9	\N	6
483	200g Club Sandwich se slaninou, kuřecím masem, rajčaty a majonézou , bramborové hranolky	200gclubsandwichseslaninou,kurecimmasem,rajcatyamajonezou,bramborovehranolky	1a, 1b, 3, 7	\N	6
1341	Zapečené gnocchi s kuřecím masem a omáčkou z modrého sýra	zapecenegnocchiskurecimmasemaomackouzmodrehosyra	1a, 3, 7, 9	Zapečené gnocchi s kuřecím masem a omáčkou z modrého sýra	6
487	200g Kuřecí křídla grilovaná, chléb, sterilovaný okurek, coleslaw s jablky	200gkurecikridlagrilovana,chleb,sterilovanyokurek,coleslawsjablky	1a, 1b, 6, 7, 9, 10, 11	\N	6
489	200g Kuřecí steak na grilu, bramborové hranolky, steaková omáčka	200gkurecisteaknagrilu,bramborovehranolky,steakovaomacka	1a, 3, 5, 7, 9, 10	\N	6
1582	130g Pečený losos s bylinkovou gremolatou, medová zelenina s baby bramborami	130gpecenylosossbylinkovougremolatou,medovazeleninasbabybramborami	4, 7, 9	130g Roast Salmon with Herb Gremolata, Honey-Glazed Vegetables and Baby Potatoes	2
490	200g Kuřecí steak na grilu, smažené hranolky, steaková omáčka	200gkurecisteaknagrilu,smazenehranolky,steakovaomacka	1a, 3, 5, 7, 9, 10, 11	\N	6
492	200g Mix gril s kuřecím a vepřovým  masem , bramborové hranolky, zeleninový salát	200gmixgrilskurecimaveprovymmasem,bramborovehranolky,zeleninovysalat	1, 9	\N	6
494	200g Pečené uzené koleno, červené zelí s vínem a jablky, bramborový knedlík	200gpeceneuzenekoleno,cervenezelisvinemajablky,bramborovyknedlik	1a, 3, 9, 10, 12	\N	1
495	200g Pečené uzené koleno, teplý zelný salát s anglickou slaninou, bramborový knedlík	200gpeceneuzenekoleno,teplyzelnysalatsanglickouslaninou,bramborovyknedlik	1a, 3, 9, 10	\N	1
496	200g Pečené uzené koleno, teplý zelný salát s anglickou slaninou a křenem, bramborový knedlík	200gpeceneuzenekoleno,teplyzelnysalatsanglickouslaninouakrenem,bramborovyknedlik	1a, 1b, 3, 7, 9, 10	\N	2
499	200g Steak z vepřové krkovice, vařené brambory, steaková omáčka	200gsteakzveprovekrkovice,varenebrambory,steakovaomacka	1a, 3, 5, 7, 9, 10, 11	\N	1
500	240g Bramborové knedlíky plněné uzeným masem s dušeným zelím a osmaženou cibulkou	240gbramboroveknedlikyplneneuzenymmasemsdusenymzelimaosmazenoucibulkou	1a, 3, 7, 9, 10	\N	2
502	240g Konfitované kachní stehno, červené zelí s vínem a jablky, bramborový knedlík	240gkonfitovanekachnistehno,cervenezelisvinemajablky,bramborovyknedlik	1a, 3, 9, 10, 12	\N	2
503	240g Kuřecí paličky pečené na medu a hrubozrnné hořčici, coleslaw s jablky, pečené grenaille, bez lepku	240gkurecipalickypecenenameduahrubozrnnehorcici,coleslawsjablky,pecenegrenaille,bezlepku	3, 5, 7, 9, 10, 11	\N	2
504	240g Kuřecí paličky pečené na medu a hrubozrnné hořčici, pečené grenaile, coleslaw s jablky	240gkurecipalickypecenenameduahrubozrnnehorcici,pecenegrenaile,coleslawsjablky	3, 5, 7, 9, 10, 11	\N	1
505	240g Kuřecí stehno pečené na pivu, teplý zelný salát s cibulí a křenem, bramborový knedlík	240gkurecistehnopecenenapivu,teplyzelnysalatscibuliakrenem,bramborovyknedlik	1a, 3, 9, 10	\N	1
506	240g Pečené králičí stehno s divokým kořením, basmati rýže, bez lepku	240gpecenekralicistehnosdivokymkorenim,basmatiryze,bezlepku	9, 10	\N	2
507	240g Pečené králičí stehno s divokým kořením, restovaná zelenina, basmati rýže, bez lepku	240gpecenekralicistehnosdivokymkorenim,restovanazelenina,basmatiryze,bezlepku	9, 10	\N	2
508	240g Pečené králičí stehno s divokým kořením a restovanou zeleninou, mačkané brambory, bez lepku	240gpecenekralicistehnosdivokymkorenimarestovanouzeleninou,mackanebrambory,bezlepku	7, 9, 10	\N	2
509	240g Pečené kuřecí stehno, basmati rýže	240gpecenekurecistehno,basmatiryze	1a, 9, 10	\N	1
510	240g Pečené kuřecí stehno, červené zelí, bramborový knedlík	240gpecenekurecistehno,cervenezeli,bramborovyknedlik	1a, 3, 5, 7, 9, 10, 11	\N	2
511	240g Pečené kuřecí stehno ala husa, červené zelí s vínem a jablky, bramborový knedlík	240gpecenekurecistehnoalahusa,cervenezelisvinemajablky,bramborovyknedlik	1a, 3, 9, 10, 12	\N	2
512	240g Pečené kuřecí stehno na bylinkách, dušená rýže, okurkový salát	240gpecenekurecistehnonabylinkach,dusenaryze,okurkovysalat	1a, 3, 5, 7, 9, 10, 11	\N	2
514	240g Pečené kuřecí stehno po burgundsku se slaninou, vínem a baby cibulkami, basmati rýže	240gpecenekurecistehnopoburgundskuseslaninou,vinemababycibulkami,basmatiryze	1a, 7, 9, 10, 12	\N	1
515	240g Pečené kuřecí stehno po burgundsku se slaninou, vínem a baby cibulkami, mačkané brambory	240gpecenekurecistehnopoburgundskuseslaninou,vinemababycibulkami,mackanebrambory	1a, 3, 5, 7, 9, 10, 11, 12	\N	2
516	240g Pečené kuřecí stehno po provensálsku, jasmínová rýže, bez lepku	240gpecenekurecistehnopoprovensalsku,jasminovaryze,bezlepku	9, 10	\N	2
488	200g Kuřecí plátek na grilu (bez přílohy)	200gkureciplateknagrilu(bezprilohy)	1a, 1b, 9, 10	200g Grilled Chicken Slice (without Side Dish)	6
485	200g Grilovaný kuřecí steak, steakové hranolky, steaková omáčka	200ggrilovanykurecisteak,steakovehranolky,steakovaomacka	3, 7, 9, 10, 11	200g Grilled Chicken Steak, french Fries in Steak Seasoning, steak Sauce	6
491	200g Medailonky z vepřové  panenky na grilu ( bez přílohy)	200gmedailonkyzveprovepanenkynagrilu(bezprilohy)	1a, 1b, 9, 10	200g Grilled Pork Noisettes	6
518	240g Pečené kuřecí stehno s provensálským kořením, jasmínová rýže	240gpecenekurecistehnosprovensalskymkorenim,jasminovaryze	1a, 1b, 9, 10	\N	2
519	250g Boloňské špagety s hovězím masem, sýr gran biraghi	250gbolonskespagetyshovezimmasem,syrgranbiraghi	1a, 3, 7	\N	2
1347	120g Krůtí nudličky na bylinkách s pórkem a smetanou, jasmínová rýže	120gkrutinudlickynabylinkachsporkemasmetanou,jasminovaryze	1a, 7, 9, 10, 12	120g Turkey Noodles with Herbs, Leek and Cream, jasmine Rice	2
1348	300g Cizrnové kari s rajčaty, cuketou a jogurtem, basmati rýže, bez lepku	300gcizrnovekarisrajcaty,cuketouajogurtem,basmatiryze,bezlepku	7, 9, 10	300g Chickpea Curry with Tomatoes, Courgette and Yoghurt, basmati Rice, gluten Free	2
1349	120g Grilované krůtí kousky, salát tabbouleh s bulgurem, fenyklem a mátou	120ggrilovanekrutikousky,salattabboulehsbulgurem,fenyklemamatou	1a, 1b, 3, 5, 7, 9, 10, 11, 12	120g Grilled Turkey Pieces	6
1350	300g Veganský Buddha Bowl s pikantním humusem	300gveganskybuddhabowlspikantnimhumusem	6, 11	300g Vegan Buddha Bowl with Spicy Hummus	6
1351	100g Smažený sýrový špíz, bramborové hranolky	100gsmazenysyrovyspiz,bramborovehranolky	1a, 3, 7, 10	100g Fried Cheese Skewer, potato French Fries	6
1352	350g POKE BOWL s uzeným lososem	350gpokebowlsuzenymlososem	4, 6, 7, 9, 11	350g POKE BOWL s uzeným lososem	6
1353	120g Řízečky z panenky v panko strouhance, opékané brambory, jogurtový dip	120grizeckyzpanenkyvpankostrouhance,opekanebrambory,jogurtovydip	1a, 3, 7, 11	120g Undercut Schnitzels in Panko Crumbs, roasted Potatoes, yogurt Dip	6
1356	Fazolová	fazolova	1a, 9	White Bean Soup with Vegetables and Garlic	9
1357	150g Kuřecí prsní steak s bylinkami, žampionové ragů, vařené brambory	150gkureciprsnisteaksbylinkami,zampionoveragu,varenebrambory	1, 7, 9, 10, 12	150g Chicken Breast Steak with Herbs, champignon Ragout, boiled Potatoes	2
1072	Salát S kaki a feta sýrem	salatskakiafetasyrem		\N	3
1358	150g Kuličky z mletého masa s rajskou omáčkou, těstoviny	150gkulickyzmletehomasasrajskouomackou,testoviny	1a, 3, 7, 9, 10	150g Meatballs with Tomato Sauce, pasta	2
523	250g Caesar tortilla s kuřecím masem, ančovičkovým dresinkem a sýrem	250gcaesartortillaskurecimmasem,ancovickovymdresinkemasyrem	1a, 1b, 3, 4, 5, 7, 9, 10, 11	\N	6
513	240g Pečené kuřecí stehno na karamelizované zelenině, batátové pyré, bez lepku	240gpecenekurecistehnonakaramelizovanezelenine,batatovepyre,bezlepku	3, 5, 7, 9, 10, 11	240g Roasted Chicken Leg on Caramelised Vegetables, sweet Potato Purée, gluten Free	2
971	460g Pizza AVANTI tomat, šunka, žampiony, rajčata, mozzarella 	460gpizzaavantitomat,sunka,zampiony,rajcata,mozzarella	1a, 1b, 7	460g AVANTI Pizza with Tomato Sauce, Ham, Champignons, Tomatoes and Mozzarella	8
522	250g Burito s hovězím masem, fazolemi, kukuřicí a jalapeňo mayo, bramborové hranolky	250gburitoshovezimmasem,fazolemi,kukuriciajalapenomayo,bramborovehranolky	1a, 1b, 7	250g Burrito with Beef, Beans, Corn and Jalapeño Mayo, potato French Fries	6
525	250g Ciabatta s grilovanou zeleninou, mozzarelou a ranchero dresinkem, bramborové hranolky	250gciabattasgrilovanouzeleninou,mozzarelouarancherodresinkem,bramborovehranolky	1a, 1b, 3, 7, 9	\N	6
40	120g Čevapčiči s cibulí a hořčicí, mačkané brambory, tatarská omáčka	120gcevapciciscibuliahorcici,mackanebrambory,tatarskaomacka	1a, 3, 7, 9, 10	120g Serbian Kebab with Onion and Mustard, crushed Potatoes, tartar Sauce	2
640	300g Bylinkové těstoviny ''quattro formaggi'' s goudou, nivou, eidamem a mozzarellou 	300gbylinkovetestoviny''quattroformaggi''sgoudou,nivou,eidamemamozzarellou	1a, 3, 7, 9	300g Herb Pasta “Quattro Formaggi” with Gouda, Blue Cheese, Edam and Mozzarella	2
172	120g Pečený filet ze pstruha s mandlemi a bylinkovou omáčkou, opékané rozmarýnové grenaille	120gpecenyfiletzepstruhasmandlemiabylinkovouomackou,opekanerozmarynovegrenaille	1a, 4, 7, 8, 8a, 9, 10	120g Baked Trout Fillet with Almonds and Herb Sauce, pan-fried Rosemary Grenaille Potatoes	2
641	300g Caesar salát s česnekovými krutony, grilovaným kuřecím masem a parmazánem	300gcaesarsalatscesnekovymikrutony,grilovanymkurecimmasemaparmazanem	1a, 1b, 3, 4, 5, 7, 9, 10, 11	300g Caesar Salad with Garlic Croutons, Grilled Chicken Meat and Parmesan Cheese	6
765	300g Veganské burito s tofu, grilovanou zeleninou a špenátem, rajčatová salsa, dip z kysané smetany	300gveganskeburitostofu,grilovanouzeleninouaspenatem,rajcatovasalsa,dipzkysanesmetany	1a, 1b, 3, 6, 7, 9, 10	300g Vegan Burrito with Tofu, Grilled Vegetables and Spinach, tomato Salsa, sour Cream Dip	6
128	120g Kuřecí goujons v cajun panko strouhance, trhaný salát se slunečnicovými semínky, jogurtový dip	120gkurecigoujonsvcajunpankostrouhance,trhanysalatseslunecnicovymiseminky,jogurtovydip	1a, 1b, 3, 5, 7, 9, 10, 11	120g Kuřecí goujons v cajun panko strouhance, shredded Lettuce with Sunflower Seeds, yogurt Dip	6
3	100g Grilovaný camembert, trhaný salát s cherry rajčaty a okurkami, smetanový dip	100ggrilovanycamembert,trhanysalatscherryrajcatyaokurkami,smetanovydip	1, 3, 5, 7, 9, 10, 11, 12	100g Grilled Camembert, shredded Lettuce with Cherry Potatoes and Cucumbers, creamy Dip	6
19	100g Smažený camembert, bramborové hranolky, tatarská omáčka	100gsmazenycamembert,bramborovehranolky,tatarskaomacka	1a, 3, 7, 10	100g Fried Camembert Cheese, potato French Fries, Tartar Sauce	6
24	100g Smažený hermelín, bramborové hranolky, tatarská omáčka	100gsmazenyhermelin,bramborovehranolky,tatarskaomacka	1a, 3, 7, 9, 10	\N	6
25	100g Smažený hermelín, bramborové hranolky, trhaný salát	100gsmazenyhermelin,bramborovehranolky,trhanysalat	1a, 3, 7	\N	6
95	120g Hovězí gulášek na pivě s cibulkou a feferonkou, houskový knedlík	120ghovezigulaseknapivescibulkouafeferonkou,houskovyknedlik	1a, 3, 9, 10	\N	2
131	120g Kuřecí kari Balti s kokosovým mlékem, mandlemi a koriandrem, jasmínová rýže	120gkurecikaribaltiskokosovymmlekem,mandlemiakoriandrem,jasminovaryze	1a, 1b, 8, 8a, 9, 10	\N	2
202	120g Segedínský guláš speciál, houskový knedlík	120gsegedinskygulasspecial,houskovyknedlik	1a, 3, 7, 9, 10	\N	2
203	120g Sekaná vepřová pečeně, rajská omáčka, houskový knedlík	120gsekanaveprovapecene,rajskaomacka,houskovyknedlik	1a, 3, 7, 9, 10	\N	1
543	250g Vídeňský trhanec s rozinkami a jablky, ořechová medová omáčka	250gvidenskytrhanecsrozinkamiajablky,orechovamedovaomacka	1a, 3, 7, 8, 8c, 12	\N	2
544	250g Zapečené těstoviny s kuřecím masem, brokolicí a smetanou, sypané sýrem	250gzapecenetestovinyskurecimmasem,brokoliciasmetanou,sypanesyrem	1a, 3, 7	\N	2
546	260g Jelitový a jitrnicový prejt, dušené zelí,vařené brambory	260gjelitovyajitrnicovyprejt,dusenezeli,varenebrambory	1a, 1c, 9, 10	\N	2
536	250g Smažené žampiony, vařené brambory, tatarská omáčka	250gsmazenezampiony,varenebrambory,tatarskaomacka	1a, 3, 7, 9, 10	250g Fried Champignons, boiled Potatoes, tartar Sauce	2
650	300g Cizrnový tagine s cuketami, lilkem a paprikami, bylinkový bulgur	300gcizrnovytaginescuketami,lilkemapaprikami,bylinkovybulgur	1a, 9, 10	300g Chickpea Tagine with Zucchini, Aubergine and Sweet Peppers, bulgur with Herbs	2
626	300g Aloo bhaji-bramborové kari s rajčaty  a jogurtem, bylinkový kuskus	300galoobhaji-bramborovekarisrajcatyajogurtem,bylinkovykuskus	1a, 1b, 7, 9, 10, 11	\N	2
628	300g Boloňské lassagne s hovězím masem sypané sýrem gran biraghi	300gbolonskelassagneshovezimmasemsypanesyremgranbiraghi	1a, 3, 7	\N	2
631	300g Bramborové halušky s pečenou dýní a krémovou bylinkovou omáčkou	300gbramborovehaluskyspecenoudyniakremovoubylinkovouomackou	1a, 3, 7, 9	\N	2
632	300g Bramborové šulánky, ořechová strouhanka	300gbramborovesulanky,orechovastrouhanka	1a, 3, 7, 8, 8c	\N	1
634	300g Bramborové šulánky plněné mákem se staročeskou posýpkou a přepuštěným máslem	300gbramborovesulankyplnenemakemsestaroceskouposypkouaprepustenymmaslem	1a, 3, 7, 8, 8c	\N	1
635	300g Bramborové šulánky s vanilkovým máslem a ořechovou strouhankou	300gbramborovesulankysvanilkovymmaslemaorechovoustrouhankou	1a, 3, 7, 8, 8c	\N	2
636	300g Bulgureto s hovězím masem a zeleninou sypané sýrem	300gbulguretoshovezimmasemazeleninousypanesyrem	1a, 7	\N	2
637	300g Bulgureto s kuřecím masem, rajčaty a zeleninou, strouhaný sýr gouda	300gbulguretoskurecimmasem,rajcatyazeleninou,strouhanysyrgouda	1a, 7	\N	2
645	300g Celozrnné špagety s kuřecím masem, arrabiatta omáčka a strouhaný sýr	300gcelozrnnespagetyskurecimmasem,arrabiattaomackaastrouhanysyr	1a, 1b, 3, 6, 7, 9, 10	\N	2
545	250g Zapečené těstoviny s kuřecím masem a brokolicí sypané sýrem	250gzapecenetestovinyskurecimmasemabrokolicisypanesyrem	1a, 3, 7	250g Scalloped Pasta with Chicken Meat and Broccoli, Sprinkled with Cheese	2
96	120g Hovězí gulášek na pivě s cibulkou a feferonkou, kmínový chléb	120ghovezigulaseknapivescibulkouafeferonkou,kminovychleb	1a, 9, 10	120g Beef Goulash in Beer Sauce with Onion and Hot Pepper , caraway Seed Bread	2
1583	Silný hovězí guláš s černým pivem a cibulí, houskový knedlík	silnyhovezigulasscernympivemacibuli,houskovyknedlik	1a, 3, 9, 10	Rich Beef Goulash with Dark Beer and Onions, bread Dumplings	2
642	300g Caesar salát s krutony a kuřecím masem, gran biraghi	300gcaesarsalatskrutonyakurecimmasem,granbiraghi	1a, 3, 4, 7, 9, 10	300g Caesar Salad with Croutons and Chicken Meat, Gran Biraghi Cheese	2
629	300g Boloňské špagety s vepřovým masem, strouhaný sýr	300gbolonskespagetysveprovymmasem,strouhanysyr	1a, 3, 6, 7, 9, 10	300g Spaghetti Bolognese with Pork, grated Cheese	2
236	120g Tortilla plněná kuřecí směsí se zeleninou, zeleninová obloha, smetanový dip	120gtortillaplnenakurecismesisezeleninou,zeleninovaobloha,smetanovydip	1a, 3, 5, 7, 9, 10, 11	\N	6
646	300g Chana masala s pečenou paprikou, tofu a mangetout, dušená rýže, bez lepku	300gchanamasalaspecenoupaprikou,tofuamangetout,dusenaryze,bezlepku	6, 9, 10	\N	2
649	300g Cizrnový tagine s cuketami, lilkem a paprikami, basmati rýže	300gcizrnovytaginescuketami,lilkemapaprikami,basmatiryze	1a, 9, 10	\N	1
651	300g Cizrnový tagine s cuketami, lilkem a paprikami, dušená rýže	300gcizrnovytaginescuketami,lilkemapaprikami,dusenaryze	1a, 9, 10	\N	1
652	300g Cizrnový tagine s cuketami, lilkem a paprikami, zeleninový kuskus	300gcizrnovytaginescuketami,lilkemapaprikami,zeleninovykuskus	1a, 1b, 9, 10	\N	2
653	300g Čočka na kyselo s cibulkou, 2 vejce, chléb, sterilovaný  okurek	300gcockanakyseloscibulkou,2vejce,chleb,sterilovanyokurek	1a, 3, 10	\N	2
995	BIO Slepičí vývar se zeleninou, těstovinová rýže	bioslepicivyvarsezeleninou,testovinovaryze	1a, 3, 9	\N	9
630	300g Bramborové halušky s brynzou a opečenou anglickou slaninou	300gbramborovehaluskysbrynzouaopecenouanglickouslaninou	1a, 3, 7	300g Potato Gnocchi with Sheep Cheese and Roasted Bacon	2
656	300g Dýňový salát s jogurtem, rukolou a ořechy, sýr Feta, opečený toast	300gdynovysalatsjogurtem,rukolouaorechy,syrfeta,opecenytoast	1a, 3, 7, 8, 8c, 9	\N	6
658	300g Džuveč z vepřového masa se zeleninou, sýr gouda, kyselý okurek	300gdzuveczveprovehomasasezeleninou,syrgouda,kyselyokurek	7, 9, 10	\N	2
660	300g Fettucciny s třísýrovou omáčkou z nivy,goudy a parmazánu s bazalkovým pestem	300gfettuccinystrisyrovouomackouznivy,goudyaparmazanusbazalkovympestem	1a, 3, 7, 9	\N	2
662	300g Fetuciny s tuňákem, bazalkou a rajčatovou omáčkou	300gfetucinystunakem,bazalkouarajcatovouomackou	1a, 3, 4, 7, 9	\N	2
664	300g Gnocchi s rajčatovou omáčkou, mozzarella kuličkami a bazalkou	300ggnocchisrajcatovouomackou,mozzarellakulickamiabazalkou	1a, 7, 9	\N	2
665	300g Gratinované gnocchi s rajčatovou omáčkou a bazalkou, sýr	300ggratinovanegnocchisrajcatovouomackouabazalkou,syr	1a, 1b, 3, 6, 7, 9, 10	\N	6
668	300g Hrachová kaše, 2 vejce, chléb, sterilovaný  okurek	300ghrachovakase,2vejce,chleb,sterilovanyokurek	1a, 3, 9, 10	\N	2
669	300g Hrachová kaše, sázené vejce, opečená klobása, kmínový chléb, sterilovaný okurek	300ghrachovakase,sazenevejce,opecenaklobasa,kminovychleb,sterilovanyokurek	1a, 3, 9, 10	\N	2
671	300g Hrachová kaše s uzeným česnekem, šunkovou klobásou, cibulkou a chlebem	300ghrachovakasesuzenymcesnekem,sunkovouklobasou,cibulkouachlebem	1a, 9	\N	2
672	300g Hrachová kaše s uzeným česnekem a cibulkou, 2 vejce, chléb kmínový	300ghrachovakasesuzenymcesnekemacibulkou,2vejce,chlebkminovy	1a, 3, 9	\N	2
673	300g Konfitované kachní stehno, červené zelí s vínem a jablky, bramborový knedlík	300gkonfitovanekachnistehno,cervenezelisvinemajablky,bramborovyknedlik	1a, 3, 9, 10, 12	\N	2
675	300g Kovbojské fazole s klobásou, cibulí, slaninou a rajčaty, kmínový chléb	300gkovbojskefazolesklobasou,cibuli,slaninouarajcaty,kminovychleb	1a, 9	\N	1
676	300g Kuřecí paličky pečené na medu a hrubozrnné hořčici, pečené grenaile, coleslaw s jablky bez lepku	300gkurecipalickypecenenameduahrubozrnnehorcici,pecenegrenaile,coleslawsjablkybezlepku	3, 5, 7, 9, 10, 11	\N	2
677	300g Kuskus zeleninový salát, dip z kysané smetany	300gkuskuszeleninovysalat,dipzkysanesmetany	1a, 7, 9	\N	6
678	300g Kuskus zeleninový salát, dresink	300gkuskuszeleninovysalat,dresink	1a, 7, 9	\N	6
680	300g Linguinny s boloňským ragú z čočky a cizrny s gran biraghi 	300glinguinnysbolonskymraguzcockyacizrnysgranbiraghi	1a, 3, 6, 7, 9, 10	\N	2
682	300g Linguiny se smetanovou omáčkou z pečených paprik a rajčat, sypané sýrem	300glinguinysesmetanovouomackouzpecenychpaprikarajcat,sypanesyrem	1a, 3, 7, 9	\N	2
684	300g Lívance s čerstvým ovocem, javorový sirup, šlehaný tvaroh	300glivancescerstvymovocem,javorovysirup,slehanytvaroh	1, 6, 7	\N	2
685	300g Luštěninové ragů s pečenou podzimní zeleninou a rajčaty	300glusteninoveraguspecenoupodzimnizeleninouarajcaty	9, 10	\N	2
686	300g Luštěninové ragů s pečenou podzimní zeleninou a rajčaty, basmati rýže, bez lepku	300glusteninoveraguspecenoupodzimnizeleninouarajcaty,basmatiryze,bezlepku	9, 10	\N	1
1584	2 Sterilovaná hotovka ve skle  - Rajská s kuličkami, Vrabec se zelím, Vepř.krkovice s pepř.om., Segedínský guláš	2sterilovanahotovkaveskle-rajskaskulickami,vrabecsezelim,vepr.krkovicespepr.om.,segedinskygulas		2 Sterilovaná hotovka ve skle  - Rajská s kuličkami, Vrabec se zelím, Vepř.krkovice s pepř.om., Segedínský guláš	5
657	300g Džuveč z kuřecího masa se strouhaným sýrem	300gdzuveczkurecihomasasestrouhanymsyrem	7, 9	300g Stewed Chicken Meat with Grated Cheese	2
674	300g Koprová omáčka, 2 ks vejce, vařené brambory	300gkoprovaomacka,2ksvejce,varenebrambory	1a, 3, 7, 9	300g Dill Sauce, 2 Eggs, boiled Potatoes	2
661	300g Fettucciny s třísýrovou omáčkou z nivy, goudy a parmazánu s pestem z baby špenátu	300gfettuccinystrisyrovouomackouznivy,goudyaparmazanuspestemzbabyspenatu	1a, 1b, 3, 7, 9	300g Fettuccine Pasta with Blue Cheese, Gouda Cheese and Parmesan Sauce with Baby Spinach Pesto	2
683	300g Linguiny s krémovou rajčatovou omáčkou , strouhaný sýr	300glinguinyskremovourajcatovouomackou,strouhanysyr	1a, 3, 6, 7, 9, 10	300g Linguine Pasta in a Creamy Tomato Sauce, grated Cheese	2
659	300g Džuveč z vepřového masa se zeleninou, sýr gouda, sterilovaný okurek	300gdzuveczveprovehomasasezeleninou,syrgouda,sterilovanyokurek	7, 9, 10	300g Stewed Pork Meat with Vegetables, Gouda Cheese, gherkin	2
681	300g Linguinny se špenátovým pestem, karamelizovanou šalotkou a feta sýrem	300glinguinnysespenatovympestem,karamelizovanousalotkouafetasyrem	1a, 3, 7, 9, 12	300g Linguine with Spinach Pesto, Caramelized Shallot and Feta Cheese	2
670	300g Hrachová kaše s cibulkou, vařené vejce, chléb, sterilovaný okurek	300ghrachovakasescibulkou,varenevejce,chleb,sterilovanyokurek	1a, 3, 9, 10	300g Pea Mash with Onions and Boiled Egg, bread, Gherkin	2
648	300g Cizrnové kari s cuketou, kokosovým krémem, koriandrem, biryami rýže	300gcizrnovekariscuketou,kokosovymkremem,koriandrem,biryamiryze	1a, 1b, 7, 9, 10	300g Chickpea Curry with Courgette, Coconut Cream and Coriander, biryani Rice	2
272	130g Filet z candáta s bylinkovou tapenádou, mačkané brambory	130gfiletzcandatasbylinkovoutapenadou,mackanebrambory	1, 4, 5, 6, 7, 9, 10, 11	\N	1
663	300g Fetuciny s tuňákem, bazalkou a rajčatovou omáčkou, sýr gran biraghi	300gfetucinystunakem,bazalkouarajcatovouomackou,syrgranbiraghi	1a, 3, 4, 7, 9	300g Fettuccine Pasta with Tuna, Basil and Tomato Sauce, gran Biraghi Cheese	2
666	300g Gratinované gnochi s kuřecím masem,rajčatovou omáčkou,bazalkou a parmazánem	300ggratinovanegnochiskurecimmasem,rajcatovouomackou,bazalkouaparmazanem	1a, 1b, 3, 6, 7, 9, 10	300g Scalloped Gnocchi with Chicken Meat, Tomato Sauce, Basil and Parmesan Cheese	6
654	300g Čočka na kyselo s cibulkou, 2 vejce, kmínový chléb, sterilovaný okurek	300gcockanakyseloscibulkou,2vejce,kminovychleb,sterilovanyokurek	1a, 3, 10	300g Sour Lentils with Onion, 2 Eggs, caraway Bread, Gherkin	2
691	300g Palačinky s nutellou, šlehačkou a čerstvým ovocem	300gpalacinkysnutellou,slehackouacerstvymovocem	1a, 3, 6, 7	\N	2
692	300g Pečená kuřecí křídla, kari coleslaw, bramborové hranolky	300gpecenakurecikridla,karicoleslaw,bramborovehranolky	1a, 1b, 3, 5, 6, 7, 9, 10, 11	\N	6
693	300g Pečené kuřecí paličky, kari coleslaw, pečené grenaile	300gpecenekurecipalicky,karicoleslaw,pecenegrenaile	1, 3, 5, 7, 9, 10, 11	\N	2
694	300g Pečené kuřecí paličky marinované v medu a sweet chilli omáčce, smažené hranolky, salát Coleslaw	300gpecenekurecipalickymarinovanevmeduasweetchilliomacce,smazenehranolky,salatcoleslaw	1, 3, 5, 6, 7, 9, 10, 11	\N	2
695	300g Pečené vepřové žebra na medu, bramborové hranolky, kari coleslaw	300gpeceneveprovezebranamedu,bramborovehranolky,karicoleslaw	1a, 1b, 3, 7, 9, 10	\N	6
696	300g Pečený filet z mořského pstruha s bylinkami,grilovanou zeleninou a grenaille bramborami	300gpecenyfiletzmorskehopstruhasbylinkami,grilovanouzeleninouagrenaillebramborami	1, 4, 7, 9, 10	\N	1
697	300g Penne se sušenými rajčaty, rukolou, česnekem a rajčatovou salsou, strouhaný sýr	300gpennesesusenymirajcaty,rukolou,cesnekemarajcatovousalsou,strouhanysyr	1a, 3, 6, 7, 9, 10	\N	2
698	300g Penne se sýrovou omáčkou a kuřecími kousky, sypané sýrem	300gpennesesyrovouomackouakurecimikousky,sypanesyrem	1a, 3, 7, 9	\N	2
700	300g Pikantní penne Arabiatta omáčkou z cherry rajčat a chilli, sypané sýrem gran biraghi	300gpikantnipennearabiattaomackouzcherryrajcatachilli,sypanesyremgranbiraghi	1a, 3, 7	\N	2
701	300g Plněné pečené papriky s čočkou, zeleninou a feta sýrem, trhaný salát, bylinkový dip	300gplnenepecenepaprikyscockou,zeleninouafetasyrem,trhanysalat,bylinkovydip	7, 9	\N	1
702	300g Plněné pečené papriky s čočkou, zeleninou a feta sýrem, trhaný salát s cherry rajčaty a okurkami, bylinkový dip	300gplnenepecenepaprikyscockou,zeleninouafetasyrem,trhanysalatscherryrajcatyaokurkami,bylinkovydip	7, 9	\N	2
703	300g Ragú z červené řepy s batáty, dýní, čočkou a karotkou, zeleninový kuskus	300graguzcervenerepysbataty,dyni,cockouakarotkou,zeleninovykuskus	1a, 9, 12	\N	2
704	300g Ragú  z červené řepy s batáty, dýní, mrkví a jarní cibulí, basmati rýže, bez lepku	300graguzcervenerepysbataty,dyni,mrkviajarnicibuli,basmatiryze,bezlepku	9, 12	\N	1
705	300g Ragú z červené řepy s batáty, dýní a baby karotkami, čočkový pilaf se zeleninou a bylinkami	300graguzcervenerepysbataty,dyniababykarotkami,cockovypilafsezeleninouabylinkami	9, 12	\N	2
706	300g Ragú z červené řepy s batáty, dýní a baby karotkami, čočkový pilaf se zeleninou a bylinkami, bez lepku	300graguzcervenerepysbataty,dyniababykarotkami,cockovypilafsezeleninouabylinkami,bezlepku	9, 12	\N	2
708	300g Ragú z francouzské čočky se zeleninou a bylinkami, basmati rýže	300graguzfrancouzskecockysezeleninouabylinkami,basmatiryze	1a, 7	\N	1
710	300g Řecký salát se sýrem feta a kuřecími kousky, pita chléb	300greckysalatsesyremfetaakurecimikousky,pitachleb	1a, 7	\N	2
711	300g Římský salát s cherry rajčaty, okurkami, kapary a olivami, grilované tofu	300grimskysalatscherryrajcaty,okurkami,kaparyaolivami,grilovanetofu	1a, 7, 10	\N	2
712	300g Salát s grilovanou zeleninou a grenaille bramborami, filetovaná vepřová panenka	300gsalatsgrilovanouzeleninouagrenaillebramborami,filetovanaveprovapanenka	9	\N	2
714	300g Salát Tabbouleh s bulgurem, filetovaná vepřová panenka	300gsalattabboulehsbulgurem,filetovanaveprovapanenka	1a, 3, 9	\N	2
715	300g Smažené cuketové medailonky, karotkové pyré, bylinkový dip	300gsmazenecuketovemedailonky,karotkovepyre,bylinkovydip	1a, 3, 7, 9	\N	2
718	300g Šoulet z krup a hrachu s krůtím masem, majoránkou, česnekem a podzimní zeleninou, kyselý okurek	300gsouletzkrupahrachuskrutimmasem,majorankou,cesnekemapodzimnizeleninou,kyselyokurek	1a, 1b, 9, 10	\N	2
719	300g Šoulet z krup a hrachu s krůtím masem, majoránkou, česnekem a podzimní zeleninou, kyselý okurek, bez lepku	300gsouletzkrupahrachuskrutimmasem,majorankou,cesnekemapodzimnizeleninou,kyselyokurek,bezlepku	9, 10	\N	1
720	300g Špagety aglio-olio s cherry rajčaty, chilli, mladým špenátem a sýrem gran biraghi	300gspagetyaglio-olioscherryrajcaty,chilli,mladymspenatemasyremgranbiraghi	1a, 3, 7	\N	2
709	300g Ragú z francouzské čočky se zeleninou a bylinkami, bramborové gnocchi	300graguzfrancouzskecockysezeleninouabylinkami,bramborovegnocchi	1a, 7	300g French Lentil Ragout with Vegetables and Herbs, potato Gnocchi	2
716	300g Smažené cuketové medailonky, mačkané brambory, tatarská omáčka	300gsmazenecuketovemedailonky,mackanebrambory,tatarskaomacka	1a, 3, 7, 9, 10	300g Fried Zucchini Noisettes, crushed Potatoes, tartar Sauce	1
699	300g Pikantní penne Arabiatta, sypané sýrem gran biraghi	300gpikantnipennearabiatta,sypanesyremgranbiraghi	1a, 3, 7	300g Spicy Penne Arabiata, Sprinkled with Grana Padano Cheese	2
726	300g Špagety s bazalkovým ragů s rajčaty, olivami a sýrem gran biraghi	300gspagetysbazalkovymragusrajcaty,olivamiasyremgranbiraghi	1a, 3, 6, 7, 9, 10	\N	2
722	300g Špagety carbonara, gran biraghi	300gspagetycarbonara,granbiraghi	1a, 3, 7	300g Spaghetti alla Carbonara, Gran Biraghi Cheese	2
721	300g Špagety aglio-olio sypané sýrem gran biraghi	300gspagetyaglio-oliosypanesyremgranbiraghi	1a, 3, 7	300g Aglio Olio Spaghetti Sprinkled with Gran Biraghi Cheese	2
713	300g Salát s rýžovými nudlemi, krevetami, bok-choi zeleninou a sezamovo limetovou zálivkou	300gsalatsryzovyminudlemi,krevetami,bok-choizeleninouasezamovolimetovouzalivkou	1a, 1b, 2, 3, 6, 7, 9, 11	300g Salad with Rice Noodles, Prawns, Bok Choy and Sesame-lime Dressing	6
305	130g Pečený marinovaný losos, fazolky se šalotkou, opečený brambor	130gpecenymarinovanylosos,fazolkysesalotkou,opecenybrambor	4, 10	\N	2
728	300g Srbské rizoto se zeleninou a kuřecím masem, sypané sýrem, trhaný salát	300gsrbskerizotosezeleninouakurecimmasem,sypanesyrem,trhanysalat	1, 7, 9, 10	\N	2
729	300g Strapačky s kysaným zelím a uzeným masem	300gstrapackyskysanymzelimauzenymmasem	1a, 3, 9	\N	2
730	300g Šunkofleky s uzeným masem, kyselý okurek	300gsunkoflekysuzenymmasem,kyselyokurek	1a, 3, 7, 9, 10	\N	2
732	300g Sýrové tortellini s omáčkou all arrabbiata se sušenými rajčaty, chilli, česnekem a sýrem gran biraghi	300gsyrovetortellinisomackouallarrabbiatasesusenymirajcaty,chilli,cesnekemasyremgranbiraghi	1a, 3, 7	\N	2
733	300g Tagliatelle s kuřecími kousky, bazalkovým pestem, rajčaty, rukolou a mozzarella kuličkami	300gtagliatelleskurecimikousky,bazalkovympestem,rajcaty,rukolouamozzarellakulickami	1a, 3, 7, 10	\N	2
734	300g Tagliatelle s restovanou cuketou, kápií,mladým špenátem a smetanovou omáčkou	300gtagliatellesrestovanoucuketou,kapii,mladymspenatemasmetanovouomackou	1a, 3, 7, 9	\N	2
740	300g Těstovinový salát s balkánským sýrem	300gtestovinovysalatsbalkanskymsyrem	1a, 3, 7, 9	\N	6
741	300g Těstovinový salát s balkánským sýrem, smetanový dip	300gtestovinovysalatsbalkanskymsyrem,smetanovydip	1a, 7, 9	\N	6
742	300g Těstovinový salát se zeleninou, mozzarellou, sušenými rajčaty a kuřecími kousky	300gtestovinovysalatsezeleninou,mozzarellou,susenymirajcatyakurecimikousky	1a, 3, 7, 10	\N	2
746	300g Těstovinový salát s francouzským dresinkem, filovaná vepřová panenka	300gtestovinovysalatsfrancouzskymdresinkem,filovanaveprovapanenka	1a, 3, 7, 9	\N	2
747	300g Těstovinový salát s grilovanou zeleninou a cherry rajčaty sypané sýrem gran biraghi, grilovaný sýr Halloumi	300gtestovinovysalatsgrilovanouzeleninouacherryrajcatysypanesyremgranbiraghi,grilovanysyrhalloumi	1a, 3, 7, 9	\N	2
749	300g Těstovinový salát s tuňákem, cherry rajčaty, okurkou, olivami a sázeným vejcem	300gtestovinovysalatstunakem,cherryrajcaty,okurkou,olivamiasazenymvejcem	1a, 3, 4, 7, 9	\N	2
750	300g Těstovinový salát s tuňákem, dresink	300gtestovinovysalatstunakem,dresink	1a, 3, 4, 7, 9	\N	6
751	300g Těstovinový salát s tuňákem, fazolemi a čerstvou zeleninou, smetanový dip	300gtestovinovysalatstunakem,fazolemiacerstvouzeleninou,smetanovydip	1a, 3, 4, 7, 9	\N	6
752	300g Těstovinový salát s tuňákem, okurkou, cherry rajčaty a vejci	300gtestovinovysalatstunakem,okurkou,cherryrajcatyavejci	1a, 3, 4, 7, 9	\N	2
753	300g Těstoviny fusilli se žampiony, kuřecím masem a lilkovým pestem sypané sýrem	300gtestovinyfusillisezampiony,kurecimmasemalilkovympestemsypanesyrem	1a, 3, 7, 9	\N	2
754	300g Těstoviny penne s krevetami, sušenými rajčaty, kapary a olivami, rukola	300gtestovinypenneskrevetami,susenymirajcaty,kaparyaolivami,rukola	1a, 2, 3, 9, 10	\N	2
755	300g Těstoviny s kuřecím masem, smetanou, paprikou, cherry rajčaty a baby špenátem sypané sýrem	300gtestovinyskurecimmasem,smetanou,paprikou,cherryrajcatyababyspenatemsypanesyrem	1a, 3, 7, 9	\N	2
756	300g Thajské Pad-Thai s brokolicí, paprikou, pekingským zelím, vaječnými nudlemi a ústřicovou omáčkou	300gthajskepad-thaisbrokolici,paprikou,pekingskymzelim,vajecnyminudlemiaustricovouomackou	1a, 3, 6, 7, 9, 10	\N	2
757	300g Thajské Pad-Thai s tofu a vaječnými nudlemi, zeleninou, limetkou a ústřicovou omáčkou	300gthajskepad-thaistofuavajecnyminudlemi,zeleninou,limetkouaustricovouomackou	1a, 1b, 3, 4, 6, 7, 9, 10, 14a	\N	2
758	300g Tortelliny plněné masem se smetanovou omáčkou, sypané sýrem gran biraghi	300gtortellinyplnenemasemsesmetanovouomackou,sypanesyremgranbiraghi	1a, 3, 7	\N	2
748	300g Těstovinový salát s kuřecím gyrosem, dresink	300gtestovinovysalatskurecimgyrosem,dresink	1a, 3, 7, 9	300g Pasta Salad with Chicken Gyros and Vegetables, dressing	6
738	300g Taštičky s povidly, přepuštěným máslem a staročeskou posýpkou	300gtastickyspovidly,prepustenymmaslemastaroceskouposypkou	1a, 3, 7	300g Turnovers Filled with Plum Jam, Melted Butter and Crumble	2
724	300g Špagety po boloňsku s vepřovým masem a sýrem gran biraghi	300gspagetypobolonskusveprovymmasemasyremgranbiraghi	1a, 3, 6, 7, 9, 10	300g Spaghetti Bolognese with Pork Meat and Gran Biraghi Cheese	2
759	300g Tortilla plněná vepřovým masem a zeleninou, bramborové hranolky, pikantní dip	300gtortillaplnenaveprovymmasemazeleninou,bramborovehranolky,pikantnidip	1a, 7, 9	\N	6
760	300g Toskánské pappardelle s vepřovým masem, rajčaty a strouhaným sýrem	300gtoskanskepappardellesveprovymmasem,rajcatyastrouhanymsyrem	1a, 3, 6, 7, 9, 10, 12	\N	2
763	300g Tvarohové knedlíky s nugátovou náplní, šlehaná kysaná smetana, přepuštěné máslo	300gtvarohoveknedlikysnugatovounaplni,slehanakysanasmetana,prepustenemaslo	1a, 3, 7, 8, 8b	\N	2
767	300g Veganské zeleninové ragů s uzeným tofu a pečenou paprikou, basmati rýže	300gveganskezeleninoveragusuzenymtofuapecenoupaprikou,basmatiryze	6, 9	\N	1
731	300g Šunkofleky s uzeným masem, okurkový salát	300gsunkoflekysuzenymmasem,okurkovysalat	1a, 3, 7, 9	300g Pasta and Ham Casserole with Smoked Meat , cucumber Salad	2
768	300g Veganské zeleninové ragů s uzeným tofu a pečenou paprikou, basmati rýže, bez lepku	300gveganskezeleninoveragusuzenymtofuapecenoupaprikou,basmatiryze,bezlepku	6, 9	\N	2
769	300g Veganské zeleninové ragů s uzeným tofu a pečenou paprikou, dušená rýže	300gveganskezeleninoveragusuzenymtofuapecenoupaprikou,dusenaryze	6, 9	\N	2
770	300g Veganský dhal ze žlutého hrachu se zeleninou a baby špenátem, jasmínová rýže, bez lepku	300gveganskydhalzezlutehohrachusezeleninouababyspenatem,jasminovaryze,bezlepku	1, 6, 9, 10	\N	2
737	300g Tagliatelle s uzeným lososem, špenátem a smetanovou omáčkou , bazalkové pesto	300gtagliatellesuzenymlososem,spenatemasmetanovouomackou,bazalkovepesto	1a, 3, 4, 7, 9	300g Tagliatelle with Smoked Salmon, Spinach and Cream Sauce, basil Pesto	2
745	300g Těstovinový salát se zeleninou a pestem ze sušených rajčat a bazalky, mozzarella kuličky	300gtestovinovysalatsezeleninouapestemzesusenychrajcatabazalky,mozzarellakulicky	1a, 3, 7, 10	300g Pasta Salad with Vegetables and Dried Tomato Pesto with Basil, Mozzarella Balls 	2
736	300g Tagliatelle s uzeným lososem, špenátem, smetanovou omáčkou a sýrem gran biraghi	300gtagliatellesuzenymlososem,spenatem,smetanovouomackouasyremgranbiraghi	1a, 3, 4, 7, 9	300g Tagliatelle with Smoked Salmon, Spinach, Cream Sauce and Gran Biraghi Cheese	2
339	150g Kuřecí kapsa plněná sušenými rajčaty a mozzarelou, smažené hranolky, trhaný salát	150gkurecikapsaplnenasusenymirajcatyamozzarelou,smazenehranolky,trhanysalat	1a, 7, 9	\N	2
771	300g Veganský dhal ze žlutého hrachu s tofu, batáty a špenátem , jasmínová rýže, bez lepku	300gveganskydhalzezlutehohrachustofu,batatyaspenatem,jasminovaryze,bezlepku	6, 9, 10	\N	2
772	300g Vegetariánská zeleninová korma s kokosovým krémem a mandlemi, biryami rýže, bez lepku	300gvegetarianskazeleninovakormaskokosovymkrememamandlemi,biryamiryze,bezlepku	7, 8, 8a, 9, 10	\N	2
773	300g Vegetariánské bramborové halušky s pečenou cuketou, šlehanou kysanou smetanou a šalotkou	300gvegetarianskebramborovehaluskyspecenoucuketou,slehanoukysanousmetanouasalotkou	1a, 3, 7, 9	\N	2
774	300g Vegetariánské bramborové halušky s pečenou dýní, šlehanou kysanou smetanou a šalotkou	300gvegetarianskebramborovehaluskyspecenoudyni,slehanoukysanousmetanouasalotkou	1a, 3, 7, 9	\N	2
775	300g Vegetariánské chow mein se zeleninou, teryiaki omáčkou a pečenými kari nudlemi	300gvegetarianskechowmeinsezeleninou,teryiakiomackouapecenymikarinudlemi	1a, 3, 6, 7, 9, 10, 11	\N	2
776	300g Vídeňský trhanec s rozinkami a jablky, ořechová medová omáčka	300gvidenskytrhanecsrozinkamiajablky,orechovamedovaomacka	1a, 3, 7, 8, 8c, 12	\N	2
778	300g Zapečená plněná cuketa s boloňským ragú a rajčaty, hovězím masem a sýrem, trhaný salát s cherry rajčaty a okurkami, bylinkový dip	300gzapecenaplnenacuketasbolonskymraguarajcaty,hovezimmasemasyrem,trhanysalatscherryrajcatyaokurkami,bylinkovydip	7, 9	\N	2
779	300g Zapečené francouzské brambory s uzeným masem, kyselý okurek	300gzapecenefrancouzskebramborysuzenymmasem,kyselyokurek	1a, 3, 7, 9, 10, 12	\N	2
780	300g Zapečené francouzské brambory s uzeným masem, sterilovaný okurek	300gzapecenefrancouzskebramborysuzenymmasem,sterilovanyokurek	3, 7, 9, 10	\N	1
781	300g Zapečené lívance s tvarohem a bílkovým mandlovým sněhem	300gzapecenelivancestvarohemabilkovymmandlovymsnehem	1a, 1b, 3, 7, 8, 8a, 12	\N	2
782	300g Zapečené palačinky plněné masovou směsí se zeleninou, rajčaty a sýrem	300gzapecenepalacinkyplnenemasovousmesisezeleninou,rajcatyasyrem	1a, 3, 7, 9	\N	2
783	300g Zeleninové kari s cuketami, batáty a cizrnou, basmati rýže	300gzeleninovekariscuketami,batatyacizrnou,basmatiryze	1, 9	\N	2
787	300g Zeleninové stew s máslovou dýní, cuketou a červenou paprikou, bylinkový bulgur	300gzeleninovestewsmaslovoudyni,cuketouacervenoupaprikou,bylinkovybulgur	1a, 9, 10, 12	\N	2
788	300g Zeleninové stew s máslovou dýní, cuketou a červenou paprikou, dušená rýže	300gzeleninovestewsmaslovoudyni,cuketouacervenoupaprikou,dusenaryze	1a, 9, 10, 12	\N	1
789	300g Zeleninový bulgur s brokolicí, květákem a pečenou česnekovou cuketou, strouhaný sýr	300gzeleninovybulgursbrokolici,kvetakemapecenoucesnekovoucuketou,strouhanysyr	1a, 7, 9	\N	2
790	300g Zeleninový cassoulet s tofu, fazolemi, pečenými cherry rajčaty a červenou řepou, bylinková tarhoňa	300gzeleninovycassouletstofu,fazolemi,pecenymicherryrajcatyacervenourepou,bylinkovatarhona	1a, 3, 6, 9, 10	\N	2
792	300g Zeleninový salát s čerstvou zeleninou, jogurtovým dipem a smaženým hermelínem	300gzeleninovysalatscerstvouzeleninou,jogurtovymdipemasmazenymhermelinem	1a, 3, 7, 9	\N	2
999	Bramborová s houbami	bramborovashoubami	1a, 9	\N	9
794	300g Zeleninový salát s cizrnou, cherry rajčaty a kukuřicí, grilovaný sýr Halloumi	300gzeleninovysalatscizrnou,cherryrajcatyakukurici,grilovanysyrhalloumi	1, 3, 5, 7, 9, 10, 11	\N	2
795	300g Zeleninový salát s cizrnou, cherry rajčaty a kukuřicí, grilovaný sýr Halloumi, opečený toast	300gzeleninovysalatscizrnou,cherryrajcatyakukurici,grilovanysyrhalloumi,opecenytoast	1a, 3, 5, 7, 9, 10, 11	\N	2
797	300g Zeleninový salát s hořčicovým dresinkem, pečená slanina, sázené vejce, bageta	300gzeleninovysalatshorcicovymdresinkem,pecenaslanina,sazenevejce,bageta	1a, 3, 10	\N	2
798	300g Zeleninový salát s kuskusem, cherry rajčaty, kukuřicí a paprikou, trhaná vepřová krkovice	300gzeleninovysalatskuskusem,cherryrajcaty,kukuriciapaprikou,trhanaveprovakrkovice	1a, 3, 5, 7, 9, 10, 11	\N	2
799	300g Zeleninový salát s medovo-hořčicovým dresinkem, filetovaná kuřecí prsa, křupavá bagetka	300gzeleninovysalatsmedovo-horcicovymdresinkem,filetovanakureciprsa,krupavabagetka	1a, 10	\N	2
800	300g Zeleninový salát s medovým dresinkem, grilovaný camembert, opečená bageta, brusinkový dip	300gzeleninovysalatsmedovymdresinkem,grilovanycamembert,opecenabageta,brusinkovydip	1a, 7, 10	\N	2
801	300g Zeleninový salát s medovým dresinkem, grilovaný camembert, opečený toast	300gzeleninovysalatsmedovymdresinkem,grilovanycamembert,opecenytoast	1a, 7, 10	\N	2
802	300g Zeleninový salát s pečenou dýní hokaido, batáty a grilovaným sýrem Halloumi, opečený toast	300gzeleninovysalatspecenoudynihokaido,batatyagrilovanymsyremhalloumi,opecenytoast	1a, 7	\N	2
803	300g Zeleninový salát s pečenou dýní hokaido, batáty a grilovaným uzeným tofu, opečený toast	300gzeleninovysalatspecenoudynihokaido,batatyagrilovanymuzenymtofu,opecenytoast	1a, 6	\N	2
804	300g Zeleninový salát s pečenými jablky a vlašskými ořechy, filovaná vepřová panenka, citronový dresink, opečený toast	300gzeleninovysalatspecenymijablkyavlasskymiorechy,filovanaveprovapanenka,citronovydresink,opecenytoast	1a, 8, 8c, 10	\N	2
996	BIO Slepičí vývar s játrovou rýží a nudlemi	bioslepicivyvarsjatrovouryzianudlemi	1a, 3, 9	Organic Chicken Broth with Small Liver Dumplings and Noodles	9
805	300g Zeleninový salát s pečeným květákem a mrkví, kuřecí plátek na grilu, opečený toast	300gzeleninovysalatspecenymkvetakemamrkvi,kureciplateknagrilu,opecenytoast	1a, 7	\N	2
1585	150g Variace řízků z vepřové panenky a kuřecího prsa, vařené brambory, kyselý okurek	150gvariacerizkuzveprovepanenkyakurecihoprsa,varenebrambory,kyselyokurek	1a, 3, 7, 9, 10	150g Pork Tenderloin and Chicken Breast Schnitzels, boiled Potatoes, gherkin	2
791	300g Zeleninový hrnec s čočkou, pohankou, kroupami a uzeným tofu, bramborové halušky	300gzeleninovyhrnecscockou,pohankou,kroupamiauzenymtofu,bramborovehalusky	1a, 3, 6, 7, 9, 10	300g Vegetable Casserole with Lentils, Buckwheat, Barley and Smoked Tofu (Bean Curd) , potato Gnocchi	2
784	300g Zeleninové kari s paprikami, tofu a brokolicí, rýžový pilaf	300gzeleninovekarispaprikami,tofuabrokolici,ryzovypilaf	1, 6, 7, 9, 10	300g Vegetable Curry with Bell Peppers, Tofu and Broccoli, rice Pilaf	2
375	150g Marinovaná vepřová kotleta, opékané brambory, pikantní dip	150gmarinovanaveprovakotleta,opekanebrambory,pikantnidip	1a, 3, 5, 7, 9, 10, 11	\N	6
825	350g POKE BOWL s uzeným tofu	350gpokebowlsuzenymtofu	1a, 1b, 3, 6, 7, 9, 11	350g Poke Bowl with Smoked Tofu	6
809	330g Těstovinový salát s vařeným vejcem a zeleninou, dresink	330gtestovinovysalatsvarenymvejcemazeleninou,dresink	1a, 3, 7, 9	\N	6
810	350g Bramborové halušky s omáčkou z kysané smetany s restovanou cuketou a bylinkami	350gbramborovehaluskysomackouzkysanesmetanysrestovanoucuketouabylinkami	1a, 3, 7, 9	\N	2
811	350g Bulgureto s kuřecím masem, rajčaty a zeleninou, strouhaný sýr gouda	350gbulguretoskurecimmasem,rajcatyazeleninou,strouhanysyrgouda	1a, 7	\N	2
812	350g Čočka na kyselo s cibulkou, 2 vejce, chléb, sterilovaný  okurek	350gcockanakyseloscibulkou,2vejce,chleb,sterilovanyokurek	1a, 3, 10	\N	2
813	350g Čočka na kyselo s cibulkou, 2 vejce, kmínový chléb, sterilovaný okurek	350gcockanakyseloscibulkou,2vejce,kminovychleb,sterilovanyokurek	1a, 3, 10	\N	2
815	350g Fussilli s třísýrovou omáčkou z gorgonzoly, goudy a gran biraghi s bazalkovým pestem	350gfussillistrisyrovouomackouzgorgonzoly,goudyagranbiraghisbazalkovympestem	1a, 3, 7, 9	\N	2
816	350g Guláš z hlívy ústřičné s pečenou mrkví, kápií a bramborami, kmínový chléb	350ggulaszhlivyustricnespecenoumrkvi,kapiiabramborami,kminovychleb	1a, 9, 10	\N	2
817	350g Kynuté knedlíky s borůvkami, se zakysanou smetanou, sypané grankem	350gkynuteknedlikysboruvkami,sezakysanousmetanou,sypanegrankem	1a, 7	\N	2
819	350g Kynuté knedlíky s jahodami, cukr, máslo, šlehaný tvaroh, strouhaná čokoláda	350gkynuteknedlikysjahodami,cukr,maslo,slehanytvaroh,strouhanacokolada	1a, 7	\N	2
821	350g Kynuté knedlíky s jahodami, šlehaný tvaroh, strouhaná čokoláda	350gkynuteknedlikysjahodami,slehanytvaroh,strouhanacokolada	1a, 3, 6, 7	\N	2
822	350g Ovocné kynuté knedlíky, karamelizované vlašské ořechy, přepuštěné máslo	350govocnekynuteknedliky,karamelizovanevlasskeorechy,prepustenemaslo	1a, 3, 7, 8, 8c	\N	2
823	350g Pečené kuřecí stehno ala husa, bramborový knedlík	350gpecenekurecistehnoalahusa,bramborovyknedlik	1a, 3, 9, 10, 12	\N	2
827	350g Pomalu pečené kuřecí paličky marinované se sojovou omáčkou a medem, dušená rýže	350gpomalupecenekurecipalickymarinovanesesojovouomackouamedem,dusenaryze	1a, 1b, 3, 5, 6, 7, 9, 10, 11	\N	2
807	330g Pizza LARDO tomat, anglická slanina, mozzarella	330gpizzalardotomat,anglickaslanina,mozzarella	1a, 1b, 7	330g Pizza LARDO Tomato Purée, Bacon, Edam Cheese	8
830	350g Špagety po boloňsku s vepřovým masem a sýrem gran biraghi, gran biraghi sýr	350gspagetypobolonskusveprovymmasemasyremgranbiraghi,granbiraghisyr	1a, 3, 6, 7, 9, 10	\N	2
831	350g Svatomartinské konfitované kachní stehno, červené zelí s vínem a jablky, bramborový knedlík	350gsvatomartinskekonfitovanekachnistehno,cervenezelisvinemajablky,bramborovyknedlik	1a, 3, 9, 10, 12	\N	2
832	350g Tortilla s grilovaným kuřecí masem, caesar salátem  a ančovičkovým dresinkem, bramborové hranolky	350gtortillasgrilovanymkurecimasem,caesarsalatemaancovickovymdresinkem,bramborovehranolky	1a, 4, 7, 9, 10	\N	6
833	350g Tvarohové knedlíky s borůvkami, skořicová drobenka, přepuštěné máslo	350gtvarohoveknedlikysboruvkami,skoricovadrobenka,prepustenemaslo	1a, 3, 7	\N	2
834	350g Zeleninové bulgureto s pečenými paprikami a sýrem goudou	350gzeleninovebulguretospecenymipaprikamiasyremgoudou	1a, 7	\N	2
839	390g Pizza CAPRICIOSA tomat, šunka,anglická slanina, žampióny, kapie, č.olivy, mozzarella	390gpizzacapriciosatomat,sunka,anglickaslanina,zampiony,kapie,c.olivy,mozzarella	1a, 1b, 7	\N	8
840	390g Pizza PLAMEN tomat-pikant, šunka, trvanl.salám,mozzarella	390gpizzaplamentomat-pikant,sunka,trvanl.salam,mozzarella	1a, 1b, 7, 10	\N	8
824	350g POKE BOWL s chicken katsu	350gpokebowlschickenkatsu	1a, 1b, 3, 6, 7, 9, 11	350g Chicken Katsu Poke Bowl	6
1005	Cibulačka s krutony	cibulackaskrutony	1a, 9, 12	Onion Soup with Croutons	9
806	300g Zeleninový salát s tuńákem a vejcem, opečená bageta	300gzeleninovysalatstunakemavejcem,opecenabageta	1a, 3, 4, 9	300g Vegetable Salad with Tuna and Egg, toasted Baguette	2
842	390g Pizza SMETANITO tomat, niva, uzený sýr, smetana,mozzarella	390gpizzasmetanitotomat,niva,uzenysyr,smetana,mozzarella	1a, 1b, 7	390g Pizza SMETANITO Tomato Purée, Blue Cheese, Smoked Cheese, Single Cream, Edam Cheese	8
836	370g Pizza MARGHERITA tomat, eidam,mozzarella	370gpizzamargheritatomat,eidam,mozzarella	1a, 1b, 7	370g Pizza MARGHERITA Tomato Purée, Edam Cheese, Mozzarella	8
837	370g POKE BOWL s trhaným vepřovým masem 	370gpokebowlstrhanymveprovymmasem	1a, 1b, 3, 6, 7, 9, 11	370g Poke Bowl with Pulled Pork Meat	6
1001	Brokolicová s krutony	brokolicovaskrutony	1a, 7, 9	Broccoli Soup with Croutons	9
829	350g Špagety po boloňsku s vepřovým masem a sýrem gran biraghi	350gspagetypobolonskusveprovymmasemasyremgranbiraghi	1a, 3, 6, 7, 9, 10	350g Spaghetti Bolognese with Pork Meat and Gran Biraghi Cheese	2
1003	Česneková s bramborem	cesnekovasbramborem	3, 9	\N	9
957	400g Pizza PLAMEN tomat-pikant, šunka, trvanl.salám,mozzarella	400gpizzaplamentomat-pikant,sunka,trvanl.salam,mozzarella	1a, 1b, 7, 10	\N	8
959	420g Pizza CAPRICIOSA tomat, šunka,anglická slanina, žampióny, kapie, č.olivy, mozzarella	420gpizzacapriciosatomat,sunka,anglickaslanina,zampiony,kapie,c.olivy,mozzarella	1a, 1b, 7	\N	8
960	420g Pizza SPINACI S RICOTTOU, tomat, špenát listový, mozzarella, ricotta, sušená rajčata	420gpizzaspinacisricottou,tomat,spenatlistovy,mozzarella,ricotta,susenarajcata	1a, 1b, 7	\N	8
1586	150g Vepřová krkovice v pikantní omáčce, jasmínová rýže	150gveprovakrkovicevpikantniomacce,jasminovaryze	1a, 7, 9, 10	150g Pork Neck in Spicy Sauce, jasmine Rice	2
820	350g Kynuté knedlíky s jahodami, mandlová strouhanka, přepuštěné máslo	350gkynuteknedlikysjahodami,mandlovastrouhanka,prepustenemaslo	1, 3, 7, 8, 8a	350g Yeast Dumplings with Strawberries, almond Breadcrumbs, Melted Butter	1
403	150g Plněný paprikový lusk v rajské omáčce, těstoviny	150gplnenypaprikovyluskvrajskeomacce,testoviny	1a, 3, 9	150g Bell Pepper Stuffed with Minced Meat, Tomato Sauce, pasta	2
826	350g Poke bowl s uzeným tofu, sushi rýží, zeleninou a teriyaki omáčkou	350gpokebowlsuzenymtofu,sushiryzi,zeleninouateriyakiomackou	1a, 1b, 3, 6, 7, 9, 11	350g Poke Bowl with Smoked Tofu (Bean Curd), Sushi Rice, Vegetables and Teriyaki Sauce	6
406	150g Pomalu pečená vepřová krkovice na pivu, šťouchané brambory	150gpomalupecenaveprovakrkovicenapivu,stouchanebrambory	1a, 7, 9, 10	\N	2
961	430g Pizza ANANASSO tomat, ananas, eidam, oregáno	430gpizzaananassotomat,ananas,eidam,oregano	1a, 1b, 7	\N	8
991	BIO Hovězí vývar se zeleninou, babiččiny domácí nudle	biohovezivyvarsezeleninou,babiccinydomacinudle	1a, 3, 9	Organic Beef Broth with Vegetables, grandma's Homemade Noodles	9
979	480g Pizza CATANI zakysaná smetana, šunka, pórek, vejce,mozzarella	480gpizzacatanizakysanasmetana,sunka,porek,vejce,mozzarella	1a, 1b, 3, 7	480g Pizza CATANI Sour Cream, Leek, Egg, Mozzarella, Edam Cheese	8
958	400g Pizza PROSCIUTTO tomat, šunka, prosciutto,mozzarella, oregáno	400gpizzaprosciuttotomat,sunka,prosciutto,mozzarella,oregano	1a, 1b, 7	400g Pizza PROSCIUTTO Tomato Purée, Ham, Prosciutto, Edam Cheese, Oregano	8
986	540g Pizza MEXICANA tomat, vejce, šunka, feferonka pálivá, feferonka-kozí roh, kukuřice,mozzarella	540gpizzamexicanatomat,vejce,sunka,feferonkapaliva,feferonka-koziroh,kukurice,mozzarella	1a, 1b, 3, 7, 10	540g Pizza MEXICANA Tomato Purée, Egg, Ham, Hot Pepper, Maize, Edam Cheese	8
968	450g Pizza VIOLA tomat, šunka, kukuřice, kapie, mozzarella	450gpizzaviolatomat,sunka,kukurice,kapie,mozzarella	1a, 1b, 7, 10	450g Pizza VIOLA Tomato Purée, Ham, Maize, Sweet Capsicum, Edam Cheese	8
980	480g Pizza HAWAI tomat, šunka, ananas,mozzarella	480gpizzahawaitomat,sunka,ananas,mozzarella	1a, 1b, 7	480g Pizza HAWAI Tomato Purée, Ham, Pineapple, Edam Cheese	8
982	480g Pizza SPINACI tomat, špenát listový, kukuřice, mozzarella	480gpizzaspinacitomat,spenatlistovy,kukurice,mozzarella	1a, 1b, 7	480g Pizza SPINACI Tomato Purée, Minced Spinach, Leaf Spinach, Maize, Edam Cheese	8
1014	Filet ze štiky s bylinkovou nádivkou a omáčkou z hrubozrnné hořčice, zeleninové medové ragů	filetzestikysbylinkovounadivkouaomackouzhrubozrnnehorcice,zeleninovemedoveragu	1a, 4, 5, 6, 7, 9, 10, 11	\N	2
1019	Frankfurtská s párkem a bramborem	frankfurtskasparkemabramborem	1a, 7, 9	\N	9
1022	Hamburger s trhaným vepřovým masem, bramborové hranolky, pivní majonéza	hamburgerstrhanymveprovymmasem,bramborovehranolky,pivnimajoneza	1a, 3, 7, 9, 10, 12	\N	6
1024	Hamburger s trhaným vepřovým masem, smažené hranolky, zázvorová BBQ omáčka	hamburgerstrhanymveprovymmasem,smazenehranolky,zazvorovabbqomacka	1a, 3, 6, 9, 10, 11, 12	\N	6
1025	Hamburger s trhaným vepřovým masem, steakové hranolky, pivní majonéza	hamburgerstrhanymveprovymmasem,steakovehranolky,pivnimajoneza	1a, 3, 7, 9, 10	\N	6
1026	Hovězí vývar s bylinkovými noky	hovezivyvarsbylinkovyminoky	1a, 3, 7, 9	\N	9
1027	Hovězí vývar s masem a nudlemi	hovezivyvarsmasemanudlemi	1a, 3, 9	\N	9
1029	Hovězí vývar s trhaným masem a nudlemi	hovezivyvarstrhanymmasemanudlemi	1a, 3, 9	\N	9
1034	Kapustová polévka se smetanou a klobásou	kapustovapolevkasesmetanouaklobasou	1a, 7, 9	\N	9
1037	Kmínová s vejcem a bramborami	kminovasvejcemabramborami	1a, 3, 9, 10	\N	9
1040	Krémový chowder z květáku a brokolice	kremovychowderzkvetakuabrokolice	1a, 3, 7, 9, 10	\N	9
1041	Kroupová s uzeným masem a zeleninou	kroupovasuzenymmasemazeleninou	1c, 9	\N	9
1043	Kukuřičný chowder s kuřecím masem a krutony	kukuricnychowderskurecimmasemakrutony	1a, 7, 9, 10	\N	9
1048	Masová s bramborami	masovasbramborami	9	\N	9
1050	Mrkvový krém se zázvorem a kari	mrkvovykremsezazvoremakari	1a, 7, 9	\N	9
1020	Gulášová	gulasova	1a, 9, 10	Goulash	9
1064	Polévka z restované BIO zeleniny	polevkazrestovanebiozeleniny	1a, 3, 9	\N	9
978	480g Pizza BROKOLI tomat, brokolice, kukuřice,mozzarella	480gpizzabrokolitomat,brokolice,kukurice,mozzarella	1a, 1b, 7, 10	480g Pizza BROCCOLI Tomato Purée, Broccoli, Maize, Edam Cheese	8
1021	Gulášová z vepřového masa s bramborami	gulasovazveprovehomasasbramborami	1a, 9, 10	Goulash Soup with Pork and Potatoes	9
1023	Hamburger s trhaným vepřovým masem, bramborové hranolky, zázvorová BBQ omáčka	hamburgerstrhanymveprovymmasem,bramborovehranolky,zazvorovabbqomacka	1a, 3, 7, 9	Hamburger with Pulled Pork Meat, potato French Fries, ginger BBQ	6
1059	Pizza ANANASSO tomat, ananas, eidam, oregáno	pizzaananassotomat,ananas,eidam,oregano	1a, 1b, 7	Pizza ANANASSO Tomato Purée, Pineapple, Edam Cheese, Oregano	8
1045	Kuřecí vývar s masem a nudlemi	kurecivyvarsmasemanudlemi	1a, 3, 9	Chicken Broth with Meat and Noodles	9
1018	Frankfurtská s bramborami	frankfurtskasbramborami	1a, 7, 9	Cream Soup with Ground Paprika, Sausage, Potatoes	9
1049	Mrkvová se zázvorem	mrkvovasezazvorem	1a, 7, 9	Carrot Soup with Ginger	9
965	450g Pizza DIAVOLO tomat, anglická slanina, feferonka - kozí roh, cibule,mozzarella	450gpizzadiavolotomat,anglickaslanina,feferonka-koziroh,cibule,mozzarella	1a, 1b, 7, 10	450g Pizza DIAVOLO Tomato Purée, Bacon, Hot Pepper, Onion, Edam Cheese	8
1065	Pórková s bramborami a vejci	porkovasbramboramiavejci	1a, 3, 7, 9	Leek Soup with Potatoes and Eggs	9
1036	Kmínová s vejcem	kminovasvejcem	1a, 3, 9, 10	Caraway Soup with Egg	9
1047	Masová polévka se zeleninou	masovapolevkasezeleninou	9	Meat Soup with Vegetables	9
1039	Krémová z červené čočky	kremovazcervenecocky	1a, 1b, 7, 9	Creamy Red Lentils Soup	9
1044	Kulajda	kulajda	1a, 3, 7, 9, 10	Potatoes-and-Milk Soup	9
1042	Krupicová s vejci	krupicovasvejci	1a, 3, 9	Semolina and Egg Soup	9
1066	Pórková s vejcem	porkovasvejcem	1a, 3, 7, 9	Leek Soup with Eggs	9
1060	Pizza CAPRICIOSA tomat, šunka,anglická slanina, žampióny, kapie, č.olivy, mozzarella	pizzacapriciosatomat,sunka,anglickaslanina,zampiony,kapie,c.olivy,mozzarella	1a, 1b, 7	Pizza CAPRICIOSA Tomato Purée,Ham,Champignons,Sweet Capsicum,Black Olives,Mozzarella,Edam Cheese	8
1067	Rajská s restovanými paprikami	rajskasrestovanymipaprikami	1a, 7, 9	Tomato Soup with Fried Peppers	9
967	450g Pizza SÝROVÁ tomat, hermelín,mozzarella,niva, olivy	450gpizzasyrovatomat,hermelin,mozzarella,niva,olivy	1a, 1b, 7, 10	450g Pizza Cheese with Tomato Purée, Blue Cheese, Camembert, Edam Cheese and Olives	8
1061	Pizza LUCIA tomat, klobása, feferonky, niva,mozzarella	pizzaluciatomat,klobasa,feferonky,niva,mozzarella	1a, 1b, 7, 10	Pizza LUCIA Tomato Purée, Sausage Hot Pepper, Blue Cheese, Edam Cheese	8
1030	Hrachová	hrachova	1a, 9, 10	Pea Soup	9
1046	Květáková	kvetakova	1a, 7, 9	Cauliflower Soup	9
442	150g Variace řízků z vepřové panenky a kuřecího prsa, vařené brambory	150gvariacerizkuzveprovepanenkyakurecihoprsa,varenebrambory	1a, 3, 7, 9, 10	\N	2
1063	Pizza SPINACI S RICOTTOU, tomat, špenát listový, mozzarella, ricotta, sušená rajčata	pizzaspinacisricottou,tomat,spenatlistovy,mozzarella,ricotta,susenarajcata	1a, 1b, 7	Pizza with Tomato Purée, Leaf Spinach, Edam Cheese, Ricotta and Dried Tomatoes	8
1028	Hovězí vývar s nudlemi a zeleninou	hovezivyvarsnudlemiazeleninou	1a, 3, 9	Beef Broth with Noodles and Vegetables	9
1032	Hráškový krém s krutony	hraskovykremskrutony	1a, 7, 9	Pea Cream Soup with Croutons	9
1075	Slepičí s masem a nudlemi	slepicismasemanudlemi	1a, 3, 9	\N	9
1077	Slovenská kapustnica	slovenskakapustnica	1a, 7, 9, 10	\N	9
1078	Smažená mozzarella, bramborové hranolky, tatarská omáčka	smazenamozzarella,bramborovehranolky,tatarskaomacka	1a, 3, 7, 10	\N	6
1079	Smažená mozzarella, bramborové hranolky, zeleninová ozdoba	smazenamozzarella,bramborovehranolky,zeleninovaozdoba	1a, 3, 7	\N	6
1081	Špenátová krémová, krutony	spenatovakremova,krutony	1a, 7, 9	\N	9
1086	Staročeská bramboračka s houbami	staroceskabramborackashoubami	1a, 9	\N	9
1082	Špenátová krémová s česnekovými krutony	spenatovakremovascesnekovymikrutony	1a, 7, 9	Creamy Spinach Soup with Garlic Croutons	9
1196	Zapečená plněná cuketa s boloňským ragú a rajčaty, hovězím masem a sýrem, trhaný salát s cherry rajčaty a okurkami, bylinkový dip	zapecenaplnenacuketasbolonskymraguarajcaty,hovezimmasemasyrem,trhanysalatscherryrajcatyaokurkami,bylinkovydip	7, 9	\N	1
1198	Zapečený kuřecí steak se šunkou a sýrem, jasmínová rýže	zapecenykurecisteaksesunkouasyrem,jasminovaryze	1a, 7, 9, 10	\N	1
1201	Zelná s klobásou	zelnasklobasou	1a, 9, 10	\N	9
1193	Valašská kyselice	valasskakyselice	1a, 7, 9, 10	Sauerkraut Soup 	9
249	120g Vepřové výpečky, cibulové zelí, bramborové noky	120gveprovevypecky,cibulovezeli,bramborovenoky	1a, 3, 9, 10	120g Pork with Cabbage, Onion, Garlic, Lard, grated Onions, potato Gnocchi	2
725	300g Špagety po uhlířsku se slaninou, smetanou a sýrem gran biraghi	300gspagetypouhlirskuseslaninou,smetanouasyremgranbiraghi	1a, 3, 7	300g Spaghetti with Eggs, Cheese, Bacon, Cream and Gran Biraghi Cheese	1
174	120g Pečený losos teriyaki se sezamem a medem, stir-fry zelenina pečené vaječné kari  nudle	120gpecenylososteriyakisesezamemamedem,stir-fryzeleninapecenevajecnekarinudle	1a, 3, 4, 5, 6, 7, 9, 10, 11	120g Roasted Teiyaki Salmon with Sesame and Honey Sauce, vegetable Stir-Fry and Egg Noodles	2
94	120g Hamburger z trhaného vepřového masa, bramborové hranolky, zázvorová BBQ omáčka	120ghamburgerztrhanehoveprovehomasa,bramborovehranolky,zazvorovabbqomacka	1a, 1b, 3, 6, 7, 9, 10, 12, 13	120g Hamburger with Pulled Pork Meat, potato French Fries, ginger BBQ	6
966	450g Pizza SALAMI tomat, salám, feferonky- kozí rohy,mozzarella, oregáno	450gpizzasalamitomat,salam,feferonky-kozirohy,mozzarella,oregano	1a, 1b, 7, 10	450g Pizza SALAMI Tomato Purée, Sausage, Hot Pepper - Goat Horn, Edam Cheese, Oregano	8
1194	Vegetariánská ciabatta s cuketou, pečenými paprikami a tofu, bramborové hranolky, dip z kysané smetany	vegetarianskaciabattascuketou,pecenymipaprikamiatofu,bramborovehranolky,dipzkysanesmetany	1a, 7, 9	Vegetarian Ciabatta with Zucchini, Roasted Peppers and Tofu (Bean Curd), potato French Fries, sour Cream Dip	6
90	120g Hamburger s trhaným vepřovým masem, smažené hranolky, zázvorová BBQ omáčka	120ghamburgerstrhanymveprovymmasem,smazenehranolky,zazvorovabbqomacka	1a, 3, 6, 7, 9, 10, 11, 12, 13	120g Hamburger with Pulled Pork Meat, french Fries (Fried Potato Chips), ginger BBQ	6
1192	Uzená s kroupami	uzenaskroupami	1c, 9	Smoked Meat and Barley Soup	9
1076	Slepičí vývar s masem a nudlemi	slepicivyvarsmasemanudlemi	1a, 3, 9	Chicken Broth with Meat and Noodles	9
1587	250g Zeleninový salát se sušenými rajčaty, bazalkou a mozzarella kuličkami, opečený toast	250gzeleninovysalatsesusenymirajcaty,bazalkouamozzarellakulickami,opecenytoast	1a, 7, 10	250g Vegetable Salad with Dried Tomatoes and Mozzarella, Chicken Pieces , toast	2
443	150g Vepřová kotleta se šunkou a sázeným vejcem, bramborové hranolky	150gveprovakotletasesunkouasazenymvejcem,bramborovehranolky	3, 9	150g Pork Cutlet with Ham and Fried Egg, potato French Fries	6
1200	Zeleninová s krupicovými noky	zeleninovaskrupicovyminoky	1a, 3, 7, 9	Vegetable Soup with Semolina Dumplings	9
1805	Sterilovaná polévka ve skle 0,7l - Brokolicová,Fazolová,Dýňová,Kyselice,Kuřecí vývar,Z restovaných paprik,Sugo di Pomodoro,Pepřová omáčka	sterilovanapolevkaveskle0,7l-brokolicova,fazolova,dynova,kyselice,kurecivyvar,zrestovanychpaprik,sugodipomodoro,peprovaomacka		Sterilovaná polévka ve skle 0,7l - Brokolicová,Fazolová,Dýňová,Kyselice,Kuřecí vývar,Z restovaných paprik,Sugo di Pomodoro,Pepřová omáčka	5
1806	3 Sterilovaná hotovka ve skle  -Krůtí medailonky,Hovězí po burgundsku,Vepřové medailonky s koňakovou omáčkou,Hovězí pečeně s rajskou omáčkou,Chow-mein z vepřové panenky	3sterilovanahotovkaveskle-krutimedailonky,hovezipoburgundsku,veprovemedailonkyskonakovouomackou,hovezipecenesrajskouomackou,chow-meinzveprovepanenky		3 Sterilovaná hotovka ve skle  -Krůtí medailonky,Hovězí po burgundsku,Vepřové medailonky s koňakovou omáčkou,Hovězí pečeně s rajskou omáčkou,Chow-mein z vepřové panenky	5
484	200g Dušený špenát, 2 vejce, vařené brambory	200gdusenyspenat,2vejce,varenebrambory	1a, 3, 7, 9, 10	\N	1
486	200g Kuřecí křídla grilovaná, bramborové hranolky, zeleninový salát	200gkurecikridlagrilovana,bramborovehranolky,zeleninovysalat	1a, 9, 10	\N	6
1588	3 Sterilovaná hotovka ve skle  - Znojemské hovězí nudličky,Medailonky z vepřové panenky,Hovězí guláš,Krůtí ragů,Hovězí po burgundsku	3sterilovanahotovkaveskle-znojemskehovezinudlicky,medailonkyzveprovepanenky,hovezigulas,krutiragu,hovezipoburgundsku		3 Sterilovaná hotovka ve skle  - Znojemské hovězí nudličky,Medailonky z vepřové panenky,Hovězí guláš,Krůtí ragů,Hovězí po burgundsku	5
1589	300g Špagety s boloňským ragů, sypané sýrem gran biraghi	300gspagetysbolonskymragu,sypanesyremgranbiraghi	1a, 3, 6, 7, 9, 10, 11	300g Spaghetti with Ragout Bolognese, Sprinkled with Gran Biraghi Cheese	1
1804	3 Sterilovaná hotovka ve skle 0,7l - Krůtí medailonky s pŕ.a rajčaty, Medail. z vep. panenky s koňak.om., Chow-mein z vepř.panenky, Hov.maso, rajská omáčka, Hovězí po burgunsku	3sterilovanahotovkaveskle0,7l-krutimedailonkyspr.arajcaty,medail.zvep.panenkyskonak.om.,chow-meinzvepr.panenky,hov.maso,rajskaomacka,hovezipoburgunsku		3 Sterilovaná hotovka ve skle 0,7l - Krůtí medailonky s pŕ.a rajčaty, Medail. z vep. panenky s koňak.om., Chow-mein z vepř.panenky, Hov.maso, rajská omáčka, Hovězí po burgunsku	5
1807	120g Kuřecí plátek s anglickou slaninou, basmati rýže	120gkureciplateksanglickouslaninou,basmatiryze	1a, 9, 10	120g Chicken Slice with Bacon, basmati Rice	1
517	240g Pečené kuřecí stehno s provensálským kořením, dušená rýže	240gpecenekurecistehnosprovensalskymkorenim,dusenaryze	1a, 1b, 9, 10	\N	2
1590	120g Kuřecí madras kari se zázvorem, čili a paprikou, jasmínová rýže	120gkurecimadraskarisezazvorem,ciliapaprikou,jasminovaryze	1a, 7, 9	120g Chicken Madras Curry with Ginger, Chilli and Sweet Peppers, jasmine Rice	1
1591	3 Sterilovaná hotovka ve skle 0,7l - Hovězí guláš, Medailonky z v. panenky s ang.slan.a rozmarýnem	3sterilovanahotovkaveskle0,7l-hovezigulas,medailonkyzv.panenkysang.slan.arozmarynem		3 Sterilovaná hotovka ve skle 0,7l - Hovězí guláš, Medailonky z v. panenky s ang.slan.a rozmarýnem	5
1808	300g Bramborové šulánky s mákem, cukrem a přepuštěným máslem	300gbramborovesulankysmakem,cukremaprepustenymmaslem	1a, 3, 7	300g Potato Gnocchi Filled with Poppy Seeds, Sugar and Melted Butter	2
1592	Hovězí s těstovinovou rýží	hovezistestovinovouryzi	1a, 3, 9	Beef Soup with Italian Rice (Pasta)	9
1593	120g Řízek z vepřové kotlety, vařené brambory s máslem	120grizekzveprovekotlety,varenebramborysmaslem	1a, 3, 7, 9, 10	120g Pork Cutlet Schnitzel , boiled Potatoes with Butter	2
1594	120g Kuřecí roláda se špenátem a anglickou slaninou, jus-lie s cibulkami, jasmínová rýže	120gkureciroladasespenatemaanglickouslaninou,jus-liescibulkami,jasminovaryze	1, 3, 6, 7, 9, 10, 12	120g Chicken Roulade with Spinach and Bacon, jus-lie s cibulkami, jasmínová rýže	2
1595	250g Tvarohové knedlíky s nugátovou náplní, ořechová posýpka, vanilkové máslo	250gtvarohoveknedlikysnugatovounaplni,orechovaposypka,vanilkovemaslo	1a, 3, 7, 8, 8b, 8c	250g Quark Dumplings Filled with Nougat, ořechová posýpka, vanilla Butter	2
1596	Kuřecí roláda se špenátem a anglickou slaninou, jus-lie s cibulkami, jasmínová rýže	kureciroladasespenatemaanglickouslaninou,jus-liescibulkami,jasminovaryze	1, 3, 6, 7, 9, 10, 12	Chicken Roulade with Spinach and Bacon, lightly Thickened Jus with Onions, jasmine Rice	2
1597	350g Tvarohové knedlíky s nugátovou náplní, ořechová posýpka, vanilkové máslo	350gtvarohoveknedlikysnugatovounaplni,orechovaposypka,vanilkovemaslo	1a, 3, 7, 8, 8b, 8c	350g Quark Dumplings Filled with Nougat, nut Crumble Topping, vanilla Butter	2
1598	120g Grilované kuřecí kousky, omáčka z modrého sýra, opékané brambory	120ggrilovanekurecikousky,omackazmodrehosyra,opekanebrambory	1, 3, 5, 10, 11	120g Grilled Chicken Pieces, blue Cheese Sauce, roast Potatoes	6
1599	Masový vývar s bramborem a zeleninou	masovyvyvarsbramboremazeleninou	1a, 3, 9	Meat Soup with Potatoes and Vegetables	9
1600	120g Smetanová křenová omáčka s uzeným masem, houskový knedlík	120gsmetanovakrenovaomackasuzenymmasem,houskovyknedlik	1a, 3, 7, 9	120g Cream Horseradish Sauce with Smoked Meat, bread Dumplings	2
1601	150g Zapečená vepřová kotleta s anglickou slaninou a nivou, americké brambory	150gzapecenaveprovakotletasanglickouslaninouanivou,americkebrambory	1a, 7, 9	150g Zapečená vepřová kotleta s anglickou slaninou a nivou, potato Wedges	2
1602	300g Banánové palačinky plněné tvarohem, přelité čokoládou, ovoce	300gbananovepalacinkyplnenetvarohem,prelitecokoladou,ovoce	1a, 3, 6, 7	300g Banana Pancakes with Quark, with Melted Chocolate Topping, Fruit	2
1809	120g Sous - vide kuřecí roláda se slaninou a špenátem, jasmínová rýže, tymiánový jus	120gsous-videkureciroladaseslaninouaspenatem,jasminovaryze,tymianovyjus	1, 3, 6, 7, 9, 12	120g Sous-Vide Chicken Roulade Stuffed with Bacon and Spinach , jasmine Rice, thyme Jus	2
1810	120g Sous - vide kuřecí roláda se slaninou a špenátem, jasmínová rýže	120gsous-videkureciroladaseslaninouaspenatem,jasminovaryze	1, 3, 6, 7, 9, 12	120g Sous-Vide Chicken Roulade Stuffed with Bacon and Spinach , jasmine Rice	2
1811	150g Filetovaná vepřová panenka, hořčicová omáčka, smažené hranolky	150gfiletovanaveprovapanenka,horcicovaomacka,smazenehranolky	1a, 7, 10	150g Sliced Pork Loin, mustard Sauce, french Fries (Fried Potato Chips)	2
1812	300g Zeleninový salát s vejcem a kuřecími kousky, opečený toast	300gzeleninovysalatsvejcemakurecimikousky,opecenytoast	1a, 3, 10	300g Zeleninový salát s vejcem a kuřecími kousky, toast	2
555	2 Sterilovaná hotovka ve skle  - Boloňská směs, Kuřecí kari madras, Vepřový vrabec se zelím	2sterilovanahotovkaveskle-bolonskasmes,kurecikarimadras,veprovyvrabecsezelim		\N	5
556	2 Sterilovaná hotovka ve skle  - Boloňská směs,Kuřecí kousky tikka masala	2sterilovanahotovkaveskle-bolonskasmes,kurecikouskytikkamasala		\N	5
557	2 Sterilovaná hotovka ve skle  -Boloňská směs,Kuřecí na paprice,Vepřový vrabec	2sterilovanahotovkaveskle-bolonskasmes,kurecinapaprice,veprovyvrabec		\N	5
564	2 Sterilovaná hotovka ve skle  -Kuřecí kari	2sterilovanahotovkaveskle-kurecikari		\N	5
1603	Sterilovaná polévka ve skle  0,7l - Gulášová,Z restovaných paprik,Boršč,Cibulačka,Brokolicový chowder,Kuřecí,Rajská,Hovězí,Telecí vývar,Jemná pepřová omáčka	sterilovanapolevkaveskle0,7l-gulasova,zrestovanychpaprik,borsc,cibulacka,brokolicovychowder,kureci,rajska,hovezi,telecivyvar,jemnapeprovaomacka		Sterilovaná polévka ve skle  0,7l - Gulášová,Z restovaných paprik,Boršč,Cibulačka,Brokolicový chowder,Kuřecí,Rajská,Hovězí,Telecí vývar,Jemná pepřová omáčka	5
1604	2 Sterilovaná hotovka ve skle  - Kuřecí kousky,Kuřecí kari,Kuličky s mletého masa s rajskou om.,Steak z vepřové krkovice s pepřovou om.	2sterilovanahotovkaveskle-kurecikousky,kurecikari,kulickysmletehomasasrajskouom.,steakzveprovekrkovicespeprovouom.		2 Sterilovaná hotovka ve skle  - Kuřecí kousky,Kuřecí kari,Kuličky s mletého masa s rajskou om.,Steak z vepřové krkovice s pepřovou om.	5
46	120g Chow - mein z vepřové panenky s brokolicí, mrkví, žampiony  a sezamem, dušená rýže	120gchow-meinzveprovepanenkysbrokolici,mrkvi,zampionyasezamem,dusenaryze	1a, 1b, 3, 5, 6, 7, 9, 10, 11	120g Pork Undercut Chow Mein with Broccoli, Carrot  and Sesame, stewed Rice	1
1605	240g Nadívané kuřecí stehno s jarní nádivkou, přírodní šťáva, dušená rýže	240gnadivanekurecistehnosjarninadivkou,prirodnistava,dusenaryze	1a, 1b, 3, 5, 7, 9, 10, 11	240g Stuffed Chicken Leg with Spring Stuffing, natural Jus, stewed Rice	2
1606	2 Sterilovaná hotovka ve skle 0,7l - Masové kuličky rajská om., V.krkovice s pepř.om., Boloňská vepř. směs, Kuřecí kari	2sterilovanahotovkaveskle0,7l-masovekulickyrajskaom.,v.krkovicespepr.om.,bolonskavepr.smes,kurecikari		2 Sterilovaná hotovka ve skle 0,7l - Masové kuličky rajská om., V.krkovice s pepř.om., Boloňská vepř. směs, Kuřecí kari	5
1607	3 Sterilovaná hotovka ve skle 0,7l - Krůtí ragu se smet.a zelen., Hovězí po burgunsku, Medailonky z v. panenky s ang.slan.a rozmarýnem	3sterilovanahotovkaveskle0,7l-krutiragusesmet.azelen.,hovezipoburgunsku,medailonkyzv.panenkysang.slan.arozmarynem		3 Sterilovaná hotovka ve skle 0,7l - Krůtí ragu se smet.a zelen., Hovězí po burgunsku, Medailonky z v. panenky s ang.slan.a rozmarýnem	5
1813	2 Sterilovaná hotovka ve skle  - Boloňská směs, Krkovice se steakovou omáčkou	2sterilovanahotovkaveskle-bolonskasmes,krkovicesesteakovouomackou		2 Sterilovaná hotovka ve skle  - Boloňská směs, Krkovice se steakovou omáčkou	5
596	2 Sterilovaná hotovka ve skle  -Vepřový vrabec,	2sterilovanahotovkaveskle-veprovyvrabec,		\N	5
1608	Sterilovaná polévka ve skle  0,7l - Gulášová,Z restovaných paprik,Cibulačka,Brokolicový chowder,Kuřecí,Rajská,Hovězí,Telecí vývar,Jemná pepřová omáčka	sterilovanapolevkaveskle0,7l-gulasova,zrestovanychpaprik,cibulacka,brokolicovychowder,kureci,rajska,hovezi,telecivyvar,jemnapeprovaomacka		Sterilovaná polévka ve skle  0,7l - Gulášová,Z restovaných paprik,Cibulačka,Brokolicový chowder,Kuřecí,Rajská,Hovězí,Telecí vývar,Jemná pepřová omáčka	5
1609	1 Sterilovaná hotovka ve skle  - Bramborové kari Aloo-Bhaji,BIO Hovězí vývar	1sterilovanahotovkaveskle-bramborovekarialoo-bhaji,biohovezivyvar		1 Sterilovaná hotovka ve skle  - Bramborové kari Aloo-Bhaji,BIO Hovězí vývar	5
1814	Sterilovaná polévka ve skle  0,7l - Z restovaných paprik,Gulášová,Brokolicový chowder,Kuřecí,Dýňová,Kulajda,Valašská kyselice,Kuřecí vývar,Jemná pepřová omáčka,Sugo di Pomodora	sterilovanapolevkaveskle0,7l-zrestovanychpaprik,gulasova,brokolicovychowder,kureci,dynova,kulajda,valasskakyselice,kurecivyvar,jemnapeprovaomacka,sugodipomodora		Sterilovaná polévka ve skle  0,7l - Z restovaných paprik,Gulášová,Brokolicový chowder,Kuřecí,Dýňová,Kulajda,Valašská kyselice,Kuřecí vývar,Jemná pepřová omáčka,Sugo di Pomodora	5
1815	2 Sterilovaná hotovka ve skle  - Boloňská směs,Mozaiková sekaná,Frankfurtská pečeně,Uzená pečeně se smetanovou křenovou om.	2sterilovanahotovkaveskle-bolonskasmes,mozaikovasekana,frankfurtskapecene,uzenapecenesesmetanovoukrenovouom.		2 Sterilovaná hotovka ve skle  - Boloňská směs,Mozaiková sekaná,Frankfurtská pečeně,Uzená pečeně se smetanovou křenovou om.	5
621	2 Sterilovaná hotovka ve skle 0,7l -Masové kuličky,rajská omáčka, Vrabec, zelí, Boloňská vepř. směs	2sterilovanahotovkaveskle0,7l-masovekulicky,rajskaomacka,vrabec,zeli,bolonskavepr.smes		\N	5
655	300g Čočkové ragú s karotkou, cizrnou, dýní a fazolemi, rýžový pilaf, bez lepku	300gcockoveraguskarotkou,cizrnou,dyniafazolemi,ryzovypilaf,bezlepku	3, 6, 7, 9, 10	\N	2
1610	3 Sterilovaná hotovka ve skle  - Medailonky z vepřové panenky,Hovězí guláš,Krůtí ragů,Hovězí po burgundsku	3sterilovanahotovkaveskle-medailonkyzveprovepanenky,hovezigulas,krutiragu,hovezipoburgundsku		3 Sterilovaná hotovka ve skle  - Medailonky z vepřové panenky,Hovězí guláš,Krůtí ragů,Hovězí po burgundsku	5
1816	Sterilovaná polévka ve skle 0,7l - Valašská kyselice s uz.masem, Kuřecí vývar s trh.masem, Kulajda, Fazolová s uz.masem, Dýňová se smet., Cibulačka, Steaková om., Pepřová om., Sugo di pomodoro	sterilovanapolevkaveskle0,7l-valasskakyselicesuz.masem,kurecivyvarstrh.masem,kulajda,fazolovasuz.masem,dynovasesmet.,cibulacka,steakovaom.,peprovaom.,sugodipomodoro		Sterilovaná polévka ve skle 0,7l - Valašská kyselice s uz.masem, Kuřecí vývar s trh.masem, Kulajda, Fazolová s uz.masem, Dýňová se smet., Cibulačka, Steaková om., Pepřová om., Sugo di pomodoro	5
1817	3 Sterilovaná hotovka ve skle 0,7l - Vepř.medail. s koňak.om., Chow-mein z vepř.panenky, Krůtí ragu se smet.a zelen., Hovězí po burgunsku	3sterilovanahotovkaveskle0,7l-vepr.medail.skonak.om.,chow-meinzvepr.panenky,krutiragusesmet.azelen.,hovezipoburgunsku		3 Sterilovaná hotovka ve skle 0,7l - Vepř.medail. s koňak.om., Chow-mein z vepř.panenky, Krůtí ragu se smet.a zelen., Hovězí po burgunsku	5
690	300g Palačinky s jahodovou marmeládou, zakysanou smetanou a čerstvým ovocem	300gpalacinkysjahodovoumarmeladou,zakysanousmetanouacerstvymovocem	1a, 3, 7	\N	2
1611	Sterilovaná polévka ve skle  0,7l - Gulášová,Z restovaných paprik,Cibulačka,Brokolicový chowder,Kuřecí,Rajská,Hovězí vývar,Jemná pepřová omáčka	sterilovanapolevkaveskle0,7l-gulasova,zrestovanychpaprik,cibulacka,brokolicovychowder,kureci,rajska,hovezivyvar,jemnapeprovaomacka		Sterilovaná polévka ve skle  0,7l - Gulášová,Z restovaných paprik,Cibulačka,Brokolicový chowder,Kuřecí,Rajská,Hovězí vývar,Jemná pepřová omáčka	5
1612	3 Sterilovaná hotovka ve skle  - Hovězí guláš,Krůtí ragů,Hovězí po burgundsku	3sterilovanahotovkaveskle-hovezigulas,krutiragu,hovezipoburgundsku		3 Sterilovaná hotovka ve skle  - Hovězí guláš,Krůtí ragů,Hovězí po burgundsku	5
1818	Sterilovaná polévka ve skle  0,7l - Gulášová, Dýňová	sterilovanapolevkaveskle0,7l-gulasova,dynova		Sterilovaná polévka ve skle  0,7l - Gulášová, Dýňová	5
1819	2 Sterilovaná hotovka ve skle  - Boloňská směs, Vepř.krkovice s pepřovou om., Segedínský guláš	2sterilovanahotovkaveskle-bolonskasmes,vepr.krkovicespeprovouom.,segedinskygulas		2 Sterilovaná hotovka ve skle  - Boloňská směs, Vepř.krkovice s pepřovou om., Segedínský guláš	5
1820	3 Sterilovaná hotovka ve skle  - Hov. po burgundsku, Kuřecí s liškovou om., Chow-main z vepř.panenky, Rajská om.s hovězím masem, Chilli con carne	3sterilovanahotovkaveskle-hov.poburgundsku,kurecisliskovouom.,chow-mainzvepr.panenky,rajskaom.shovezimmasem,chilliconcarne		3 Sterilovaná hotovka ve skle  - Hov. po burgundsku, Kuřecí s liškovou om., Chow-main z vepř.panenky, Rajská om.s hovězím masem, Chilli con carne	5
723	300g Špagety po Asijsku s vepřovým mletým masem, chilli a mrkví sypané jarní cibulkou a sezamem	300gspagetypoasijskusveprovymmletymmasem,chilliamrkvisypanejarnicibulkouasezamem	1a, 3, 6, 7, 9, 11	\N	2
1613	Sterilovaná polévka ve skle  0,7l - Gulášová,Z restovaných paprik,Cibulačka,Brokolicový chowder,Kuřecí,Hovězí vývar,Jemná pepřová omáčka	sterilovanapolevkaveskle0,7l-gulasova,zrestovanychpaprik,cibulacka,brokolicovychowder,kureci,hovezivyvar,jemnapeprovaomacka		Sterilovaná polévka ve skle  0,7l - Gulášová,Z restovaných paprik,Cibulačka,Brokolicový chowder,Kuřecí,Hovězí vývar,Jemná pepřová omáčka	5
786	300g Zeleninové stew s máslovou dýní, cuketou a červenou paprikou, bylinkové gnocchi	300gzeleninovestewsmaslovoudyni,cuketouacervenoupaprikou,bylinkovegnocchi	1a, 9, 10, 12	300g Vegetable Stew with Butter Pumpkin, Zucchini and Red Peppers, herbal Gnocchi	2
633	300g Bramborové šulánky plněné mákem, karamelizované vlašské ořechy, přepuštěné máslo	300gbramborovesulankyplnenemakem,karamelizovanevlasskeorechy,prepustenemaslo	1a, 7, 8, 8c	300g Potato Gnocchi Filled with Poppy Seeds, Caramelized Walnuts, Melted Butter	2
1821	130g Plněná tortilla kuřecím masem, bramborové hranolky, dip z kysané smetany	130gplnenatortillakurecimmasem,bramborovehranolky,dipzkysanesmetany	1a, 7, 9	130g Tortilla Stuffed with Chicken Meat, potato French Fries, sour Cream Dip	6
1822	Boršč	borsc	1a, 7, 9	Borscht 	9
1823	150g Kuřecí směs se žampiony a smetanou, dušená rýže	150gkurecismessezampionyasmetanou,dusenaryze	7, 9	150g Kuřecí směs se žampiony a smetanou, stewed Rice	2
1824	150g Pečená vepřová krkovice s fazolovým luskem, opékané brambory	150gpecenaveprovakrkovicesfazolovymluskem,opekanebrambory	1, 3, 5, 7, 9, 10, 11	150g Pečená vepřová krkovice s fazolovým luskem, roasted Potatoes	2
1825	300g Řepový zeleninový salát s pečenýmí grenaillemi sypané feta sýrem	300grepovyzeleninovysalatspecenymigrenaillemisypanefetasyrem	7	300g Beetroot Vegetable Salad with Roasted Grenaille Potatoes Sprinkled with Feta Cheese	2
761	300g Tvarohové knedlíky ovocné, staročeskou posýpkou a přepuštěným máslem	300gtvarohoveknedlikyovocne,staroceskouposypkouaprepustenymmaslem	1a, 3, 7	\N	2
1614	Raženka s vejcem, Rohlík se šunkou, Rohlík zlínský s v.šunkou, s eidamem, Chlebíček dobrozrnný s řepou,mrkvovocelerovou	razenkasvejcem,rohliksesunkou,rohlikzlinskysv.sunkou,seidamem,chlebicekdobrozrnnysrepou,mrkvovocelerovou		Raženka s vejcem, Rohlík se šunkou, Rohlík zlínský s v.šunkou, s eidamem, Chlebíček dobrozrnný s řepou,mrkvovocelerovou	11
1826	Sterilovaná polévka ve skle  0,7l - Z restovaných paprik,Gulášová,Brokolicový chowder,Kuřecí,Dýňová,Kulajda,Valašská kyselice,Kuřecí vývar,Steaková omáčka se smetanou a koňakem,Sugo di Pomodora	sterilovanapolevkaveskle0,7l-zrestovanychpaprik,gulasova,brokolicovychowder,kureci,dynova,kulajda,valasskakyselice,kurecivyvar,steakovaomackasesmetanouakonakem,sugodipomodora		Sterilovaná polévka ve skle  0,7l - Z restovaných paprik,Gulášová,Brokolicový chowder,Kuřecí,Dýňová,Kulajda,Valašská kyselice,Kuřecí vývar,Steaková omáčka se smetanou a koňakem,Sugo di Pomodora	5
1827	Sterilovaná polévka ve skle 0,7l - Hovězí vývar	sterilovanapolevkaveskle0,7l-hovezivyvar		Sterilovaná polévka ve skle 0,7l - Hovězí vývar	5
793	300g Zeleninový salát s červenou řepou, grenaille bramborami a cuketou sypané sýrem Feta, křupavá bagetka	300gzeleninovysalatscervenourepou,grenaillebramboramiacuketousypanesyremfeta,krupavabagetka	1a, 7	\N	2
1615	300g Zeleninový cassoulet s fazolemi, pečenými cherry rajčaty, červenou řepou a karotkou, rýžový pilaf	300gzeleninovycassouletsfazolemi,pecenymicherryrajcaty,cervenourepouakarotkou,ryzovypilaf	1, 9, 10	300g Vegetable Cassoulet with Beans, Roasted Cherry Tomatoes, Beetroot and Carrots, rice Pilaf	2
1616	150g Přírodní rybí filé na kmíně, máslová omáčka, pečené grenaile	150gprirodnirybifilenakmine,maslovaomacka,pecenegrenaile	1, 4, 5, 6, 7, 9, 10, 11, 12	150g Fish Fillet au Naturel with Caraway, butter Sauce, roasted Grenaille Potatoes	2
1617	300g Proteinová kuřecí quinoa s pečenou zeleninou, trhaný salát, jogurtový dip	300gproteinovakureciquinoaspecenouzeleninou,trhanysalat,jogurtovydip	7, 9	300g Protein-rich Chicken Quinoa with Roasted Vegetables, shredded Lettuce, yogurt Dip	2
1618	120g Grilovaná vepřová panenka, steakové hranolky, bylinkový dip	120ggrilovanaveprovapanenka,steakovehranolky,bylinkovydip	1a, 1b, 3, 5, 7, 9, 10, 11	120g Grilled Pork Undercut, french Fries in Steak Seasoning, herb Dip	6
1619	150g Kuřecí kapsa plněná sušenými rajčaty a mozzarelou, smažené hranolky, bazalková omáčka	150gkurecikapsaplnenasusenymirajcatyamozzarelou,smazenehranolky,bazalkovaomacka	1a, 7, 9	150g Chicken Roll Stuffed with Dried Tomatoes and Mozzarella, french Fries (Fried Potato Chips), basil Salsa	2
1620	150g Smažený řízek z vepřové panenky, šťouchané brambory, okurkový salát	150gsmazenyrizekzveprovepanenky,stouchanebrambory,okurkovysalat	1a, 3, 7, 9	150g Fried Pork Tenderloin Schnitzel, mashed Potatoes, cucumber Salad	2
1621	300g Tagliatelle s cuketou, paprikou, baby špenátem a smetanou sypané sýrem	300gtagliatellescuketou,paprikou,babyspenatemasmetanousypanesyrem	1a, 3, 7, 9	300g Tagliatelle s cuketou, paprikou, baby špenátem a smetanou sypané sýrem	2
1828	2 Sterilovaná hotovka ve skle  - Boloňská směs, Uzená pečeně s křenovou om., Vepř.krkovice s pepřovou om., Segedínský guláš	2sterilovanahotovkaveskle-bolonskasmes,uzenapeceneskrenovouom.,vepr.krkovicespeprovouom.,segedinskygulas		2 Sterilovaná hotovka ve skle  - Boloňská směs, Uzená pečeně s křenovou om., Vepř.krkovice s pepřovou om., Segedínský guláš	5
1622	250g Čerstvé těstoviny - fusilli con verdure se zeleninou, oregánem a sýrem	250gcerstvetestoviny-fusilliconverduresezeleninou,oreganemasyrem	1a, 1b, 7	250g Čerstvé těstoviny - fusilli con verdure se zeleninou, oregánem a sýrem	6
1623	2 Sterilovaná hotovka ve skle 0,7l - Masové kuličky rajská om., Vepř.krkovice s pepř.om., Boloňská vepř. směs, Kuřecí kari	2sterilovanahotovkaveskle0,7l-masovekulickyrajskaom.,vepr.krkovicespepr.om.,bolonskavepr.smes,kurecikari		2 Sterilovaná hotovka ve skle 0,7l - Masové kuličky rajská om., Vepř.krkovice s pepř.om., Boloňská vepř. směs, Kuřecí kari	5
1624	3 Sterilovaná hotovka ve skle 0,7l - Krůtí ragu se smet.a zelen., Hovězí po burgunsku	3sterilovanahotovkaveskle0,7l-krutiragusesmet.azelen.,hovezipoburgunsku		3 Sterilovaná hotovka ve skle 0,7l - Krůtí ragu se smet.a zelen., Hovězí po burgunsku	5
828	350g Pomalu pečené kuřecí paličky marinované se sojovou omáčkou a medem, jasmínová rýže	350gpomalupecenekurecipalickymarinovanesesojovouomackouamedem,jasminovaryze	1, 3, 5, 6, 7, 9, 10, 11	350g Slow-Roasted Chicken Drumsticks, Marinated in Soya Sauce and Honey, jasmine Rice	2
1829	260g Pečené kuřecí stehno, jasmínová rýže	260gpecenekurecistehno,jasminovaryze	1a, 9, 10	260g Roasted Chicken Leg, jasmine Rice	1
1625	150g Kuřecí steak, americké brambory, bylinkový dip	150gkurecisteak,americkebrambory,bylinkovydip	1a, 1b, 7, 9	150g Chicken Steak, potato Wedges, herb Dip	6
1626	120g Smažený karbanátek, bramborová kaše, sterilovaný okurek	120gsmazenykarbanatek,bramborovakase,sterilovanyokurek	1a, 3, 7, 9, 10	120g Fried Burger, mashed Potatoes, gherkin	2
1627	120g Pekingské hovězí nudličky se zeleninou, zázvorem a sojovou omáčkou, pečené kari nudle	120gpekingskehovezinudlickysezeleninou,zazvoremasojovouomackou,pecenekarinudle	1a, 3, 6, 7, 9, 10	120g Beijing Beef Noodles with Vegetables, Ginger and Soya Meat Sauce, baked Curry Noodles	2
1628	300g Italské sýrové tortelliny s rajčaty, jarní cibulkou, špenátem a bylinkovým pestem	300gitalskesyrovetortellinysrajcaty,jarnicibulkou,spenatemabylinkovympestem	1a, 3, 7, 9	300g Italian Cheese Tortellini with Tomatoes, Spring Onion, Spinach and Herb Pesto	2
1629	130g Filet z tresky s restovanou zeleninou, bylinková omáčka, opékané brambory	130gfiletztreskysrestovanouzeleninou,bylinkovaomacka,opekanebrambory	1a, 4, 5, 6, 7, 9, 10, 11	130g Codfish Fillet with Roasted Vegetables, herb Sauce, roast Potatoes	2
1630	300g Míchané tofu se zeleninou a peperonátou, čočkový pilaf, bez lepku	300gmichanetofusezeleninouapeperonatou,cockovypilaf,bezlepku	6, 7, 9	300g Scrambled Tofu with Vegetables and a Peperonata Sauce, lentil Pilaf, gluten Free	2
1631	350g Poke Bowl - DUCK and YUZU se sushi rýží, RAW zeleninou a teriyaki omáčkou	350gpokebowl-duckandyuzusesushiryzi,rawzeleninouateriyakiomackou	1a, 1b, 3, 6, 7, 9, 11	350g Poke Bowl - DUCK and YUZU se sushi rýží, RAW zeleninou a teriyaki omáčkou	6
1632	150g Kuřecí kapsa plněná šunkou a nivou, bramborové hranolky, tatarská omáčka	150gkurecikapsaplnenasunkouanivou,bramborovehranolky,tatarskaomacka	1, 7, 9, 10	150g Chicken Roll Stuffed with Ham and Blue Cheese, potato French Fries, Tartar Sauce	6
1633	300g Těstovinový salát s kuřecím gyrosem, dip z kysané smetany	300gtestovinovysalatskurecimgyrosem,dipzkysanesmetany	1a, 3, 7, 9	300g Pasta Salad with Chicken Gyros and Vegetables, sour Cream Dip	6
1634	Sterilovaná polévka ve skle 0,7l - Z restovaných paprik, Kuřecí krémová, Brokolicový krém, Cibulačka, Boršč	sterilovanapolevkaveskle0,7l-zrestovanychpaprik,kurecikremova,brokolicovykrem,cibulacka,borsc		Sterilovaná polévka ve skle 0,7l - Z restovaných paprik, Kuřecí krémová, Brokolicový krém, Cibulačka, Boršč	5
1635	300g Poke Bowl - DUCK and YUZU se sushi rýží, RAW zeleninou a teriyaki omáčkou	300gpokebowl-duckandyuzusesushiryzi,rawzeleninouateriyakiomackou	1a, 1b, 3, 6, 7, 9, 11	300g Duck & Yuzu Poke Bowl with Sushi Rice, Raw Vegetables and Teriyaki Sauce	6
1636	250g Tortilla plněná trhanou vepřovou krkovicí a zeleninou, česnekový dresink	250gtortillaplnenatrhanouveprovoukrkoviciazeleninou,cesnekovydresink	1a, 7, 9	250g Tortilla Stuffed with Shredded Pork Neck and Vegetables, garlic Dressing	2
1637	300g Řecký salát s feta sýrem, červenou cibulí, cherry rajčaty a olivami, kuřecí kousky	300greckysalatsfetasyrem,cervenoucibuli,cherryrajcatyaolivami,kurecikousky	7	300g Greek Pasta Salad with Fetta Cheese, Red Onion, Cherry Tomatoes and Olives, chicken Pieces	2
880	3 Sterilovaná hotovka ve skle  - Hovězí stroganof,Znojemské hovězí nudličky,Vepřová panenka se svíčkovou om.,Hovězí pečeně s rajskou om.-,Hovězí guláš	3sterilovanahotovkaveskle-hovezistroganof,znojemskehovezinudlicky,veprovapanenkasesvickovouom.,hovezipecenesrajskouom.-,hovezigulas		\N	5
886	3 Sterilovaná hotovka ve skle  -Krůtí kari	3sterilovanahotovkaveskle-krutikari		\N	5
1638	Sterilovaná polévka ve skle  0,7l - Gulášová,Z restovaných paprik,Cibulačka,Brokolicový chowder,Kuřecí,Jemná pepřová omáčka	sterilovanapolevkaveskle0,7l-gulasova,zrestovanychpaprik,cibulacka,brokolicovychowder,kureci,jemnapeprovaomacka		Sterilovaná polévka ve skle  0,7l - Gulášová,Z restovaných paprik,Cibulačka,Brokolicový chowder,Kuřecí,Jemná pepřová omáčka	5
1639	2 Sterilovaná hotovka ve skle  - Kuřecí kari,Kuličky s mletého masa s rajskou om.,Steak z vepřové krkovice s pepřovou om.	2sterilovanahotovkaveskle-kurecikari,kulickysmletehomasasrajskouom.,steakzveprovekrkovicespeprovouom.		2 Sterilovaná hotovka ve skle  - Kuřecí kari,Kuličky s mletého masa s rajskou om.,Steak z vepřové krkovice s pepřovou om.	5
1640	120g Kuřecí roláda se špenátem a anglickou slaninou, jus-lie s cibulkami, dušená rýže	120gkureciroladasespenatemaanglickouslaninou,jus-liescibulkami,dusenaryze	1, 3, 6, 7, 9, 10, 12	120g Chicken Roulade with Spinach and Bacon, lightly Thickened Jus with Onions, stewed Rice	1
1006	Čočková	cockova	1a, 9	Lentil Soup	9
1641	120g Kuřecí madras kari se zázvorem, čili a paprikou, dušená rýže	120gkurecimadraskarisezazvorem,ciliapaprikou,dusenaryze		120g Chicken Madras Curry with Ginger, Chilli and Sweet Peppers, stewed Rice	2
1642	Sterilovaná polévka ve skle 0,7l - Boršč,Rajská	sterilovanapolevkaveskle0,7l-borsc,rajska		Sterilovaná polévka ve skle 0,7l - Boršč,Rajská	5
1643	2 Sterilovaná hotovka ve skle  - Vepřová krkovice s pepřovou omáčkou	2sterilovanahotovkaveskle-veprovakrkovicespeprovouomackou		2 Sterilovaná hotovka ve skle  - Vepřová krkovice s pepřovou omáčkou	5
1644	3 Sterilovaná hotovka ve skle - Chow-mein z vepřové panenky	3sterilovanahotovkaveskle-chow-meinzveprovepanenky		3 Sterilovaná hotovka ve skle - Chow-mein z vepřové panenky	5
1645	150g Kuřecí stripsy, smažené hranolky	150gkurecistripsy,smazenehranolky	1a, 3, 7	150g Kuřecí stripsy, french Fries (Fried Potato Chips)	2
989	Batátový krém	batatovykrem	7, 9	Sweet Potato Cream	9
1646	Rozbaš-hrachová s masem a rajčaty	rozbas-hrachovasmasemarajcaty	1a, 9, 10	Pea Soup with Meat and Tomatoes	9
1647	120g Kotlíkový guláš s uzeninou, hovězím a vepřovým masem, kápií a bramborami, kmínový chléb	120gkotlikovygulassuzeninou,hovezimaveprovymmasem,kapiiabramborami,kminovychleb	1, 9, 10	120g Goulash with Summer Sausage, Beef and Pork, Sweet Bell Peppers and Potatoes, caraway Seed Bread	2
1648	300g Dušený špenát, 2 vejce, vařené brambory s máslem	300gdusenyspenat,2vejce,varenebramborysmaslem	1a, 3, 7, 9, 10	300g Stewed Spinach, 2 Eggs, boiled Potatoes with Butter	2
1649	120g Smažený filet z mníka mořského, karotkové pyré	120gsmazenyfiletzmnikamorskeho,karotkovepyre	1, 3, 4, 7, 9	120g Fried White Ling Fillet, carrot Purée	2
1650	240g Pečené kuřecí stehno s provensálským kořením, jasmínová rýže, bez lepku	240gpecenekurecistehnosprovensalskymkorenim,jasminovaryze,bezlepku	9, 10	240g Roasted Chicken Leg with Provencal Spice, jasmine Rice, gluten Free	2
688	300g Nudle Wok s vepřovou panenkou, zeleninou a sweet chilli omáčkou	300gnudlewoksveprovoupanenkou,zeleninouasweetchilliomackou	1a, 1b, 3, 5, 6, 7, 9, 10, 11	300g Wok Noodles with Pork Loin, Vegetables and Sweet Chilli Sauce	6
1651	120g Jižanský kuřecí řízek, bramborový salát s majonézou	120gjizanskykurecirizek,bramborovysalatsmajonezou	1a, 3, 7, 9, 10	120g Spicy Chicken Schnitzel, potato Salad with Mayonnaise	6
1652	200g Dušený špenát, 2 vejce, vařené brambory s máslem	200gdusenyspenat,2vejce,varenebramborysmaslem	1a, 3, 7, 9, 10	200g Stewed Spinach, 2 Eggs, boiled Potatoes with Butter	2
1653	120g Ciabatta s grilovaným kuřecím masem a zeleninou, pikantní dresink, smažené hranolky	120gciabattasgrilovanymkurecimmasemazeleninou,pikantnidresink,smazenehranolky	1a, 3, 6, 7, 9, 10, 11, 12	120g Ciabatta with Grilled Chicken Meat and Vegetables, spicy Dressing, french Fries (Fried Potato Chips)	6
1654	100g Smažená mozzarella, bramborové hranolky, zeleninová obloha	100gsmazenamozzarella,bramborovehranolky,zeleninovaobloha	1a, 3, 7	100g Fried Mozzarella, potato French Fries, vegetable Garnish	6
1655	120g Hovězí maso vařené, koprová omáčka, houskový knedlík	120ghovezimasovarene,koprovaomacka,houskovyknedlik	1a, 3, 7, 9	120g Boiled Beef Meat, Dill Sauce, bread Dumplings	2
627	300g Asijský salát s rýžovými nudlemi, zeleninou a marinovanými vepřovými nudličkami v teryiaki omáčce a chilli	300gasijskysalatsryzovyminudlemi,zeleninouamarinovanymiveprovyminudlickamivteryiakiomacceachilli	1, 3, 6, 7, 9, 10	300g Asian Salad with Rice Noodles, Vegetables, Mungo Sprouts and Marinated Beef Noodles	2
1656	300g Gnocchi s rajčatovou omáčkou, mozzarella kuličkami a bazalkou, kuřecí kousky	300ggnocchisrajcatovouomackou,mozzarellakulickamiabazalkou,kurecikousky	1a, 7, 9	300g Gnocchi, served with Tomato Sauce, Mozzarella Balls and Basil, chicken Pieces	2
953	3 Sterilovaná hotovka ve skle 0,7l - Znojemské hov.nudličky s okur.a slan.	3sterilovanahotovkaveskle0,7l-znojemskehov.nudlickysokur.aslan.		\N	5
1015	Francouzská cibulačka se sýrovými krutony	francouzskacibulackasesyrovymikrutony	1a, 7, 9, 12	\N	9
1657	Sterilovaná polévka ve skle 0,7l - Z restovaných paprik,Hovězí vývar	sterilovanapolevkaveskle0,7l-zrestovanychpaprik,hovezivyvar		Sterilovaná polévka ve skle 0,7l - Z restovaných paprik,Hovězí vývar	5
1658	2 Sterilovaná hotovka ve skle  -Vepřová krkovice,Rajská s masovými kuličkami	2sterilovanahotovkaveskle-veprovakrkovice,rajskasmasovymikulickami		2 Sterilovaná hotovka ve skle  -Vepřová krkovice,Rajská s masovými kuličkami	5
1659	Sterilovaná polévka ve skle  0,7l - Gulášová,Z restovaných paprik,Cibulačka,Hovězí vývar,Brokolicový chowder,Kuřecí,Jemná pepřová omáčka	sterilovanapolevkaveskle0,7l-gulasova,zrestovanychpaprik,cibulacka,hovezivyvar,brokolicovychowder,kureci,jemnapeprovaomacka		Sterilovaná polévka ve skle  0,7l - Gulášová,Z restovaných paprik,Cibulačka,Hovězí vývar,Brokolicový chowder,Kuřecí,Jemná pepřová omáčka	5
1660	120g Pekingské hovězí nudličky se zeleninou, zázvorem a sojovou omáčkou, jasmínová rýže	120gpekingskehovezinudlickysezeleninou,zazvoremasojovouomackou,jasminovaryze	1a, 6, 7, 9, 10	120g Beijing Beef Noodles with Vegetables, Ginger and Soya Meat Sauce, jasmine Rice	1
1074	Sendvič šunka+sýr,tre formaggi,salámový,šunka+hermelín,káva presso+j.štrůdl, 2ks párek pečivo	sendvicsunka+syr,treformaggi,salamovy,sunka+hermelin,kavapresso+j.strudl,2ksparekpecivo		\N	4
1661	Vývar z hovězího BIO masa se zeleninou a nudlemi	vyvarzhovezihobiomasasezeleninouanudlemi	1a, 1b, 9	Organic Beef Broth with Vegetables and Noodles	9
1662	120g Kuřecí Cordon Blue s česnekovým máslem, vařené brambory	120gkurecicordonbluescesnekovymmaslem,varenebrambory	1a, 3, 7	120g Chicken Cordon Bleu with Ham and Gouda Cheese, boiled Potatoes	2
1663	150g Ražniči z vepřové panenky s paprikami a cibulí, jasmínová rýže, česnekový dip	150graznicizveprovepanenkyspaprikamiacibuli,jasminovaryze,cesnekovydip	1a, 7, 9, 10	150g Pork Undercut Skewer with Peppers and Onion, jasmine Rice, garlic Dip	2
1664	300g Dukátové buchtičky s vanilkovým krémem a slaným karamelem	300gdukatovebuchtickysvanilkovymkrememaslanymkaramelem	1a, 3, 7	300g Small Yeast Buns with Vanilla Custard and Salted Caramel	2
1665	150g Kuřecí gyros v brioche bulce, coleslaw s červenou řepou a mrkví, americké brambory	150gkurecigyrosvbriochebulce,coleslawscervenourepouamrkvi,americkebrambory	1a, 1b, 3, 7, 9, 10	150g Chicken Gyros in Brioche Bun, Coleslaw with Beetroot and Carrots, potato Wedges	6
1666	120g Ciabatta s trhaným vepřovým masem, bramborové hranolky, medovo hořčicový dip	120gciabattastrhanymveprovymmasem,bramborovehranolky,medovohorcicovydip	1a, 7, 9, 10	120g Ciabatta with Pulled Pork Meat, potato French Fries, honey and Mustard Dip	6
1667	150g Kuřecí Cordon Blue s česnekovým máslem, vařené brambory	150gkurecicordonbluescesnekovymmaslem,varenebrambory	1a, 3, 7	150g Chicken Cordon Bleu with Ham and Gouda Cheese, boiled Potatoes	2
1668	Dukátové buchtičky s vanilkovým krémem	dukatovebuchtickysvanilkovymkremem	1a, 3, 7	Buns with Vanilla Creme	2
1669	Sterilovaná polévka ve skle 0,7l - Z restovaných paprik, Kuřecí krémová, Brokolicový krém, Cibulačka	sterilovanapolevkaveskle0,7l-zrestovanychpaprik,kurecikremova,brokolicovykrem,cibulacka		Sterilovaná polévka ve skle 0,7l - Z restovaných paprik, Kuřecí krémová, Brokolicový krém, Cibulačka	5
1670	2 Sterilovaná hotovka ve skle 0,7l - Masové kuličky rajská om., Vepř.krkovice s pepř.omáčkou	2sterilovanahotovkaveskle0,7l-masovekulickyrajskaom.,vepr.krkovicespepr.omackou		2 Sterilovaná hotovka ve skle 0,7l - Masové kuličky rajská om., Vepř.krkovice s pepř.omáčkou	5
1671	150g Pikantní kuřecí směs s ananasem, dušená rýže	150gpikantnikurecismessananasem,dusenaryze	3, 6, 7, 9	150g Spicy Chicken Meat with Pineapple, stewed Rice	2
1672	150g Šneci z vepřové panenky na špejli s cibulí a anglickou slaninou, vařené brambory, tatarská omáčka	150gsnecizveprovepanenkynaspejliscibuliaanglickouslaninou,varenebrambory,tatarskaomacka	1a, 3, 7, 9, 10	150g Pork Loin Skewer with Onion and Dried Tomatoes, boiled Potatoes, tartar Sauce	2
1673	300g Zeleninový salát s cherry rajčaty, ředkvičkami a slunečnicovým semínkem , grilovaný sýr Halloumi, opečený toast	300gzeleninovysalatscherryrajcaty,redkvickamiaslunecnicovymseminkem,grilovanysyrhalloumi,opecenytoast	1a, 7, 9	300g Vegetable Salad with Cherry Tomatoes, Radishes and Sunflower Seeds, grilled Halloumi Cheese, toast	2
1116	Sterilovaná polévka ve skle 0,7l - Gulášová, Dýňová, Hovězí vývar	sterilovanapolevkaveskle0,7l-gulasova,dynova,hovezivyvar		\N	5
526	250g Gratinované gnochi s kuřecím masem, rajčatovou omáčkou a sýrem	250ggratinovanegnochiskurecimmasem,rajcatovouomackouasyrem	1a, 3, 7, 9	250g Scalloped Gnocchi with Chicken Meat, Tomato Sauce and Cheese	6
1674	2 Sterilovaná hotovka ve skle  - Krkovice se steakovou omáčkou, Rajská s kuličkami	2sterilovanahotovkaveskle-krkovicesesteakovouomackou,rajskaskulickami		2 Sterilovaná hotovka ve skle  - Krkovice se steakovou omáčkou, Rajská s kuličkami	5
974	460g Pizza MONACO tomat, šunka, žampiony,mozzarella, oregáno	460gpizzamonacotomat,sunka,zampiony,mozzarella,oregano	1a, 1b, 7	\N	8
981	480g Pizza RIVIERA tomat,v.šunka,mozzarella,kukuřice,žampiony	480gpizzarivieratomat,v.sunka,mozzarella,kukurice,zampiony	1a, 1b, 7	\N	8
987	550g Pizza PESCARA tomat, rajčata, kukuřice, smetana, balkán, mozzarella	550gpizzapescaratomat,rajcata,kukurice,smetana,balkan,mozzarella	1a, 1b, 7	\N	8
990	BIO Hovězí vývar s bylinkovým kapáním	biohovezivyvarsbylinkovymkapanim	1a, 3, 7	\N	9
992	BIO Hovězí vývar se zeleninou a bylinkovými noky	biohovezivyvarsezeleninouabylinkovyminoky	1a, 3, 7	\N	9
993	BIO Hovězí vývar s karotkou a nudlemi	biohovezivyvarskarotkouanudlemi	1a, 3, 9	\N	9
994	BIO Slepičí vývar se zeleninou	bioslepicivyvarsezeleninou	1a, 3, 9	\N	9
983	490g Pizza FLORIDA kuřecí maso, ananas, smetana, mozzarella	490gpizzafloridakurecimaso,ananas,smetana,mozzarella	1a, 1b, 7	490g Pizza FLORIDA Chicken Meat, Pineapple, Single Cream, Mozzarella	8
1675	240g Nadívané kuřecí stehno s jarní nádivkou, dušená rýže	240gnadivanekurecistehnosjarninadivkou,dusenaryze	1a, 1b, 3, 5, 7, 9, 10, 11	240g Stuffed Chicken Leg with Spring Stuffing, stewed Rice	2
1676	130g Smažený filet z mníka mořského, šťouchané brambory	130gsmazenyfiletzmnikamorskeho,stouchanebrambory	1, 3, 4, 7, 9	130g Fried White Ling Fillet, mashed Potatoes	1
1677	120g Vepřové trhané maso, bramborové hranolky, medovo hořčicový dip	120gveprovetrhanemaso,bramborovehranolky,medovohorcicovydip		120g Pulled Pork, potato French Fries, honey and Mustard Dip	6
1678	250g Smažený květák, šťouchané brambory, tatarská omáčka	250gsmazenykvetak,stouchanebrambory,tatarskaomacka	1a, 3, 7, 10	250g Fried Cauliflower, mashed Potatoes, tartar Sauce	6
1679	300g Míchané tofu se zeleninou a peperonátou, dušená rýže, bez lepku	300gmichanetofusezeleninouapeperonatou,dusenaryze,bezlepku	6, 8, 9	300g Scrambled Tofu with Vegetables and a Peperonata Sauce, stewed Rice, gluten Free	1
988	550g Pizza VALENTÝNKA tomat, šunka, kukuřice, kápie, č.olivy,mozzarella	550gpizzavalentynkatomat,sunka,kukurice,kapie,c.olivy,mozzarella	1a, 1b, 7, 10	550g Pizza VALENTINE Tomato Purée, Ham, Maize, Sweet Capsicum, Black Olives, Edam Cheese	8
1199	Zeleninová	zeleninova	1a, 9	Vegetable Soup	9
985	510g Pizza RUKOLA tomat, mozzarela, rajčata, rukola	510gpizzarukolatomat,mozzarela,rajcata,rukola	1a, 1b, 7	510g Pizza RUKOLA tomat, Mozzarella, Tomatoes, Rocket Salad	8
972	460g Pizza MADONA tomat, rajče, niva,mozzarella	460gpizzamadonatomat,rajce,niva,mozzarella	1a, 1b, 7	460g Pizza MADONA Tomato Purée, Blue Cheese, Tomato, Edam Cheese	8
984	510g Pizza REGINA tomat, šunka, anglická slanina, kukuřice, vejce, mozzarella	510gpizzareginatomat,sunka,anglickaslanina,kukurice,vejce,mozzarella	1a, 1b, 3, 7	510g Pizza REGINA Tomato Purée, Ham, Bacon, Maize, Egg, Edam Cheese	8
550	2 Sterilovaná hotovka ve skle  - Boloňská směs	2sterilovanahotovkaveskle-bolonskasmes		2 Sterilovaná hotovka ve skle  - Boloňská směs	5
1680	120g Zapečená vepřová kotleta se zeleninovou směsí a sýrem, jasmínová rýže	120gzapecenaveprovakotletasezeleninovousmesiasyrem,jasminovaryze	1a, 7, 9, 10	120g Baked Pork Chop with Mixed Vegetables and Cheese, jasmine Rice	2
549	2 Sterilovaná hotovka ve skle  -Boloň ská,Vepřový vrabecRajská omáčka s kuličkamu	2sterilovanahotovkaveskle-bolonska,veprovyvrabecrajskaomackaskulickamu		\N	5
551	2 Sterilovaná hotovka ve skle  - Boloňská směs,Kuřecí kari	2sterilovanahotovkaveskle-bolonskasmes,kurecikari		\N	5
552	2 Sterilovaná hotovka ve skle  - Boloňská směs,Kuřecí kari,Kuličky z mletého masa s rajskou om.	2sterilovanahotovkaveskle-bolonskasmes,kurecikari,kulickyzmletehomasasrajskouom.		\N	5
553	2 Sterilovaná hotovka ve skle  - Boloňská směs,Kuřecí kari,Kuličky z mletého masa s rajskou om.,Vepřový vrabec	2sterilovanahotovkaveskle-bolonskasmes,kurecikari,kulickyzmletehomasasrajskouom.,veprovyvrabec		\N	5
554	2 Sterilovaná hotovka ve skle  - Boloňská směs, Kuřecí kari madras	2sterilovanahotovkaveskle-bolonskasmes,kurecikarimadras		\N	5
558	2 Sterilovaná hotovka ve skle  -Boloňská směs,Rajská s kuličkami,Kuřecí kari	2sterilovanahotovkaveskle-bolonskasmes,rajskaskulickami,kurecikari		\N	5
559	2 Sterilovaná hotovka ve skle  - Boloňská směs, Vepřový vrabec. Kuřecí prsa na paprice	2sterilovanahotovkaveskle-bolonskasmes,veprovyvrabec.kureciprsanapaprice		\N	5
560	2 Sterilovaná hotovka ve skle  - Boloňská vepřová směs, Rajská om.s kuličkami, Vepř.vrabec se zelím	2sterilovanahotovkaveskle-bolonskaveprovasmes,rajskaom.skulickami,vepr.vrabecsezelim		\N	5
561	2 Sterilovaná hotovka ve skle  - Boloňská vepřová směs, Rajská omáčka s kuličkam	2sterilovanahotovkaveskle-bolonskaveprovasmes,rajskaomackaskulickam		\N	5
562	2 Sterilovaná hotovka ve skle  - Boloňská vepřová směs, Vepř.vrabec se zelím	2sterilovanahotovkaveskle-bolonskaveprovasmes,vepr.vrabecsezelim		\N	5
565	2 Sterilovaná hotovka ve skle  - Kuřecí kari, Boloňská směs	2sterilovanahotovkaveskle-kurecikari,bolonskasmes		\N	5
566	2 Sterilovaná hotovka ve skle  -  Kuřecí kari,Kuličky z mletého masa s rajskou om.,Boloňská směs	2sterilovanahotovkaveskle-kurecikari,kulickyzmletehomasasrajskouom.,bolonskasmes		\N	5
567	2 Sterilovaná hotovka ve skle  - Kuřecí kari madras, Boloňská sm.vepřová, Vepř.vrabec se zelím	2sterilovanahotovkaveskle-kurecikarimadras,bolonskasm.veprova,vepr.vrabecsezelim		\N	5
568	2 Sterilovaná hotovka ve skle  - Kuřecí kousky tikka masala,Kuřecí směs,Vepřový vrabec,Kuličky z mletého masa s rajskou om.,Kuřecí kari	2sterilovanahotovkaveskle-kurecikouskytikkamasala,kurecismes,veprovyvrabec,kulickyzmletehomasasrajskouom.,kurecikari		\N	5
569	2 Sterilovaná hotovka ve skle  - Kuřecí kousky tikka masala,Segedínský guláš	2sterilovanahotovkaveskle-kurecikouskytikkamasala,segedinskygulas		\N	5
570	2 Sterilovaná hotovka ve skle  - Kuřecí kousky tikka masala,Segedínský guláš,Kuřecí směs	2sterilovanahotovkaveskle-kurecikouskytikkamasala,segedinskygulas,kurecismes		\N	5
571	2 Sterilovaná hotovka ve skle  -Kuřecí na paprice,Kuřecí Tikka masala,Segedínský guláš,Masové kuličky s rajskou omáčkou	2sterilovanahotovkaveskle-kurecinapaprice,kurecitikkamasala,segedinskygulas,masovekulickysrajskouomackou		\N	5
572	2 Sterilovaná hotovka ve skle  -  Kuřecí směs,Vepřový vrabec,Kuličky z mletého masa s rajskou om.,Kuřecí kari	2sterilovanahotovkaveskle-kurecismes,veprovyvrabec,kulickyzmletehomasasrajskouom.,kurecikari		\N	5
573	2 Sterilovaná hotovka ve skle  -  Kuřecí směs,Vepřový vrabec,Kuřecí kari,Kuřecí kousky	2sterilovanahotovkaveskle-kurecismes,veprovyvrabec,kurecikari,kurecikousky		\N	5
574	2 Sterilovaná hotovka ve skle  -  Kuřecí směs,Vepřový vrabec,Kuřecí kari,Kuřecí kousky,Kuřecí na paprice	2sterilovanahotovkaveskle-kurecismes,veprovyvrabec,kurecikari,kurecikousky,kurecinapaprice		\N	5
575	2 Sterilovaná hotovka ve skle  -  Kuřecí směs,Vepřový vrabec,Kuřecí kari,Kuřecí kousky,Kuřecí na paprice,Boloňská směs,Kuličky z mletého masa s rajskou om.	2sterilovanahotovkaveskle-kurecismes,veprovyvrabec,kurecikari,kurecikousky,kurecinapaprice,bolonskasmes,kulickyzmletehomasasrajskouom.		\N	5
576	2 Sterilovaná hotovka ve skle  - Kuřecí tikka masala,Segedínský guláš	2sterilovanahotovkaveskle-kurecitikkamasala,segedinskygulas		\N	5
577	2 Sterilovaná hotovka ve skle  -Kuřecí tikka masala,Segedínský guláš,Kuřecí směs	2sterilovanahotovkaveskle-kurecitikkamasala,segedinskygulas,kurecismes		\N	5
578	2 Sterilovaná hotovka ve skle  -Kuřecí Tikka masala,Segedínský guláš,Masové kuličky s rajskou omáčkou	2sterilovanahotovkaveskle-kurecitikkamasala,segedinskygulas,masovekulickysrajskouomackou		\N	5
579	2 Sterilovaná hotovka ve skle  -Masové kuličky s rajskou omáčkou,Segedínský guláš,Kuřecí směs,Vepřový vrabec se zelím	2sterilovanahotovkaveskle-masovekulickysrajskouomackou,segedinskygulas,kurecismes,veprovyvrabecsezelim		\N	5
581	2 Sterilovaná hotovka ve skle  - Masové kuličky s rajskou omáčkou,Segedínský guláš,Kuřecí směs,Vepřový vrabec se zelím,Vepřová boloňská směs,Kuřecí mousky,Kuřecí na paprice	2sterilovanahotovkaveskle-masovekulickysrajskouomackou,segedinskygulas,kurecismes,veprovyvrabecsezelim,veprovabolonskasmes,kurecimousky,kurecinapaprice		\N	5
582	2 Sterilovaná hotovka ve skle  -Masové kuličky s rajskou omáčkou,Tikka masala	2sterilovanahotovkaveskle-masovekulickysrajskouomackou,tikkamasala		\N	5
583	2 Sterilovaná hotovka ve skle  - Masové kuličky s rajskou omáčkou,Tikka masala,Segedínský guláš	2sterilovanahotovkaveskle-masovekulickysrajskouomackou,tikkamasala,segedinskygulas		\N	5
584	2 Sterilovaná hotovka ve skle  -Masové kuličky s rajskou omáčkou,Vepřová boloňská směs,Tikka masala	2sterilovanahotovkaveskle-masovekulickysrajskouomackou,veprovabolonskasmes,tikkamasala		\N	5
585	2 Sterilovaná hotovka ve skle  - Rajská om.s vepř.kuličkami, Kari madras, Boloňská směs, Vepř.vrabec se zelím	2sterilovanahotovkaveskle-rajskaom.svepr.kulickami,karimadras,bolonskasmes,vepr.vrabecsezelim		\N	5
586	2 Sterilovaná hotovka ve skle  - Rajská s kuličkami, Kuřecí kari	2sterilovanahotovkaveskle-rajskaskulickami,kurecikari		\N	5
587	2 Sterilovaná hotovka ve skle  - Segedínský guláš,Kuřecí směs,Vepřový vrabec se zelím	2sterilovanahotovkaveskle-segedinskygulas,kurecismes,veprovyvrabecsezelim		\N	5
588	2 Sterilovaná hotovka ve skle  - Segedínský guláš,Kuřecí směs,Vepřový vrabec se zelím,Kuřecí kousky na zeleném pepři,Vepřová boloňská směs	2sterilovanahotovkaveskle-segedinskygulas,kurecismes,veprovyvrabecsezelim,kurecikouskynazelenempepri,veprovabolonskasmes		\N	5
589	2 Sterilovaná hotovka ve skle  - Segedínský guláš,Kuřecí směs,Vepřový vrabec se zelím,Vepřová boloňská směs,Kuřecí kousky na zeleném pepři,Kuřecí na paprice	2sterilovanahotovkaveskle-segedinskygulas,kurecismes,veprovyvrabecsezelim,veprovabolonskasmes,kurecikouskynazelenempepri,kurecinapaprice		\N	5
590	2 Sterilovaná hotovka ve skle  - Tikka masala, Segedínský guláš,	2sterilovanahotovkaveskle-tikkamasala,segedinskygulas,		\N	5
591	2 Sterilovaná hotovka ve skle  - Tikka masala, Segedínský guláš, Boloňská směs	2sterilovanahotovkaveskle-tikkamasala,segedinskygulas,bolonskasmes		\N	5
592	2 Sterilovaná hotovka ve skle  -Tikka masala,Vepřová boloňská směs,Masové kuličky s rajskou omáčkou	2sterilovanahotovkaveskle-tikkamasala,veprovabolonskasmes,masovekulickysrajskouomackou		\N	5
594	2 Sterilovaná hotovka ve skle  -Vepřová boloňská směs,Kuřecí tikka masala,Masové kuličky s rajskou omáčkou	2sterilovanahotovkaveskle-veprovabolonskasmes,kurecitikkamasala,masovekulickysrajskouomackou		\N	5
597	2 Sterilovaná hotovka ve skle  - Vepřový vrabec,,Kuřecí kousky,Kuřecí na paprice,Boloňská směs,Kuličky z mletého masa s rajskou om.	2sterilovanahotovkaveskle-veprovyvrabec,,kurecikousky,kurecinapaprice,bolonskasmes,kulickyzmletehomasasrajskouom.		\N	5
598	2 Sterilovaná hotovka ve skle  - Vepřový vrabec, Boloňská směs, Kuřecí na paprice	2sterilovanahotovkaveskle-veprovyvrabec,bolonskasmes,kurecinapaprice		\N	5
599	2 Sterilovaná hotovka ve skle  - Vepřový vrabec, Boloňská směs, Kuřecí prsa na paprice	2sterilovanahotovkaveskle-veprovyvrabec,bolonskasmes,kureciprsanapaprice		\N	5
600	2 Sterilovaná hotovka ve skle  - Vepřový vrabec, Boloňská směs, Kuřecí prsa na paprice,	2sterilovanahotovkaveskle-veprovyvrabec,bolonskasmes,kureciprsanapaprice,		\N	5
601	2 Sterilovaná hotovka ve skle  - Vepřový vrabec,Kuřecí kari,Kuřecí kousky,Kuřecí na paprice,Boloňská směs,Kuličky z mletého masa s rajskou om.	2sterilovanahotovkaveskle-veprovyvrabec,kurecikari,kurecikousky,kurecinapaprice,bolonskasmes,kulickyzmletehomasasrajskouom.		\N	5
602	2 Sterilovaná hotovka ve skle  - Vepřový vrabec,Kuřecí kousky,Kuřecí na paprice,Boloňská směs,Frankfurtská pečeně	2sterilovanahotovkaveskle-veprovyvrabec,kurecikousky,kurecinapaprice,bolonskasmes,frankfurtskapecene		\N	5
603	2 Sterilovaná hotovka ve skle  - Vepřový vrabec,Kuřecí kousky,Kuřecí na paprice,Boloňská směs,Kuličky z mletého masa s rajskou om.,Frankfurtská pečeně	2sterilovanahotovkaveskle-veprovyvrabec,kurecikousky,kurecinapaprice,bolonskasmes,kulickyzmletehomasasrajskouom.,frankfurtskapecene		\N	5
604	2 Sterilovaná hotovka ve skle  - Vepřový vrabec, Kuřecí prsa na paprice, Rajská s kuličkami, Boloňská směs	2sterilovanahotovkaveskle-veprovyvrabec,kureciprsanapaprice,rajskaskulickami,bolonskasmes		\N	5
606	2 Sterilovaná hotovka ve skle 0,7l - Bboloňská směs,  Masové kuličkys rajskou om., Moravský vrabec, zelí, Kuřecí kousky na zel.pepři,tymiánový just, Segedínský guláš s v. masem	2sterilovanahotovkaveskle0,7l-bbolonskasmes,masovekulickysrajskouom.,moravskyvrabec,zeli,kurecikouskynazel.pepri,tymianovyjust,segedinskygulassv.masem		\N	5
607	2 Sterilovaná hotovka ve skle 0,7l - Boloňská vepř. směs	2sterilovanahotovkaveskle0,7l-bolonskavepr.smes		\N	5
608	2 Sterilovaná hotovka ve skle 0,7l - Boloňská vepř. směs, Kuř.kousky Tikka masala s rajč.a jogurt.	2sterilovanahotovkaveskle0,7l-bolonskavepr.smes,kur.kouskytikkamasalasrajc.ajogurt.		\N	5
609	2 Sterilovaná hotovka ve skle 0,7l - Boloňská vepř. směs, Kuř.kousky Tikka masala s rajč.a jogurt.-	2sterilovanahotovkaveskle0,7l-bolonskavepr.smes,kur.kouskytikkamasalasrajc.ajogurt.-		\N	5
610	2 Sterilovaná hotovka ve skle 0,7l - Boloňská vepř.směs, Kuřecí kari se zázv,zel.a korian., Kuřecí kousky na zel.pepři,tymianový just, Moravský vrabec, zelí, Kuřecí směs s rajč.om.,bazalkou a chilli, Segedínský guláš s v. masem	2sterilovanahotovkaveskle0,7l-bolonskavepr.smes,kurecikarisezazv,zel.akorian.,kurecikouskynazel.pepri,tymianovyjust,moravskyvrabec,zeli,kurecismessrajc.om.,bazalkouachilli,segedinskygulassv.masem		\N	5
611	2 Sterilovaná hotovka ve skle 0,7l - Boloňská vepř.směs, Kuřecí kari se zázv,zel.a korian., Kuřecí m., tymianový just, Moravský vrabec, zelí, Kuřecí směs s rajč.om.,bazalkou a chilli, Segedínský guláš s v. masem	2sterilovanahotovkaveskle0,7l-bolonskavepr.smes,kurecikarisezazv,zel.akorian.,kurecim.,tymianovyjust,moravskyvrabec,zeli,kurecismessrajc.om.,bazalkouachilli,segedinskygulassv.masem		\N	5
612	2 Sterilovaná hotovka ve skle 0,7l - Boloňská vepř. směs, Kuřecí kari se zázv,zel.a korian., Moravský vrabec, zelí, Kuřecí směs s rajč.om.,bazalkou a chilli, Kuřecí kosky na zel.pepři,tymiánový just, Segedínský guláš s v. masem	2sterilovanahotovkaveskle0,7l-bolonskavepr.smes,kurecikarisezazv,zel.akorian.,moravskyvrabec,zeli,kurecismessrajc.om.,bazalkouachilli,kurecikoskynazel.pepri,tymianovyjust,segedinskygulassv.masem		\N	5
613	2 Sterilovaná hotovka ve skle 0,7l - Boloňská vepř. směs, Masové kuličky, rajská omáčka, Kuř.kousky Tikka masala s rajč.a jogurt.	2sterilovanahotovkaveskle0,7l-bolonskavepr.smes,masovekulicky,rajskaomacka,kur.kouskytikkamasalasrajc.ajogurt.		\N	5
679	300g Kynuté ovocné knedlíky sypané mandlovou strouhankou, přepuštěné máslo	300gkynuteovocneknedlikysypanemandlovoustrouhankou,prepustenemaslo	1a, 3, 7, 8, 8a	300g Yeast Dumplings with Fruits, Sprinkled with Almond Crumbs, Melted Butter	2
614	2 Sterilovaná hotovka ve skle 0,7l - Boloňská vepř. směs, Masové kuličkys rajskou om., Moravský vrabec, zelí, Kuřecí kousky na zel.pepři,tymiánový just, Segedínský guláš s v. masem	2sterilovanahotovkaveskle0,7l-bolonskavepr.smes,masovekulickysrajskouom.,moravskyvrabec,zeli,kurecikouskynazel.pepri,tymianovyjust,segedinskygulassv.masem		\N	5
616	2 Sterilovaná hotovka ve skle 0,7l - Boloňská vepř. směs, Moravský vrabec, zelí, Kuřecí směs s rajč.om.,bazalkou a chilli, Kuřecí kousky na zel.pepři,tymiánový just, Segedínský guláš s v. masem	2sterilovanahotovkaveskle0,7l-bolonskavepr.smes,moravskyvrabec,zeli,kurecismessrajc.om.,bazalkouachilli,kurecikouskynazel.pepri,tymianovyjust,segedinskygulassv.masem		\N	5
595	2 Sterilovaná hotovka ve skle  -Vepřový vrabec	2sterilovanahotovkaveskle-veprovyvrabec		2 Sterilovaná hotovka ve skle  - Vepřový vrabec	5
617	2 Sterilovaná hotovka ve skle 0,7l - Kuřecí kari se zázv,zel.a korian., Moravský vrabec, zelí, Kuřecí směs s rajč.om.,bazalkou a chilli, Segedínský guláš s v. masem	2sterilovanahotovkaveskle0,7l-kurecikarisezazv,zel.akorian.,moravskyvrabec,zeli,kurecismessrajc.om.,bazalkouachilli,segedinskygulassv.masem		\N	5
618	2 Sterilovaná hotovka ve skle 0,7l - Kuřecí směs s rajč.om.,bazalkou a chilli, Segedínský guláš s v. masem	2sterilovanahotovkaveskle0,7l-kurecismessrajc.om.,bazalkouachilli,segedinskygulassv.masem		\N	5
619	2 Sterilovaná hotovka ve skle 0,7l - Kuřecí Tikka masala s rajč. jog. a smetanou, Boloňská vep. směs, Masové kuličky s rajskou om.,	2sterilovanahotovkaveskle0,7l-kurecitikkamasalasrajc.jog.asmetanou,bolonskavep.smes,masovekulickysrajskouom.,		\N	5
622	2 Sterilovaná hotovka ve skle 0,7l - Masové kuličky s rajskou om., Kuř.prso na paprice,  Boloňská vepř. směs, Moravský vrabec, zelí, Kuřecí směs s rajč.om.,bazalkou a chilli, Kuřecí kousky na zel.pepři,tymiánový just, Segedínský guláš s v. masem	2sterilovanahotovkaveskle0,7l-masovekulickysrajskouom.,kur.prsonapaprice,bolonskavepr.smes,moravskyvrabec,zeli,kurecismessrajc.om.,bazalkouachilli,kurecikouskynazel.pepri,tymianovyjust,segedinskygulassv.masem		\N	5
623	2 Sterilovaná hotovka ve skle 0,7l - Masové kuličkys rajskou om., Moravský vrabec, zelí, Kuřecí kousky na zel.pepři,tymiánový just, Segedínský guláš s v. masem	2sterilovanahotovkaveskle0,7l-masovekulickysrajskouom.,moravskyvrabec,zeli,kurecikouskynazel.pepri,tymianovyjust,segedinskygulassv.masem		\N	5
625	2 Sterilovaná hotovka ve skle 0,7l - Segedínský guláš s v.masem, Kuřecí Tikka masala s rajč. jog. a smetanou, Boloňská vep. směs, Masové kuličky s rajskou om.,	2sterilovanahotovkaveskle0,7l-segedinskygulassv.masem,kurecitikkamasalasrajc.jog.asmetanou,bolonskavep.smes,masovekulickysrajskouom.,		\N	5
1681	120g Řízečky z vepřové panenky, steakové hranolky, česnekový dip	120grizeckyzveprovepanenky,steakovehranolky,cesnekovydip	1a, 1b, 3, 7	120g Pork Undercut Schnitzels, french Fries in Steak Seasoning, garlic Dip	6
808	330g Pizza La Vita tomat, paprika, rajčata, cuketa, niva, mozzarella, bazalka	330gpizzalavitatomat,paprika,rajcata,cuketa,niva,mozzarella,bazalka	1a, 1b, 7	330g Pizza La Vita with Tomato Purée, Pepper, Tomatoes, Zucchini, Blue Cheese, Mozzarella and Basil	8
1682	150g Kuřecí prso marinované v jogurtu, šťouchané brambory, trhané saláty	150gkureciprsomarinovanevjogurtu,stouchanebrambory,trhanesalaty	1a, 7, 9	150g Yoghurt Marinated Chicken Breast, mashed Potatoes, shredded Lettuce	2
1683	120g Rozlítaný španělský ptáček, jasmínová rýže	120grozlitanyspanelskyptacek,jasminovaryze	1a, 3, 9, 10	120g Beef Meat with Egg, Bacon and Cucumber, jasmine Rice	2
1684	300g Zeleninový salát s červenou řepou, grenaille bramborami a cuketou sypané sýrem Feta, křupavá bagetka, opečená bageta	300gzeleninovysalatscervenourepou,grenaillebramboramiacuketousypanesyremfeta,krupavabagetka,opecenabageta	1a, 7	300g Vegetable Salad with Beetroot, Grenaille Potatoes and Zucchini Sprinkled with Feta Cheese, Crispy Baguette, toasted Baguette	2
620	2 Sterilovaná hotovka ve skle 0,7l - Masové kuličky, rajská om., Boloňská vepř. směs	2sterilovanahotovkaveskle0,7l-masovekulicky,rajskaom.,bolonskavepr.smes		2 Sterilovaná hotovka ve skle 0,7l - Masové kuličky, rajská om., Boloňská vepř. směs	5
1685	Sterilovaná polévka ve skle 0,7l -Hovězí vývar,Z restovaných paprik	sterilovanapolevkaveskle0,7l-hovezivyvar,zrestovanychpaprik		Sterilovaná polévka ve skle 0,7l -Hovězí vývar,Z restovaných paprik	5
1686	2 Sterilovaná hotovka ve skle  - Rajská s masovými kuličkami	2sterilovanahotovkaveskle-rajskasmasovymikulickami		2 Sterilovaná hotovka ve skle  - Rajská s masovými kuličkami	5
1687	Sterilovaná polévka ve skle  0,7l - Gulášová,Z restovaných paprik,Cibulačka,Hovězí vývar,Brokolicový chowder,Kuřecí,Dýňová,Jemná pepřová omáčka	sterilovanapolevkaveskle0,7l-gulasova,zrestovanychpaprik,cibulacka,hovezivyvar,brokolicovychowder,kureci,dynova,jemnapeprovaomacka		Sterilovaná polévka ve skle  0,7l - Gulášová,Z restovaných paprik,Cibulačka,Hovězí vývar,Brokolicový chowder,Kuřecí,Dýňová,Jemná pepřová omáčka	5
1688	2 Sterilovaná hotovka ve skle  - Kuřecí kari,Steak z vepřové krkovice s pepřovou om.	2sterilovanahotovkaveskle-kurecikari,steakzveprovekrkovicespeprovouom.		2 Sterilovaná hotovka ve skle  - Kuřecí kari,Steak z vepřové krkovice s pepřovou om.	5
1689	3 Sterilovaná hotovka ve skle  - Hovězí guláš,Krůtí ragů,Hovězí pečeně s rajskou om.	3sterilovanahotovkaveskle-hovezigulas,krutiragu,hovezipecenesrajskouom.		3 Sterilovaná hotovka ve skle  - Hovězí guláš,Krůtí ragů,Hovězí pečeně s rajskou om.	5
930	3 Sterilovaná hotovka ve skle  - Znojemské nudličky, Hovězí po burgunsku, Krůtí ragú	3sterilovanahotovkaveskle-znojemskenudlicky,hovezipoburgunsku,krutiragu		\N	5
998	Bramboračka	bramboracka	1a, 9	Potato Soup	9
727	300g Špagety s omáčkou z pečených rajčat, paprik a smetany, sýr gran biraghi	300gspagetysomackouzpecenychrajcat,paprikasmetany,syrgranbiraghi		\N	2
299	130g Pečený filet z tresky s fazolkami na medu a hrubozrnné hořčici, karotkové pyré	130gpecenyfiletztreskysfazolkaminameduahrubozrnnehorcici,karotkovepyre	1a, 4, 5, 6, 7, 9, 10, 11, 12	130g Baked Cod Fillet with Green Beans in Honey and Wholegrain Mustard, carrot Purée	2
1690	300g Šoulet z krup a hrachu s krůtím masem, majoránkou, česnekem a podzimní zeleninou, sterilovaný okurek, bez lepku	300gsouletzkrupahrachuskrutimmasem,majorankou,cesnekemapodzimnizeleninou,sterilovanyokurek,bezlepku	9, 10	300g Traditional Czech Barley and Pea Dish with Turkey, Marjoram, Garlic and Autumn Vegetables, gherkin, gluten Free	2
1691	120g Kuřecí řízek v sezamové strouhance, steakové hranolky, jogurtovo-bylinkový dip	120gkurecirizekvsezamovestrouhance,steakovehranolky,jogurtovo-bylinkovydip	1a, 1b, 3, 7, 11	120g Fried Chicken Schnitzel in Sesame Breadcrumbs, french Fries in Steak Seasoning, herb Yogurt Dip	6
962	430g Pizza KRÁLOVSKÁ tomat, poličan, rajčata, hermelín,mozzarella	430gpizzakralovskatomat,polican,rajcata,hermelin,mozzarella	1a, 1b, 7, 9	430g Pizza ROYAL Tomato Purée, Sausage,Tomatoes, Camembert, Edam Cheese	8
1692	120g Kuřecí plátek se sýrovou omáčkou, bramborové hranolky	120gkureciplateksesyrovouomackou,bramborovehranolky	1a, 7, 9	120g Chicken Slice with Cheese Sauce, potato French Fries	6
1693	120g Kuřecí kung-pao, jasmínová rýže	120gkurecikung-pao,jasminovaryze	1, 3, 5, 6, 7, 9, 10, 11	120g Spicy Roasted Chicken with Soya Sauce and Peanuts, jasmine Rice	2
1694	300g Šoulet z krup a hrachu s krůtím masem, majoránkou, česnekem a podzimní zeleninou, sterilovaný okurek	300gsouletzkrupahrachuskrutimmasem,majorankou,cesnekemapodzimnizeleninou,sterilovanyokurek	9, 10	300g Traditional Czech Barley and Pea Dish with Turkey, Marjoram, Garlic and Autumn Vegetables, gherkin	2
1695	150g Kuřecí medailonky se smetanovou omáčkou z pečeného česneku a žampionů, smažené krokety	150gkurecimedailonkysesmetanovouomackouzpecenehocesnekuazampionu,smazenekrokety	1a, 7, 9	150g Kuřecí medailonky se smetanovou omáčkou z pečeného česneku a žampionů, fried Croquettes	2
1696	300g Těstovinový salát s pečenou zeleninou a sušenými rajčaty, filetovaná vepřová panenka	300gtestovinovysalatspecenouzeleninouasusenymirajcaty,filetovanaveprovapanenka	1a, 3, 7, 9, 10	300g Pasta Salad with Roasted Vegetables and Dried Tomatoes, sliced Pork Loin	2
1697	Sterilovaná polévka ve skle 0,7l - Hovězí vývar, Rajská z restovaných paprik	sterilovanapolevkaveskle0,7l-hovezivyvar,rajskazrestovanychpaprik		Sterilovaná polévka ve skle 0,7l - Hovězí vývar, Rajská z restovaných paprik	5
1698	2 Sterilovaná hotovka ve skle  - Rajská omáčka s kuličkami, Krkovice s pepřovou omáčkou	2sterilovanahotovkaveskle-rajskaomackaskulickami,krkovicespeprovouomackou		2 Sterilovaná hotovka ve skle  - Rajská omáčka s kuličkami, Krkovice s pepřovou omáčkou	5
1699	3 Sterilovaná hotovka ve skle 0,7l - Hov.maso, rajská omáčka, Krůtí ragu se smet.a zelen., Hovězí po burgunsku	3sterilovanahotovkaveskle0,7l-hov.maso,rajskaomacka,krutiragusesmet.azelen.,hovezipoburgunsku		3 Sterilovaná hotovka ve skle 0,7l - Hov.maso, rajská omáčka, Krůtí ragu se smet.a zelen., Hovězí po burgunsku	5
1700	Sterilovaná polévka ve skle 0,7l - Fazolová,Dýňová,Brokolicová,Z restovaných paprik	sterilovanapolevkaveskle0,7l-fazolova,dynova,brokolicova,zrestovanychpaprik		Sterilovaná polévka ve skle 0,7l - Fazolová,Dýňová,Brokolicová,Z restovaných paprik	5
1701	3 Sterilovaná hotovka ve skle  - Rajská omáčka s hovězí pečení	3sterilovanahotovkaveskle-rajskaomackashovezipeceni		3 Sterilovaná hotovka ve skle  - Rajská omáčka s hovězí pečení	5
1702	300g Šoulet z krup a hrachu s krůtím masem, majoránkou, česnekem a podzimní zeleninou, sterilovaný okure	300gsouletzkrupahrachuskrutimmasem,majorankou,cesnekemapodzimnizeleninou,sterilovanyokure	1a, 1b, 1c, 3, 9, 10	300g Traditional Czech Barley and Pea Dish with Turkey, Marjoram, Garlic and Autumn Vegetables, gherkin, gluten Free	2
1703	150g Chilli con carne z hovězího masa s kukuřicí, rajčaty a fazolemi, jasmínová rýže	150gchilliconcarnezhovezihomasaskukurici,rajcatyafazolemi,jasminovaryze	1a, 3, 7, 9	150g Beef  in Spicy Sauce with Maize, Tomatoes and Beans , jasmine Rice	2
785	300g Zeleninové lasagne se sojovým masem a sýrovou omáčkou	300gzeleninovelasagnesesojovymmasemasyrovouomackou	1a, 1b, 3, 6, 7, 9	300g Lasagne with Vegetables, Soya Meat and Cheese Sauce	2
846	3 Sterilovaná hotovka ve skle  --Hovězí po znojemsku,Hovězí guláš,Vepřové meailonky se steakovou omáčkou,Hovězí stroganoff,Svíčková,Krůtí medailonky s anglickou slaninou,Burgundská	3sterilovanahotovkaveskle--hovezipoznojemsku,hovezigulas,veprovemeailonkysesteakovouomackou,hovezistroganoff,svickova,krutimedailonkysanglickouslaninou,burgundska		\N	5
847	3 Sterilovaná hotovka ve skle  - Hověuí guláš, Medailonky z vepř.panenky se steakovou om., Hov.stroganoff, Kuřecí chilli, Krůtí medail. s anglic. slaninou	3sterilovanahotovkaveskle-hoveuigulas,medailonkyzvepr.panenkysesteakovouom.,hov.stroganoff,kurecichilli,krutimedail.sanglic.slaninou		\N	5
848	3 Sterilovaná hotovka ve skle  - Hovězé po burgunsku, Krůtí ragú	3sterilovanahotovkaveskle-hovezepoburgunsku,krutiragu		\N	5
849	3 Sterilovaná hotovka ve skle  - Hovězí boloňská směs,Krůtí ragů,Hovězí po burgundsku,Vepřová panenka se svíčkovou omáčkou	3sterilovanahotovkaveskle-hovezibolonskasmes,krutiragu,hovezipoburgundsku,veprovapanenkasesvickovouomackou		\N	5
850	3 Sterilovaná hotovka ve skle  - Hovězí guláš, Kuřecí chilli, Krůtí mědailony s angl.slaninou, Boloňská hovězí, Hov.po burgundsku, Znojemské nudličky, Svíčková om. s hovězím	3sterilovanahotovkaveskle-hovezigulas,kurecichilli,krutimedailonysangl.slaninou,bolonskahovezi,hov.poburgundsku,znojemskenudlicky,svickovaom.shovezim		\N	5
852	3 Sterilovaná hotovka ve skle  - Hovězí guláš, Kuřecí chilli, Medailonky z vepř.panenky se steak.om., Boloňská hovězí, Hov.po burgundsku, Znojemské nudličky, Svíčková om. s hovězím	3sterilovanahotovkaveskle-hovezigulas,kurecichilli,medailonkyzvepr.panenkysesteak.om.,bolonskahovezi,hov.poburgundsku,znojemskenudlicky,svickovaom.shovezim		\N	5
853	3 Sterilovaná hotovka ve skle  - Hovězí guláš, Medailonky z vepř.panenky se steakovou om., Hov.stroganoff, Kuřecí chilli, Krůtí medail. s anglic. slaninou	3sterilovanahotovkaveskle-hovezigulas,medailonkyzvepr.panenkysesteakovouom.,hov.stroganoff,kurecichilli,krutimedail.sanglic.slaninou		\N	5
854	3  Sterilovaná hotovka ve skle  - Hovězí guláš,Vepřové madailonky s steakovou om.,Hovězí svíčková,Hovězí stroganoff,Chow-Mein z vepřové panenky	3sterilovanahotovkaveskle-hovezigulas,veprovemadailonkyssteakovouom.,hovezisvickova,hovezistroganoff,chow-meinzveprovepanenky		\N	5
855	3 Sterilovaná hotovka ve skle  - Hovězí guláš,Vepřové medailonky se steakovou om.,Hovězí svíčková,Hovězí stroganoff,Chow-Mein z vepřové panenky	3sterilovanahotovkaveskle-hovezigulas,veprovemedailonkysesteakovouom.,hovezisvickova,hovezistroganoff,chow-meinzveprovepanenky		\N	5
857	3 Sterilovaná hotovka ve skle  -Hovězí nudličky po znojemsku,Hovězí guláš,Chilli concarne s kuřecím masem,Medailonky z vepřové panenky se steakovou omáčkou,Krůtí medailonky	3sterilovanahotovkaveskle-hovezinudlickypoznojemsku,hovezigulas,chilliconcarneskurecimmasem,medailonkyzveprovepanenkysesteakovouomackou,krutimedailonky		\N	5
858	3 Sterilovaná hotovka ve skle  - Hovězí  nudličky po znojemsku,Hovězí guláš,Hovězí pečeně s rajskou omáčkou,Hovězí stroganoff,Krůtí medailonky,Hovězí po burgundsku	3sterilovanahotovkaveskle-hovezinudlickypoznojemsku,hovezigulas,hovezipecenesrajskouomackou,hovezistroganoff,krutimedailonky,hovezipoburgundsku		\N	5
844	3 Sterilovaná hotovka ve skle  -	3sterilovanahotovkaveskle-		3 Sterilovaná hotovka ve skle  -	5
1704	120g Hamburger s trhaným vepřovým masem a čedarem, steakové hranolky, pepřový dip	120ghamburgerstrhanymveprovymmasemacedarem,steakovehranolky,peprovydip	1a, 1b, 7, 9, 10, 12	120g Hamburger with Pulled Pork and Cheddar Cheese, french Fries in Steak Seasoning, peppercorn Dip	6
764	300g Veganské burito s grilovanou zeleninou, špenátem a rýžovým salátem	300gveganskeburitosgrilovanouzeleninou,spenatemaryzovymsalatem	1a, 1b, 9, 10	300g Vegan Burrito with Grilled Vegetables, Spinach and Rice Salad	6
1705	460g Pizza CAPRICIOSA tomat, šunka,anglická slanina, žampióny, kapie, č.olivy, mozzarella	460gpizzacapriciosatomat,sunka,anglickaslanina,zampiony,kapie,c.olivy,mozzarella	1a, 1b, 7	460g Pizza CAPRICIOSA Tomato Purée,Ham,Champignons,Sweet Capsicum,Black Olives,Mozzarella,Edam Cheese	8
1706	250g Pečená kuřecí křídla, coleslaw s červenou řepou a mrkví, bramborové hranolky	250gpecenakurecikridla,coleslawscervenourepouamrkvi,bramborovehranolky		250g Roasted Chicken Wings, Coleslaw with Beetroot and Carrots, potato French Fries	6
859	3 Sterilovaná hotovka ve skle  -Hovězí nudličky po znojemsku,Hovězí guláš,Hovězí pečeně s rajskou omáčkou,Vepřové medailonky se steakovou omáčkou,Hovězí stroganoff,Krůtí medailonky,Vepřová panenka se svíčkovou	3sterilovanahotovkaveskle-hovezinudlickypoznojemsku,hovezigulas,hovezipecenesrajskouomackou,veprovemedailonkysesteakovouomackou,hovezistroganoff,krutimedailonky,veprovapanenkasesvickovou		\N	5
860	3 Sterilovaná hotovka ve skle  - Hovězí nudličky po znojemsku,Hovězí guláš,Hovězí pečeně s rajskou omáčkou,Vepřové medailonky se steakovou omáčkou,Hovězí stroganoff,Krůtí medailonky,Vepřová panenka se svíčkovou,Hovězí po burgundsku	3sterilovanahotovkaveskle-hovezinudlickypoznojemsku,hovezigulas,hovezipecenesrajskouomackou,veprovemedailonkysesteakovouomackou,hovezistroganoff,krutimedailonky,veprovapanenkasesvickovou,hovezipoburgundsku		\N	5
861	3 Sterilovaná hotovka ve skle  - Hovězí nudličky po znojemsku,Hovězí guláš,Hovězí pečeně s rajskou omáčkou,Vepřové medailonky se steakovou omáčkou,Hovězí stroganoff,Krůzí medailonky,Vepřová panenka se svíčkovou,Burgundská	3sterilovanahotovkaveskle-hovezinudlickypoznojemsku,hovezigulas,hovezipecenesrajskouomackou,veprovemedailonkysesteakovouomackou,hovezistroganoff,kruzimedailonky,veprovapanenkasesvickovou,burgundska		\N	5
862	3 Sterilovaná hotovka ve skle  - Hovězí nudličky po znojemsku,Hovězí guláš,Hovězí pečeně s rajskou omáčkou,Vepřové medailonky se steakovou omáčkou,Hovězí stroganoff,Svíčková,Krůtí medailonky	3sterilovanahotovkaveskle-hovezinudlickypoznojemsku,hovezigulas,hovezipecenesrajskouomackou,veprovemedailonkysesteakovouomackou,hovezistroganoff,svickova,krutimedailonky		\N	5
1141	Sterilovaná polévka ve skle 0,7l - Hovězí vývar, Kyselice, Dýňová	sterilovanapolevkaveskle0,7l-hovezivyvar,kyselice,dynova		\N	5
863	3 Sterilovaná hotovka ve skle  -Hovězí nudličky po znojemsku,Hovězí guláš,Hovězí pečeně s rajskou omáčkou,Vepřové medailonky se steakovou omáčkou,Hovězí stroganoff,Svíčková,Krůtí medailonky,Vepřová panenka se svíčkovou,Hovězí po burgundsku	3sterilovanahotovkaveskle-hovezinudlickypoznojemsku,hovezigulas,hovezipecenesrajskouomackou,veprovemedailonkysesteakovouomackou,hovezistroganoff,svickova,krutimedailonky,veprovapanenkasesvickovou,hovezipoburgundsku		\N	5
864	3 Sterilovaná hotovka ve skle  -Hovězí nudličky po znojemsku,Hovězí guláš,Hovězí stroganoff	3sterilovanahotovkaveskle-hovezinudlickypoznojemsku,hovezigulas,hovezistroganoff		\N	5
914	3 Sterilovaná hotovka ve skle  - Vepřové medailonky se steakovou omáčkou,Krůtí medailonky,Svíčková	3sterilovanahotovkaveskle-veprovemedailonkysesteakovouomackou,krutimedailonky,svickova		\N	5
865	3 Sterilovaná hotovka ve skle  -Hovězí nudličky po znojemsku,Vepřové medailonky se steakovou omáčkou,Vepřová panenka se svíčkovou,Hovězí po burgundsku,Hovězí guláš,Hovězí pečeně s rajskou omáčkou,Hovězí stroganoff,Krůtí meailonky	3sterilovanahotovkaveskle-hovezinudlickypoznojemsku,veprovemedailonkysesteakovouomackou,veprovapanenkasesvickovou,hovezipoburgundsku,hovezigulas,hovezipecenesrajskouomackou,hovezistroganoff,krutimeailonky		\N	5
866	3  Sterilovaná hotovka ve skle  -  Hovězí po burgundsku,Krůtí ragú,Hovězí guláš,Vepřové madailonky s steakovou om.,Hovězí svíčková,Hovězí stroganoff,Chow-Mein z vepřové panenky,Hovězí pečeně s koprovou om.	3sterilovanahotovkaveskle-hovezipoburgundsku,krutiragu,hovezigulas,veprovemadailonkyssteakovouom.,hovezisvickova,hovezistroganoff,chow-meinzveprovepanenky,hovezipeceneskoprovouom.		\N	5
867	3 Sterilovaná hotovka ve skle  -Hovězí po burgundsku,Krůtí ragů,Hovězí svíčková	3sterilovanahotovkaveskle-hovezipoburgundsku,krutiragu,hovezisvickova		\N	5
868	3  Sterilovaná hotovka ve skle  -  Hovězí po burgundsku,Krůtí ragú,Svíčková s vepřovou panenkou,Hovězí guláš,Vepřové madailonky s steakovou om.	3sterilovanahotovkaveskle-hovezipoburgundsku,krutiragu,svickovasveprovoupanenkou,hovezigulas,veprovemadailonkyssteakovouom.		\N	5
869	3  Sterilovaná hotovka ve skle  -  Hovězí po burgundsku,Krůtí ragú,Svíčková s vepřovou panenkou,Hovězí guláš,Vepřové madailonky s steakovou om.,Znojemské hovězí nudličky	3sterilovanahotovkaveskle-hovezipoburgundsku,krutiragu,svickovasveprovoupanenkou,hovezigulas,veprovemadailonkyssteakovouom.,znojemskehovezinudlicky		\N	5
870	3  Sterilovaná hotovka ve skle  -  Hovězí po burgundsku,Krůtí ragú,Svíčková s vepřovou panenkou,Hovězí guláš,Vepřové madailonky s steakovou om.,Znojemské hovězí nudličky,Hovězí svíčková	3sterilovanahotovkaveskle-hovezipoburgundsku,krutiragu,svickovasveprovoupanenkou,hovezigulas,veprovemadailonkyssteakovouom.,znojemskehovezinudlicky,hovezisvickova		\N	5
871	3  Sterilovaná hotovka ve skle  -  Hovězí po burgundsku,Krůtí ragú,Svíčková s vepřovou panenkou,Hovězí guláš,Vepřové madailonky s steakovou om.,Znojemské hovězí nudličky,Hovězí svíčková,Hovězí stroganoff,Chow-Mein z vepřové panenky,Hovězí pečeně s koprovou om.	3sterilovanahotovkaveskle-hovezipoburgundsku,krutiragu,svickovasveprovoupanenkou,hovezigulas,veprovemadailonkyssteakovouom.,znojemskehovezinudlicky,hovezisvickova,hovezistroganoff,chow-meinzveprovepanenky,hovezipeceneskoprovouom.		\N	5
872	3 Sterilovaná hotovka ve skle  -Hovězí po burgundsku,Medailonky z panenky	3sterilovanahotovkaveskle-hovezipoburgundsku,medailonkyzpanenky		\N	5
873	3 Sterilovaná hotovka ve skle  - Hovězí po burgundsku,Vepřové medailonky s jemnou steakovou om.,Krůtí medailonky,Hovězí guláš	3sterilovanahotovkaveskle-hovezipoburgundsku,veprovemedailonkysjemnousteakovouom.,krutimedailonky,hovezigulas		\N	5
874	3 Sterilovaná hotovka ve skle  - Hovězí po burgunsku	3sterilovanahotovkaveskle-hovezipoburgunsku		\N	5
875	3 Sterilovaná hotovka ve skle  - Hovězí po burgunsku, Krůtí ragú	3sterilovanahotovkaveskle-hovezipoburgunsku,krutiragu		\N	5
876	3 Sterilovaná hotovka ve skle  - Hovězí po burgunsku, Znojemské nudličky, Svíčková omáčka, Krůtí rag§	3sterilovanahotovkaveskle-hovezipoburgunsku,znojemskenudlicky,svickovaomacka,krutirag		\N	5
877	3 Sterilovaná hotovka ve skle  - Hovězí po burgunsku, Znojemské nudličky, Svíčková omáčka, Krůtí ragú	3sterilovanahotovkaveskle-hovezipoburgunsku,znojemskenudlicky,svickovaomacka,krutiragu		\N	5
878	3 Sterilovaná hotovka ve skle  -Hovězí po znojemsku,Hovězí guláš,Vepřové meailonky se steakovou omáčkou,Hovězí stroganoff,Svíčková,Krůtí medailonky s anglickou slaninou,Burgundská	3sterilovanahotovkaveskle-hovezipoznojemsku,hovezigulas,veprovemeailonkysesteakovouomackou,hovezistroganoff,svickova,krutimedailonkysanglickouslaninou,burgundska		\N	5
879	3 Sterilovaná hotovka ve skle  - Hovězí stroganof,Znojemské hovězí nudličky,Hovězí po burgundsku,Vepřová panenka se svíčkovou om.,Hovězí pečeně s rajskou om.-,Hovězí guláš	3sterilovanahotovkaveskle-hovezistroganof,znojemskehovezinudlicky,hovezipoburgundsku,veprovapanenkasesvickovouom.,hovezipecenesrajskouom.-,hovezigulas		\N	5
881	3 Sterilovaná hotovka ve skle  - Hovězí stroganof,Znojemské hovězí nudličky,Vepřová panenka se svíčkovou om.,Hovězí pečeně s rajskou om.-,Hovězí guláš,Hovězí svíčková	3sterilovanahotovkaveskle-hovezistroganof,znojemskehovezinudlicky,veprovapanenkasesvickovouom.,hovezipecenesrajskouom.-,hovezigulas,hovezisvickova		\N	5
882	3 Sterilovaná hotovka ve skle  -Hovězí stroganoff,Chow-mein z vepř.panenky,Hovězí pečeně s koprovou omáčkou,Vepřová panenka se svíčkovou,Hovězí po burgundsku,Krůtí ragů,Hovězí boloňská směs,Svíčková	3sterilovanahotovkaveskle-hovezistroganoff,chow-meinzvepr.panenky,hovezipeceneskoprovouomackou,veprovapanenkasesvickovou,hovezipoburgundsku,krutiragu,hovezibolonskasmes,svickova		\N	5
883	3 Sterilovaná hotovka ve skle  -Hovězí stroganoff,Chow-mein z vepř.panenky,Hovězí pečeně s koprovou omáčkou,Vepřová panenka se svíčkovou,Hovězí po burgundsku,Krůtí ragů,Hovězí boloňská směs,Vepřová panenka se steakovou omáčkou,Svíčková	3sterilovanahotovkaveskle-hovezistroganoff,chow-meinzvepr.panenky,hovezipeceneskoprovouomackou,veprovapanenkasesvickovou,hovezipoburgundsku,krutiragu,hovezibolonskasmes,veprovapanenkasesteakovouomackou,svickova		\N	5
885	3 Sterilovaná hotovka ve skle  -Hovězí svíčková,Krůtí ragů,Hovězí po burgundsku	3sterilovanahotovkaveskle-hovezisvickova,krutiragu,hovezipoburgundsku		\N	5
912	3 Sterilovaná hotovka ve skle  -Vepřové medailonky se steakovou omáčkou,Hovězí nudličky po znojemsku	3sterilovanahotovkaveskle-veprovemedailonkysesteakovouomackou,hovezinudlickypoznojemsku		\N	5
887	3 Sterilovaná hotovka ve skle  - Krůtí medailonky,Hovězí stroganof, Vepřové medailonky s jemnou steakovou om.,Znojemské hovězí nudličky,Hovězí po burgundsku,Vepřová panenka se svíčkovou om.	3sterilovanahotovkaveskle-krutimedailonky,hovezistroganof,veprovemedailonkysjemnousteakovouom.,znojemskehovezinudlicky,hovezipoburgundsku,veprovapanenkasesvickovouom.		\N	5
888	3 Sterilovaná hotovka ve skle  - Krůtí medailonky,Hovězí stroganof, Vepřové medailonky s jemnou steakovou om.,Znojemské hovězí nudličky,Hovězí po burgundsku,Vepřová panenka se svíčkovou om.,Hovězí pečeně s rajskou om.	3sterilovanahotovkaveskle-krutimedailonky,hovezistroganof,veprovemedailonkysjemnousteakovouom.,znojemskehovezinudlicky,hovezipoburgundsku,veprovapanenkasesvickovouom.,hovezipecenesrajskouom.		\N	5
889	3 Sterilovaná hotovka ve skle  - Krůtí medailonky,Hovězí stroganof, Vepřové medailonky s jemnou steakovou om.,Znojemské hovězí nudličky,Hovězí po burgundsku,Vepřová panenka se svíčkovou om.,Hovězí pečeně s rajskou om.-	3sterilovanahotovkaveskle-krutimedailonky,hovezistroganof,veprovemedailonkysjemnousteakovouom.,znojemskehovezinudlicky,hovezipoburgundsku,veprovapanenkasesvickovouom.,hovezipecenesrajskouom.-		\N	5
890	3 Sterilovaná hotovka ve skle  - Krůtí medailonky,Hovězí stroganof, Vepřové medailonky s jemnou steakovou om.,Znojemské hovězí nudličky,Hovězí po burgundsku,Vepřová panenka se svíčkovou om.,Hovězí pečeně s rajskou om.-,Hovězí guláš	3sterilovanahotovkaveskle-krutimedailonky,hovezistroganof,veprovemedailonkysjemnousteakovouom.,znojemskehovezinudlicky,hovezipoburgundsku,veprovapanenkasesvickovouom.,hovezipecenesrajskouom.-,hovezigulas		\N	5
892	3  Sterilovaná hotovka ve skle  -  Krůtí ragú,Hovězí guláš,Vepřové madailonky s steakovou om.,Hovězí svíčková,Hovězí stroganoff,Chow-Mein z vepřové panenky,Hovězí pečeně s koprovou om.	3sterilovanahotovkaveskle-krutiragu,hovezigulas,veprovemadailonkyssteakovouom.,hovezisvickova,hovezistroganoff,chow-meinzveprovepanenky,hovezipeceneskoprovouom.		\N	5
893	3 Sterilovaná hotovka ve skle  -Krůtí ragů,Hovězí po burgundsku	3sterilovanahotovkaveskle-krutiragu,hovezipoburgundsku		\N	5
894	3 Sterilovaná hotovka ve skle  - Krůtí ragú, Hovězí po burgunsku, Svíčková omáčka	3sterilovanahotovkaveskle-krutiragu,hovezipoburgunsku,svickovaomacka		\N	5
895	3 Sterilovaná hotovka ve skle  - Krůtí ragú, Svíčková omáčka, Hovězí po burgunsku, Znojemské nudličky	3sterilovanahotovkaveskle-krutiragu,svickovaomacka,hovezipoburgunsku,znojemskenudlicky		\N	5
896	3 Sterilovaná hotovka ve skle  - Kuřecí medailonky, Medailonky z panenky	3sterilovanahotovkaveskle-kurecimedailonky,medailonkyzpanenky		\N	5
897	3 Sterilovaná hotovka ve skle  -Kuřecí medailonky,Vepřové medailonky	3sterilovanahotovkaveskle-kurecimedailonky,veprovemedailonky		\N	5
898	3 Sterilovaná hotovka ve skle  -Medailonky z panenky,Hovězí guláš	3sterilovanahotovkaveskle-medailonkyzpanenky,hovezigulas		\N	5
899	3 Sterilovaná hotovka ve skle  - Medailonky z panenky, Kuřecí medailonky	3sterilovanahotovkaveskle-medailonkyzpanenky,kurecimedailonky		\N	5
900	3 Sterilovaná hotovka ve skle  - Rajská om. s hovězím masem, Hovězí guláš, Medailonky se steak.omáčkou, Ho	3sterilovanahotovkaveskle-rajskaom.shovezimmasem,hovezigulas,medailonkysesteak.omackou,ho		\N	5
901	3 Sterilovaná hotovka ve skle  - Rajská om. s hovězím masem, Hovězí guláš, Medailonky se steak.omáčkou, Hovězí stroganoff, Svíčková om.s vepřovou panenkou, Boloňská směs, Hovězí svíčková	3sterilovanahotovkaveskle-rajskaom.shovezimmasem,hovezigulas,medailonkysesteak.omackou,hovezistroganoff,svickovaom.sveprovoupanenkou,bolonskasmes,hovezisvickova		\N	5
902	3 Sterilovaná hotovka ve skle  - Rajská om. s hovězím masem, Hovězí guláš, Medailonky se steak.omáčkou, Krůtí medailonky, Boloňská směs,	3sterilovanahotovkaveskle-rajskaom.shovezimmasem,hovezigulas,medailonkysesteak.omackou,krutimedailonky,bolonskasmes,		\N	5
903	3 Sterilovaná hotovka ve skle  - Rajská om.s kuličkami, Hovězí guláš, Medailonky se steak.om., Svíčková s vepř.medailonky, Kuřecí chilli, Kuřecí s om.z lišek a žampionů, Krůtí medailonky s angl.slaninou	3sterilovanahotovkaveskle-rajskaom.skulickami,hovezigulas,medailonkysesteak.om.,svickovasvepr.medailonky,kurecichilli,kurecisom.zlisekazampionu,krutimedailonkysangl.slaninou		\N	5
904	3 Sterilovaná hotovka ve skle  -Svíčková,Hovězí nudličky po znojemsku,Vepřové medailonky se steakovou omáčkou,Vepřová panenka se svíčkovou,Hovězí po burgundsku,Hovězí guláš,Hovězí pečeně s rajskou omáčkou,Hovězí stroganoff,Krůtí meailonky	3sterilovanahotovkaveskle-svickova,hovezinudlickypoznojemsku,veprovemedailonkysesteakovouomackou,veprovapanenkasesvickovou,hovezipoburgundsku,hovezigulas,hovezipecenesrajskouomackou,hovezistroganoff,krutimeailonky		\N	5
905	3 Sterilovaná hotovka ve skle  - Svíčková,Krůtí medailonky,Vepřové medailonky se steakovou omáčkou	3sterilovanahotovkaveskle-svickova,krutimedailonky,veprovemedailonkysesteakovouomackou		\N	5
906	3 Sterilovaná hotovka ve skle  - Svíčková,Vepřové medailonky se steakovou omáčkou,Hovězí nudličky po znojemsku	3sterilovanahotovkaveskle-svickova,veprovemedailonkysesteakovouomackou,hovezinudlickypoznojemsku		\N	5
907	3 Sterilovaná hotovka ve skle  -Svíčková,Vepřové medailonky se steakovou omáčkou,Krůtí medailonky,Hovězí nudličky po znojemsku	3sterilovanahotovkaveskle-svickova,veprovemedailonkysesteakovouomackou,krutimedailonky,hovezinudlickypoznojemsku		\N	5
908	3 Sterilovaná hotovka ve skle  -Vepřová panenka se svíčkovou omáčkou,Hovězí po burgundsku,Krůtí ragů,Hovězí boloňská směs	3sterilovanahotovkaveskle-veprovapanenkasesvickovouomackou,hovezipoburgundsku,krutiragu,hovezibolonskasmes		\N	5
909	3 Sterilovaná hotovka ve skle  - Vepřová panenka se svíčkovou omáčkou,Hovězí po burgundsku,Krůtí ragů,Hovězí boloňská směs,Vepřová panenka se steakovou omáčkou,Svíčková	3sterilovanahotovkaveskle-veprovapanenkasesvickovouomackou,hovezipoburgundsku,krutiragu,hovezibolonskasmes,veprovapanenkasesteakovouomackou,svickova		\N	5
910	3 Sterilovaná hotovka ve skle  -Vepřová panenka se svíčkovou omáčkou,Hovězí po burgundsku,Svíčková,Vepřové medailonky se steakovou omáčkou,Krůtí ragů,Hovězí boloňská směs	3sterilovanahotovkaveskle-veprovapanenkasesvickovouomackou,hovezipoburgundsku,svickova,veprovemedailonkysesteakovouomackou,krutiragu,hovezibolonskasmes		\N	5
1002	Česneková krémová s krutony	cesnekovakremovaskrutony	1a, 3, 7, 9	\N	9
913	3 Sterilovaná hotovka ve skle  -Vepřové medailonky se steakovou omáčkou,Hovězí nudličky po znojemsku,Hovězí po burgundsku	3sterilovanahotovkaveskle-veprovemedailonkysesteakovouomackou,hovezinudlickypoznojemsku,hovezipoburgundsku		\N	5
915	3  Sterilovaná hotovka ve skle  -  Vepřové medailonky s jemnou steakovou om., Hovězí guláš,Chilli con - carne z kuřecího masa,Kuřecí medailonky	3sterilovanahotovkaveskle-veprovemedailonkysjemnousteakovouom.,hovezigulas,chillicon-carnezkurecihomasa,kurecimedailonky		\N	5
916	3  Sterilovaná hotovka ve skle  -  Vepřové medailonky s jemnou steakovou om., Hovězí guláš,Chilli con - carne z kuřecího masa,Kuřecí medailonky,Znojemské hovězí nudličky	3sterilovanahotovkaveskle-veprovemedailonkysjemnousteakovouom.,hovezigulas,chillicon-carnezkurecihomasa,kurecimedailonky,znojemskehovezinudlicky		\N	5
917	3  Sterilovaná hotovka ve skle  -  Vepřové medailonky s jemnou steakovou om., Hovězí guláš,Chilli con - carne z kuřecího masa,Vepřová panenka se svíčkovou om.,Kuřecí medailonky	3sterilovanahotovkaveskle-veprovemedailonkysjemnousteakovouom.,hovezigulas,chillicon-carnezkurecihomasa,veprovapanenkasesvickovouom.,kurecimedailonky		\N	5
918	3  Sterilovaná hotovka ve skle  -  Vepřové medailonky s jemnou steakovou om., Hovězí guláš,Chilli con - carne z kuřecího masa,Znojemské hovězí nudličky	3sterilovanahotovkaveskle-veprovemedailonkysjemnousteakovouom.,hovezigulas,chillicon-carnezkurecihomasa,znojemskehovezinudlicky		\N	5
920	3 Sterilovaná hotovka ve skle  -  Vepřové medailonky s jemnou steakovou om.,Krůtí medailonky,Hovězí guláš,Chilli con - carne z kuřecího masa	3sterilovanahotovkaveskle-veprovemedailonkysjemnousteakovouom.,krutimedailonky,hovezigulas,chillicon-carnezkurecihomasa		\N	5
921	3  Sterilovaná hotovka ve skle  -  Vepřové medailonky s jemnou steakovou om.,Krůtí medailonky,Hovězí guláš,Chilli con - carne z kuřecího masa,Vepřová panenka se svíčkovou om.,Hovězí svíčková	3sterilovanahotovkaveskle-veprovemedailonkysjemnousteakovouom.,krutimedailonky,hovezigulas,chillicon-carnezkurecihomasa,veprovapanenkasesvickovouom.,hovezisvickova		\N	5
922	3 Sterilovaná hotovka ve skle  -Vepřové medailonky z panenky	3sterilovanahotovkaveskle-veprovemedailonkyzpanenky		\N	5
923	3  Sterilovaná hotovka ve skle  -  Znojemské hovězí nudličky,Hovězí po burgundsku,Krůtí ragú,Hovězí boloňská směs,Svíčková s vepřovou panenkou	3sterilovanahotovkaveskle-znojemskehovezinudlicky,hovezipoburgundsku,krutiragu,hovezibolonskasmes,svickovasveprovoupanenkou		\N	5
924	3  Sterilovaná hotovka ve skle  -  Znojemské hovězí nudličky,Hovězí po burgundsku,Krůtí ragú,Hovězí boloňská směs,Svíčková s vepřovou panenkou,Hovězí guláš	3sterilovanahotovkaveskle-znojemskehovezinudlicky,hovezipoburgundsku,krutiragu,hovezibolonskasmes,svickovasveprovoupanenkou,hovezigulas		\N	5
925	3  Sterilovaná hotovka ve skle  -  Znojemské hovězí nudličky,Hovězí po burgundsku,Krůtí ragú,Svíčková s vepřovou panenkou,Hovězí guláš,Vepřové madailonky s steakovou om.	3sterilovanahotovkaveskle-znojemskehovezinudlicky,hovezipoburgundsku,krutiragu,svickovasveprovoupanenkou,hovezigulas,veprovemadailonkyssteakovouom.		\N	5
926	3 Sterilovaná hotovka ve skle  -Znojemské hovězí nudličky,Hovězí po burgundsku,Vepřové medailonky s jemnou steakovou om.,Krůtí medailonky	3sterilovanahotovkaveskle-znojemskehovezinudlicky,hovezipoburgundsku,veprovemedailonkysjemnousteakovouom.,krutimedailonky		\N	5
927	3 Sterilovaná hotovka ve skle  -Znojemské hovězí nudličky,Hovězí svíčková,Hovězí po burgundsku,Vepřové medailonky s jemnou steakovou om.	3sterilovanahotovkaveskle-znojemskehovezinudlicky,hovezisvickova,hovezipoburgundsku,veprovemedailonkysjemnousteakovouom.		\N	5
928	3 Sterilovaná hotovka ve skle  -Znojemské hovězí nudličky,Hovězí svíčková,Hovězí po burgundsku,Vepřové medailonky s jemnou steakovou om.,Krůtí medailonky	3sterilovanahotovkaveskle-znojemskehovezinudlicky,hovezisvickova,hovezipoburgundsku,veprovemedailonkysjemnousteakovouom.,krutimedailonky		\N	5
929	3 Sterilovaná hotovka ve skle  - Znojemské nudličky, Hovězí guláš, Medailonky se steak.omáčkou, Hovězí stroanoff	3sterilovanahotovkaveskle-znojemskenudlicky,hovezigulas,medailonkysesteak.omackou,hovezistroanoff		\N	5
931	3 Sterilovaná hotovka ve skle  - Znojemské nudličky, Svíčková na smetaně, Rajská om. s hovězím masem, Hovězí guláš, Medailonky se steak.omáčkou, Hovězí stroanoff	3sterilovanahotovkaveskle-znojemskenudlicky,svickovanasmetane,rajskaom.shovezimmasem,hovezigulas,medailonkysesteak.omackou,hovezistroanoff		\N	5
932	3 Sterilovaná hotovka ve skle 0,7l - Boloňská hov.směs, Znojemské hov.nudličky s okur.a slan.	3sterilovanahotovkaveskle0,7l-bolonskahov.smes,znojemskehov.nudlickysokur.aslan.		\N	5
933	3 Sterilovaná hotovka ve skle 0,7l - Chow-meinz v.panenky se zel.,Hov.pečeně, koprová om., Med.z v.panenky se steak.om., Hov.stroganoff, Boloňská hov.směs, Znojemské hov.nudličky s okur.a slan.	3sterilovanahotovkaveskle0,7l-chow-meinzv.panenkysezel.,hov.pecene,koprovaom.,med.zv.panenkysesteak.om.,hov.stroganoff,bolonskahov.smes,znojemskehov.nudlickysokur.aslan.		\N	5
934	3 Sterilovaná hotovka ve skle 0,7l - Hov. po burgunsku s č.vínem,sl.a cibulkami, Znojemské hov.nudličky s okur.a slan.	3sterilovanahotovkaveskle0,7l-hov.poburgunskusc.vinem,sl.acibulkami,znojemskehov.nudlickysokur.aslan.		\N	5
935	3 Sterilovaná hotovka ve skle 0,7l - Hovězí guláš, Boloňská hov.směs, Svíčková s hov.masem, Krůtí ragů se smet.a zel., Hov. po burgunsku s č.vínem,sl.a cibulkami, Znojemské hov.nudličky s okur.a slan.	3sterilovanahotovkaveskle0,7l-hovezigulas,bolonskahov.smes,svickovashov.masem,krutiragusesmet.azel.,hov.poburgunskusc.vinem,sl.acibulkami,znojemskehov.nudlickysokur.aslan.		\N	5
936	3 Sterilovaná hotovka ve skle 0,7l - Hovězí guláš, Hov.maso, svíčková om., Krůtí medailonky, Vepř. chow-mein se zel.,Hov.maso, koprová om., Hov.stroganoff	3sterilovanahotovkaveskle0,7l-hovezigulas,hov.maso,svickovaom.,krutimedailonky,vepr.chow-meinsezel.,hov.maso,koprovaom.,hov.stroganoff		\N	5
938	3 Sterilovaná hotovka ve skle 0,7l - Hovězí guláš, Med. z vepř. panenky, steaková om., Krůtí medail. s ang.slan.,porkem a suš. rajčaty	3sterilovanahotovkaveskle0,7l-hovezigulas,med.zvepr.panenky,steakovaom.,krutimedail.sang.slan.,porkemasus.rajcaty		\N	5
939	3 Sterilovaná hotovka ve skle 0,7l - Hovězí guláš, Medail. z v.panenky se steak.om.	3sterilovanahotovkaveskle0,7l-hovezigulas,medail.zv.panenkysesteak.om.		\N	5
1011	Dýňový krém s kari a zázvorem	dynovykremskariazazvorem	1a, 7	\N	9
940	3 Sterilovaná hotovka ve skle 0,7l - Hovězí guláš, Svíčková omáčka, hov. maso, Rajská om. hovězí maso, Krůtí ragů se smet.a zel., Hov. znojemské nudličky, Vepř. panenka svíčková om., Med. z vepř. panenky, steaková om. Svíčková om. hov.maso,	3sterilovanahotovkaveskle0,7l-hovezigulas,svickovaomacka,hov.maso,rajskaom.hovezimaso,krutiragusesmet.azel.,hov.znojemskenudlicky,vepr.panenkasvickovaom.,med.zvepr.panenky,steakovaom.svickovaom.hov.maso,		\N	5
941	3 Sterilovaná hotovka ve skle 0,7l - Hovězí po burgunsku, Špik.hov.maso, svíčková om., Hovězí guláš, Hov. znojemské nudličky, Vepř. panenka svíčková om., Med. z vepř. panenky, steaková om.	3sterilovanahotovkaveskle0,7l-hovezipoburgunsku,spik.hov.maso,svickovaom.,hovezigulas,hov.znojemskenudlicky,vepr.panenkasvickovaom.,med.zvepr.panenky,steakovaom.		\N	5
942	3 Sterilovaná hotovka ve skle 0,7l - Rajská om. hovězí maso, Krůtí ragů se smet.a zel., Hov. znojemské nudličky, Hov. stroganov, Krůtí med. s ang.sl..pórkem a s.rajčaty	3sterilovanahotovkaveskle0,7l-rajskaom.hovezimaso,krutiragusesmet.azel.,hov.znojemskenudlicky,hov.stroganov,krutimed.sang.sl..porkemas.rajcaty		\N	5
943	3 Sterilovaná hotovka ve skle 0,7l - Rajská om. hovězí maso, Krůtí ragů se smet.a zel., Hov. znojemské nudličky, Hov. stroganov, Krůtí med. s ang.sl..pórkem a s.rajčaty-	3sterilovanahotovkaveskle0,7l-rajskaom.hovezimaso,krutiragusesmet.azel.,hov.znojemskenudlicky,hov.stroganov,krutimed.sang.sl..porkemas.rajcaty-		\N	5
944	3 Sterilovaná hotovka ve skle 0,7l - Rajská om. hovězí maso, Krůtí ragů se smet.a zel., Hov. znojemské nudličky, Vepř. panenka svíčková om., Med. z vepř. panenky, steaková om.	3sterilovanahotovkaveskle0,7l-rajskaom.hovezimaso,krutiragusesmet.azel.,hov.znojemskenudlicky,vepr.panenkasvickovaom.,med.zvepr.panenky,steakovaom.		\N	5
945	3 Sterilovaná hotovka ve skle 0,7l - Rajská om. hovězí maso, Svíčková om, vepř. panenka, Krůtí ragů se smet.a zel., Hov. po burgunsku, Hov. znojemské nudličky, Hov. stroganov, Krůtí med. s ang.sl..pórkem a s.rajčaty	3sterilovanahotovkaveskle0,7l-rajskaom.hovezimaso,svickovaom,vepr.panenka,krutiragusesmet.azel.,hov.poburgunsku,hov.znojemskenudlicky,hov.stroganov,krutimed.sang.sl..porkemas.rajcaty		\N	5
946	3 Sterilovaná hotovka ve skle 0,7l - Rajská om. hovězí maso, Svíčková om, vepř. panenka, Krůtí ragů se smet.a zel., Hov. znojemské nudličky, Hov. stroganov, Krůtí med. s ang.sl..pórkem a s.rajčaty	3sterilovanahotovkaveskle0,7l-rajskaom.hovezimaso,svickovaom,vepr.panenka,krutiragusesmet.azel.,hov.znojemskenudlicky,hov.stroganov,krutimed.sang.sl..porkemas.rajcaty		\N	5
947	3 Sterilovaná hotovka ve skle 0,7l - Špik.hov.maso, svíčková om., Hovězí guláš, Krůtí ragů se smet.a zel., Hov. znojemské nudličky, Vepř. panenka svíčková om., Med. z vepř. panenky, steaková om.-	3sterilovanahotovkaveskle0,7l-spik.hov.maso,svickovaom.,hovezigulas,krutiragusesmet.azel.,hov.znojemskenudlicky,vepr.panenkasvickovaom.,med.zvepr.panenky,steakovaom.-		\N	5
948	3 Sterilovaná hotovka ve skle 0,7l - Špik.hov. maso, svíčková omáčka, Hovězí guláš, Krůtí ragů se smet.a zel., Hov. znojemské nudličky, Vepř. panenka svíčková om., Med. z vepř. panenky, steaková om.	3sterilovanahotovkaveskle0,7l-spik.hov.maso,svickovaomacka,hovezigulas,krutiragusesmet.azel.,hov.znojemskenudlicky,vepr.panenkasvickovaom.,med.zvepr.panenky,steakovaom.		\N	5
949	3 Sterilovaná hotovka ve skle 0,7l - Špik. kov. maso, svíčková omáčka, Hovězí guláš, Krůtí ragů se smet.a zel., Hov. znojemské nudličky, Vepř. panenka svíčková om., Med. z vepř. panenky, steaková om.	3sterilovanahotovkaveskle0,7l-spik.kov.maso,svickovaomacka,hovezigulas,krutiragusesmet.azel.,hov.znojemskenudlicky,vepr.panenkasvickovaom.,med.zvepr.panenky,steakovaom.		\N	5
950	3 Sterilovaná hotovka ve skle 0,7l - Svíčková om, vepř. panenka, Krůtí ragů se smet.a zel., Hov. po burgunsku, Hov. znojemská, Hov. stroganov, Krůtí med. s ang.sl..pórkem a s.rajčaty	3sterilovanahotovkaveskle0,7l-svickovaom,vepr.panenka,krutiragusesmet.azel.,hov.poburgunsku,hov.znojemska,hov.stroganov,krutimed.sang.sl..porkemas.rajcaty		\N	5
951	3 Sterilovaná hotovka ve skle 0,7l - Vepř. chow-mein se zel.,Hov.maso, koprová om., Hov.stroganoff	3sterilovanahotovkaveskle0,7l-vepr.chow-meinsezel.,hov.maso,koprovaom.,hov.stroganoff		\N	5
1707	240g Pečené kuřecí stehno na karamelizované zelenině, batátové pyré	240gpecenekurecistehnonakaramelizovanezelenine,batatovepyre	3, 5, 7, 9, 10, 11	240g Roasted Chicken Leg on Caramelised Vegetables, sweet Potato Purée	2
952	3 Sterilovaná hotovka ve skle 0,7l - Vepř. chow-mein se zel.,Hov.maso, koprová om., Med.z v.panenky se steak.om., Hov.stroganoff, Boloňská hov.směs, Znojemské hov.nudličky s okur.a slan.	3sterilovanahotovkaveskle0,7l-vepr.chow-meinsezel.,hov.maso,koprovaom.,med.zv.panenkysesteak.om.,hov.stroganoff,bolonskahov.smes,znojemskehov.nudlickysokur.aslan.		\N	5
954	3 Sterilovaná hotovka ve skle 0,7l - Znojemské hov. nudličky s okur.a slan., Medail. z v.panenky se steak.om.	3sterilovanahotovkaveskle0,7l-znojemskehov.nudlickysokur.aslan.,medail.zv.panenkysesteak.om.		\N	5
955	3 Sterilovaná hotovka ve skle   Hovězí guláš, Kuřecí chilli, Medailonky z vepř.panenky se steak.om. , Boloňská hovězí, Hov.po burgundsku, Znojemské nudličky, Svíčková om.	3sterilovanahotovkavesklehovezigulas,kurecichilli,medailonkyzvepr.panenkysesteak.om.,bolonskahovezi,hov.poburgundsku,znojemskenudlicky,svickovaom.		\N	5
956	3 Sterilovaná hotovka ve skle Hovězí po burgundsku,Znojemské nudličky,Boloňská hovězí,Svíčková,Krůtí ragů	3sterilovanahotovkavesklehovezipoburgundsku,znojemskenudlicky,bolonskahovezi,svickova,krutiragu		\N	5
1708	300g Těstovinový salát s vepřovými nudličkami a zeleninou, jogurtový dip	300gtestovinovysalatsveprovyminudlickamiazeleninou,jogurtovydip	1a, 3, 5, 7, 9, 10, 11	300g Pasta Salad with Pork Noodles and Vegetables, yogurt Dip	6
1709	Italská minestrone	italskaminestrone	1a, 3, 9	Minestrone Soup	9
1710	150g Vepřová pečeně s cibulovým chutney a čedarem, pečené brambory	150gveprovapecenescibulovymchutneyacedarem,pecenebrambory	1a, 7, 9, 12	150g Pork Roast with Onion Chutney and Cheddar Cheese, scalloped Potatoes	2
1711	Sterilovaná polévka ve skle  0,7l - Gulášová,Z restovaných paprik,Cibulačka,Brokolicový chowder,Kuřecí,Dýňová,Jemná pepřová omáčka	sterilovanapolevkaveskle0,7l-gulasova,zrestovanychpaprik,cibulacka,brokolicovychowder,kureci,dynova,jemnapeprovaomacka		Sterilovaná polévka ve skle  0,7l - Gulášová,Z restovaných paprik,Cibulačka,Brokolicový chowder,Kuřecí,Dýňová,Jemná pepřová omáčka	5
1712	3 Sterilovaná hotovka ve skle  - Hovězí pečeně s rajskou omáčkou	3sterilovanahotovkaveskle-hovezipecenesrajskouomackou		3 Sterilovaná hotovka ve skle  - Hovězí pečeně s rajskou omáčkou	5
1713	2 Sterilovaná hotovka ve skle  - Krkovice + steaková omáčka, Rajská omáčka	2sterilovanahotovkaveskle-krkovice+steakovaomacka,rajskaomacka		2 Sterilovaná hotovka ve skle  - Krkovice + steaková omáčka, Rajská omáčka	5
1054	Okurkový,BIO Salát zelný s mrkví	okurkovy,biosalatzelnysmrkvi		\N	3
1055	Okurkový,BIO Zelný salát s mrkví	okurkovy,biozelnysalatsmrkvi		\N	3
1056	Okurkový , rajčatový	okurkovy,rajcatovy		\N	3
1057	Párek v rohlíku,BIO jogurt s ovocem	parekvrohliku,biojogurtsovocem		\N	4
1142	Sterilovaná polévka ve skle 0,7l -Hovězí vývar,Valašská kyselice,Dýňová	sterilovanapolevkaveskle0,7l-hovezivyvar,valasskakyselice,dynova		\N	5
1087	Státní svátek - nevaří se	statnisvatek-nevarise		Public Holiday - No Meals Provided	2
593	2 Sterilovaná hotovka ve skle  - Vepřová boloňská směs	2sterilovanahotovkaveskle-veprovabolonskasmes		2 Sterilovaná hotovka ve skle  - Vepřová boloňská směs	5
1714	2 Sterilovaná hotovka ve skle 0,7l - Boloňská vepř. směs, Masové kuličky rajská om., Vepř.krkovice s pepř.omáčkou	2sterilovanahotovkaveskle0,7l-bolonskavepr.smes,masovekulickyrajskaom.,vepr.krkovicespepr.omackou		2 Sterilovaná hotovka ve skle 0,7l - Boloňská vepř. směs, Masové kuličky rajská om., Vepř.krkovice s pepř.omáčkou	5
1715	2 Sterilovaná hotovka ve skle  - Rajská  s kuličkami, Vrabec se zelím, Vepř.krkovice s pepř.om., Segedínský guláš, Boloňská směs	2sterilovanahotovkaveskle-rajskaskulickami,vrabecsezelim,vepr.krkovicespepr.om.,segedinskygulas,bolonskasmes		2 Sterilovaná hotovka ve skle  - Rajská  s kuličkami, Vrabec se zelím, Vepř.krkovice s pepř.om., Segedínský guláš, Boloňská směs	5
1053	Okurkový	okurkovy		Okurkový	3
1716	3 Sterilovaná hotovka ve skle  - Chow -main z vepř.panenky, Rajská s hov.masem, Svíčková om., Znojemské nudličky, Chilli con carne, Kuř.medailonky s liškovou omáčkou	3sterilovanahotovkaveskle-chow-mainzvepr.panenky,rajskashov.masem,svickovaom.,znojemskenudlicky,chilliconcarne,kur.medailonkysliskovouomackou		3 Sterilovaná hotovka ve skle  - Chow -main z vepř.panenky, Rajská s hov.masem, Svíčková om., Znojemské nudličky, Chilli con carne, Kuř.medailonky s liškovou omáčkou	5
1717	300g Bramborové halušky s brynzou, cibulkou a opečenou anglickou slaninou	300gbramborovehaluskysbrynzou,cibulkouaopecenouanglickouslaninou	1a, 3, 7	300g Bramborové halušky s brynzou, cibulkou a opečenou anglickou slaninou	2
1080	Špenátová krémová	spenatovakremova	7, 9	Creamy Spinach Soup	9
1083	SSterilovaná polévka ve skle  0,7l -  Masový vývar,Kukuřiční chowder,Gulášová,Dýňová,Valašská kyselice,Rajská	ssterilovanapolevkaveskle0,7l-masovyvyvar,kukuricnichowder,gulasova,dynova,valasskakyselice,rajska		\N	5
1084	SSterilovaná polévka ve skle  0,7l -  Masový vývar,Kukuřiční chowder,Gulášová,Dýňová,Valašská kyselice,Rajská,Hovězí vývar	ssterilovanapolevkaveskle0,7l-masovyvyvar,kukuricnichowder,gulasova,dynova,valasskakyselice,rajska,hovezivyvar		\N	5
1085	SSterilovaná polévka ve skle  0,7l - Z restovaných paprik,Brokolicová,Sýrová,Masový vývar,Kukuřiční chowder,Gulášová,Dýňová,Valašská kyselice,Kuřecí vývar	ssterilovanapolevkaveskle0,7l-zrestovanychpaprik,brokolicova,syrova,masovyvyvar,kukuricnichowder,gulasova,dynova,valasskakyselice,kurecivyvar		\N	5
1088	Sterilovaná polévka ve skle 0,7- gulášová,Valašská kyselice	sterilovanapolevkaveskle0,7-gulasova,valasskakyselice		\N	5
1089	Sterilovaná polévka ve skle 0,7- Hovězí vývae,Valašská kyselice,Dýňová	sterilovanapolevkaveskle0,7-hovezivyvae,valasskakyselice,dynova		\N	5
1090	Sterilovaná polévka ve skle 0,7-Rajská s těstovinou,Valašská kyselice	sterilovanapolevkaveskle0,7-rajskastestovinou,valasskakyselice		\N	5
1092	Sterilovaná polévka ve skle 0,7l --Dýňová,Kyselice,Kapustová,Hovězí vývar	sterilovanapolevkaveskle0,7l--dynova,kyselice,kapustova,hovezivyvar		\N	5
1093	Sterilovaná polévka ve skle 0,7l --Gulášová,Z resovaných paprik,Kyselice,Kapustová	sterilovanapolevkaveskle0,7l--gulasova,zresovanychpaprik,kyselice,kapustova		\N	5
1094	Sterilovaná polévka ve skle 0,7l --Kuřecí vývar,Dýňová,Gulášová,Sýrová,Kapustová,Kulajda	sterilovanapolevkaveskle0,7l--kurecivyvar,dynova,gulasova,syrova,kapustova,kulajda		\N	5
1095	Sterilovaná polévka ve skle 0,7l --Masová,Gulášová,Kapustová,Sýrová,Dýňová,Z restovaných paprik,Kuřecí vývar	sterilovanapolevkaveskle0,7l--masova,gulasova,kapustova,syrova,dynova,zrestovanychpaprik,kurecivyvar		\N	5
1097	Sterilovaná polévka ve skle 0,7l - Dýňová,Gulášová,Kyselice,Kapustová,Hovězí vývar,Kulajda	sterilovanapolevkaveskle0,7l-dynova,gulasova,kyselice,kapustova,hovezivyvar,kulajda		\N	5
1098	Sterilovaná polévka ve skle 0,7l - Dýňová,Gulášová,Kyselice,Kapustová,Kulajda,Z restovaných paprik	sterilovanapolevkaveskle0,7l-dynova,gulasova,kyselice,kapustova,kulajda,zrestovanychpaprik		\N	5
1099	Sterilovaná polévka ve skle 0,7l -Dýňová,Gulášová,Sýrová,Kapustová	sterilovanapolevkaveskle0,7l-dynova,gulasova,syrova,kapustova		\N	5
1100	Sterilovaná polévka ve skle 0,7l - Dýňová, Hov. vývar se zel.s masem, Kuř. vývar se zel.a masem, Z rest.paprik s rajč.a smetanou	sterilovanapolevkaveskle0,7l-dynova,hov.vyvarsezel.smasem,kur.vyvarsezel.amasem,zrest.papriksrajc.asmetanou		\N	5
1101	Sterilovaná polévka ve skle 0,7l - Dýňová, Hovězí vývar, Kyselice	sterilovanapolevkaveskle0,7l-dynova,hovezivyvar,kyselice		\N	5
1102	Sterilovaná polévka ve skle 0,7l - Dýňová, Kuř. vývar se zel.a masem, Z rest.paprik s rajč.a smetanou	sterilovanapolevkaveskle0,7l-dynova,kur.vyvarsezel.amasem,zrest.papriksrajc.asmetanou		\N	5
1103	Sterilovaná polévka ve skle 0,7l - Dýňová, Kyselice	sterilovanapolevkaveskle0,7l-dynova,kyselice		\N	5
1104	Sterilovaná polévka ve skle 0,7l - Dýňová, Kyselice, Hovězí vývar	sterilovanapolevkaveskle0,7l-dynova,kyselice,hovezivyvar		\N	5
1105	Sterilovaná polévka ve skle 0,7l -Dýňová,Kyselice,Kapustová,Hovězí vývar	sterilovanapolevkaveskle0,7l-dynova,kyselice,kapustova,hovezivyvar		\N	5
1106	Sterilovaná polévka ve skle 0,7l -Dýňová,Kyselice,Kapustová,Hovězí vývar,Gulášová,Kulajda	sterilovanapolevkaveskle0,7l-dynova,kyselice,kapustova,hovezivyvar,gulasova,kulajda		\N	5
1033	Jemně pálivá čínská polévka	jemnepalivacinskapolevka	1, 3, 9	Spicy Chinese Soup	9
1107	Sterilovaná polévka ve skle 0,7l -Dýňová,Kyselice,Kapustová,Kulajda,Z restovaných paprik	sterilovanapolevkaveskle0,7l-dynova,kyselice,kapustova,kulajda,zrestovanychpaprik		\N	5
1108	Sterilovaná polévka ve skle 0,7l -Dýňová,Kyselice,Kuřecí vývar,Sýrová,Kulajda	sterilovanapolevkaveskle0,7l-dynova,kyselice,kurecivyvar,syrova,kulajda		\N	5
1109	Sterilovaná polévka ve skle 0,7l - Dýňová,Kyselice,Z restovaných paprik	sterilovanapolevkaveskle0,7l-dynova,kyselice,zrestovanychpaprik		\N	5
1110	Sterilovaná polévka ve skle 0,7l -Dýňová,Valašská kyselice	sterilovanapolevkaveskle0,7l-dynova,valasskakyselice		\N	5
1112	Sterilovaná polévka ve skle  0,7l - Gulášová,Dyňová,Bramboračka,Valašská kyselice,Kulajda,Rozbáš	sterilovanapolevkaveskle0,7l-gulasova,dynova,bramboracka,valasskakyselice,kulajda,rozbas		\N	5
1113	Sterilovaná polévka ve skle  0,7l - Gulášová,Dyňová,Bramboračka,Valašská kyselice,Kulajda,Rozbáš,Z restovaných paprik,Jemná pepřová omáčka	sterilovanapolevkaveskle0,7l-gulasova,dynova,bramboracka,valasskakyselice,kulajda,rozbas,zrestovanychpaprik,jemnapeprovaomacka		\N	5
1096	Sterilovaná polévka ve skle 0,7l -Dýňová	sterilovanapolevkaveskle0,7l-dynova		Sterilovaná polévka ve skle 0,7l - Dýňová	5
1718	Slepičí vývar s celestýnskými nudlemi	slepicivyvarscelestynskyminudlemi	1a, 3, 7, 9	Chicken Broth with Pancake Strips	9
1114	Sterilovaná polévka ve skle  0,7l - Gulášová,Dyňová,Bramboračka,Valašská kyselice,Rozbáš,Z restovaných paprik,Jemná pepřová omáčka	sterilovanapolevkaveskle0,7l-gulasova,dynova,bramboracka,valasskakyselice,rozbas,zrestovanychpaprik,jemnapeprovaomacka		\N	5
1115	Sterilovaná polévka ve skle  0,7l - Gulášová,Dýňová,Bramboračka,Valašská kyselice,Rozbaš,Z restovaných paprik,Telecí vývar,Jemná pepřová omáčka	sterilovanapolevkaveskle0,7l-gulasova,dynova,bramboracka,valasskakyselice,rozbas,zrestovanychpaprik,telecivyvar,jemnapeprovaomacka		\N	5
1117	Sterilovaná polévka ve skle  0,7l - Gulášová,Dyňová,Hovězí vývar,Bramboračka,Valašská kyselice	sterilovanapolevkaveskle0,7l-gulasova,dynova,hovezivyvar,bramboracka,valasskakyselice		\N	5
1118	Sterilovaná polévka ve skle  0,7l - Gulášová,Dyňová,Hovězí vývar,Bramboračka,Valašská kyselice,Kulajda	sterilovanapolevkaveskle0,7l-gulasova,dynova,hovezivyvar,bramboracka,valasskakyselice,kulajda		\N	5
1119	Sterilovaná polévka ve skle 0,7l - Gulášová,Dýňová,Kyselice,kuřecí vývar,Z restovaných paprik	sterilovanapolevkaveskle0,7l-gulasova,dynova,kyselice,kurecivyvar,zrestovanychpaprik		\N	5
1120	Sterilovaná polévka ve skle  0,7l - Gulášová,Dýňová,Valašská kyselice,Hovězí vývar	sterilovanapolevkaveskle0,7l-gulasova,dynova,valasskakyselice,hovezivyvar		\N	5
1121	Sterilovaná polévka ve skle  0,7l - Gulášová,Dýňová,Valašská kyselice,Kuřecíí vývar	sterilovanapolevkaveskle0,7l-gulasova,dynova,valasskakyselice,kureciivyvar		\N	5
1122	Sterilovaná polévka ve skle 0,7l - Gulášová, Hovězí vývar, Kyselice	sterilovanapolevkaveskle0,7l-gulasova,hovezivyvar,kyselice		\N	5
1123	Sterilovaná polévka ve skle 0,7l -Gulášová,Hovězí vývar,Valašská kyselice,Dýňová	sterilovanapolevkaveskle0,7l-gulasova,hovezivyvar,valasskakyselice,dynova		\N	5
1124	Sterilovaná polévka ve skle 0,7l - Gulášová, Kyselice, Dýňová, Hovězí vývar	sterilovanapolevkaveskle0,7l-gulasova,kyselice,dynova,hovezivyvar		\N	5
1125	Sterilovaná polévka ve skle 0,7l - Gulášová, Kyselice, Hovězí vývar	sterilovanapolevkaveskle0,7l-gulasova,kyselice,hovezivyvar		\N	5
1126	Sterilovaná polévka ve skle 0,7l - Gulášová,Kyselice,Kuřecí vývar,Z restovaných paprik	sterilovanapolevkaveskle0,7l-gulasova,kyselice,kurecivyvar,zrestovanychpaprik		\N	5
1127	Sterilovaná polévka ve skle 0,7l -Gulášová,Sýrová,Kapustová	sterilovanapolevkaveskle0,7l-gulasova,syrova,kapustova		\N	5
1128	Sterilovaná polévka ve skle 0,7l - Gulášová,Sýrová,Kapustová,Dýňová	sterilovanapolevkaveskle0,7l-gulasova,syrova,kapustova,dynova		\N	5
1129	Sterilovaná polévka ve skle 0,7l -Gulášová,Sýrová,Kulajda	sterilovanapolevkaveskle0,7l-gulasova,syrova,kulajda		\N	5
1130	Sterilovaná polévka ve skle  0,7l - Gulášová,Valašská kyselice,Z restovaných paprik	sterilovanapolevkaveskle0,7l-gulasova,valasskakyselice,zrestovanychpaprik		\N	5
1131	Sterilovaná polévka ve skle 0,7l - Gulášová,Z resovaných paprik,Kyselice,Kapustová	sterilovanapolevkaveskle0,7l-gulasova,zresovanychpaprik,kyselice,kapustova		\N	5
1132	Sterilovaná polévka ve skle 0,7l -Gulášová,Z restovaných paprk	sterilovanapolevkaveskle0,7l-gulasova,zrestovanychpaprk		\N	5
1133	Sterilovaná polévka ve skle 0,7l - Gulášová s v. masem, Rajská s rest. paprikami	sterilovanapolevkaveskle0,7l-gulasovasv.masem,rajskasrest.paprikami		\N	5
1134	Sterilovaná polévka ve skle 0,7l - Gulášová s v. masem, Rajská s rest. paprikami, Kyselice s uz.masem, Rajská s těstovinou, Dýňová se smetanou	sterilovanapolevkaveskle0,7l-gulasovasv.masem,rajskasrest.paprikami,kyselicesuz.masem,rajskastestovinou,dynovasesmetanou		\N	5
1135	Sterilovaná polévka ve skle 0,7l - Gulášová s vepř.masem, Kyselice s uz.masem, Hov.vývar s trh.masem, Dýňová se smet., Bramboračka s houbami Kapustová s klobásou	sterilovanapolevkaveskle0,7l-gulasovasvepr.masem,kyselicesuz.masem,hov.vyvarstrh.masem,dynovasesmet.,bramborackashoubamikapustovasklobasou		\N	5
1136	Sterilovaná polévka ve skle 0,7l - Gulášová s vepřovým masem, Hov. vývar se zel.a noky, Rajská s těstovinou, Dýňová se smetanou	sterilovanapolevkaveskle0,7l-gulasovasveprovymmasem,hov.vyvarsezel.anoky,rajskastestovinou,dynovasesmetanou		\N	5
1137	Sterilovaná polévka ve skle 0,7l - Hov. vývar se zel.a noky, Rajská s těstovinou, Dýňová se smet., Kyselice s uz.masem, Kuř. vývar se zel.a masem	sterilovanapolevkaveskle0,7l-hov.vyvarsezel.anoky,rajskastestovinou,dynovasesmet.,kyselicesuz.masem,kur.vyvarsezel.amasem		\N	5
1138	Sterilovaná polévka ve skle 0,7l - Hov. vývar se zel.a noky, Rajská s těstovinou, Dýňová se smetanou	sterilovanapolevkaveskle0,7l-hov.vyvarsezel.anoky,rajskastestovinou,dynovasesmetanou		\N	5
1139	Sterilovaná polévka ve skle 0,7l - Hovězí vývar, Dýňová, Kyselice	sterilovanapolevkaveskle0,7l-hovezivyvar,dynova,kyselice		\N	5
1140	Sterilovaná polévka ve skle 0,7l -Hovězí vývar,Dýňová,Rajská,Valašská kyselice	sterilovanapolevkaveskle0,7l-hovezivyvar,dynova,rajska,valasskakyselice		\N	5
1143	Sterilovaná polévka ve skle 0,7l - Kapustová s klobásou, Gulášová s v. masem, Rajská s rest. paprikami, Kyselice s uz.masem	sterilovanapolevkaveskle0,7l-kapustovasklobasou,gulasovasv.masem,rajskasrest.paprikami,kyselicesuz.masem		\N	5
1144	Sterilovaná polévka ve skle 0,7l - Kapustová s klobásou, Rajská s rest. paprikami	sterilovanapolevkaveskle0,7l-kapustovasklobasou,rajskasrest.paprikami		\N	5
1145	Sterilovaná polévka ve skle 0,7l - Kulajda, Gulášová s vepř. masem, Dýňová, Kuř. vývar se zel.a masem, Z rest.paprik s rajč.a smetanou	sterilovanapolevkaveskle0,7l-kulajda,gulasovasvepr.masem,dynova,kur.vyvarsezel.amasem,zrest.papriksrajc.asmetanou		\N	5
1147	Sterilovaná polévka ve skle 0,7l - Kulajda, Rozbaš hrachová  s masem a raj., Gulášová s vepř.masem, Kyselice s uz.masem, Hov.vývar s trh.masem	sterilovanapolevkaveskle0,7l-kulajda,rozbashrachovasmasemaraj.,gulasovasvepr.masem,kyselicesuz.masem,hov.vyvarstrh.masem		\N	5
1148	Sterilovaná polévka ve skle 0,7l - Kulajda, Rozbaš hrachová  s masem a raj., Gulášová s vepř.masem, Kyselice s uz.masem, Hov.vývar s trh.masem, Dýňová se smet., Bramboračka s houbami, Kapustová s klobásou	sterilovanapolevkaveskle0,7l-kulajda,rozbashrachovasmasemaraj.,gulasovasvepr.masem,kyselicesuz.masem,hov.vyvarstrh.masem,dynovasesmet.,bramborackashoubami,kapustovasklobasou		\N	5
1149	Sterilovaná polévka ve skle 0,7l -Kuřecí vývar,Dýňová,Gulášová,Sýrová,Kapustová,Kulajda	sterilovanapolevkaveskle0,7l-kurecivyvar,dynova,gulasova,syrova,kapustova,kulajda		\N	5
1150	Sterilovaná polévka ve skle 0,7l - Kuřecí vývar,Dýňová,Gulášová,Sýrová,Kapustová,Kyselice,Kulajda	sterilovanapolevkaveskle0,7l-kurecivyvar,dynova,gulasova,syrova,kapustova,kyselice,kulajda		\N	5
1151	Sterilovaná polévka ve skle 0,7l - Kuřecí vývar,Dýňová,Gulášová,Sýrová,Kulajda	sterilovanapolevkaveskle0,7l-kurecivyvar,dynova,gulasova,syrova,kulajda		\N	5
1152	Sterilovaná polévka ve skle 0,7l - Kyselice, Gulášová, Rajská	sterilovanapolevkaveskle0,7l-kyselice,gulasova,rajska		\N	5
1153	Sterilovaná polévka ve skle 0,7l - Kyselice,Gulášová,Z restovaných paprik	sterilovanapolevkaveskle0,7l-kyselice,gulasova,zrestovanychpaprik		\N	5
1154	Sterilovaná polévka ve skle 0,7l - Kyselice, Hovězí vývar, Dýňová	sterilovanapolevkaveskle0,7l-kyselice,hovezivyvar,dynova		\N	5
1155	Sterilovaná polévka ve skle 0,7l - Kyselice, Rajská, Gulášová	sterilovanapolevkaveskle0,7l-kyselice,rajska,gulasova		\N	5
1156	Sterilovaná polévka ve skle 0,7l - Kyselice s uz.masem, Z restovaných paprik s rajčaty, Kulajda, Rozbaš hrachová  s masem a raj., Gulášová s vepř.masem	sterilovanapolevkaveskle0,7l-kyselicesuz.masem,zrestovanychpapriksrajcaty,kulajda,rozbashrachovasmasemaraj.,gulasovasvepr.masem		\N	5
1158	Sterilovaná polévka ve skle 0,7l -Masová,Gulášová,Kapustová,Sýrová,Dýňová,Z restovaných paprik	sterilovanapolevkaveskle0,7l-masova,gulasova,kapustova,syrova,dynova,zrestovanychpaprik		\N	5
1159	Sterilovaná polévka ve skle 0,7l -Masová,Gulášová,Kapustová,Sýrová,Dýňová,Z restovaných paprik,Kuřecí vývar	sterilovanapolevkaveskle0,7l-masova,gulasova,kapustova,syrova,dynova,zrestovanychpaprik,kurecivyvar		\N	5
1161	Sterilovaná polévka ve skle 0,7l - Rajská, Kyselice, Hovězí vývar	sterilovanapolevkaveskle0,7l-rajska,kyselice,hovezivyvar		\N	5
1162	Sterilovaná polévka ve skle 0,7l - Rajská s rest. paprikami, Kapustová s klobásou	sterilovanapolevkaveskle0,7l-rajskasrest.paprikami,kapustovasklobasou		\N	5
1163	Sterilovaná polévka ve skle 0,7l -Rajská s těstovinou	sterilovanapolevkaveskle0,7l-rajskastestovinou		\N	5
1165	Sterilovaná polévka ve skle  0,7l - Valašská kyselice, Dýňový krém	sterilovanapolevkaveskle0,7l-valasskakyselice,dynovykrem		\N	5
1166	Sterilovaná polévka ve skle  0,7l - Valašská kyselice, Dýňový krém, Gulášová	sterilovanapolevkaveskle0,7l-valasskakyselice,dynovykrem,gulasova		\N	5
1167	Sterilovaná polévka ve skle  0,7l - Valašská kyselice, Gulášová	sterilovanapolevkaveskle0,7l-valasskakyselice,gulasova		\N	5
1168	Sterilovaná polévka ve skle  0,7l - Valašská kyselice, Gulášová,	sterilovanapolevkaveskle0,7l-valasskakyselice,gulasova,		\N	5
1169	Sterilovaná polévka ve skle  0,7l - Valašská kyselice, Gulášová, Bramboračka, Rajská z pečených paprik	sterilovanapolevkaveskle0,7l-valasskakyselice,gulasova,bramboracka,rajskazpecenychpaprik		\N	5
1170	Sterilovaná polévka ve skle  0,7l - Valašská kyselice, Gulášová, Bramboračka, Rajská z pečených papriki	sterilovanapolevkaveskle0,7l-valasskakyselice,gulasova,bramboracka,rajskazpecenychpapriki		\N	5
1171	Sterilovaná polévka ve skle  0,7l - Valašská kyselice,Gulášová,Kapustová	sterilovanapolevkaveskle0,7l-valasskakyselice,gulasova,kapustova		\N	5
1172	Sterilovaná polévka ve skle  0,7l - Valašská kyselice,Gulášová,Kapustová,Dyňová,Hovězí vývar	sterilovanapolevkaveskle0,7l-valasskakyselice,gulasova,kapustova,dynova,hovezivyvar		\N	5
1173	Sterilovaná polévka ve skle 0,7l -Valašská kyselice,Hovězí vývar,Kuřecí vývar,Z restovaných paprik	sterilovanapolevkaveskle0,7l-valasskakyselice,hovezivyvar,kurecivyvar,zrestovanychpaprik		\N	5
1174	Sterilovaná polévka ve skle 0,7l -Valašská kyselice,Rajská s těstovinou	sterilovanapolevkaveskle0,7l-valasskakyselice,rajskastestovinou		\N	5
1175	Sterilovaná polévka ve skle  0,7l - Valašská kyselice, Rajská z restovaných paparik, Gulášová	sterilovanapolevkaveskle0,7l-valasskakyselice,rajskazrestovanychpaparik,gulasova		\N	5
1176	Sterilovaná polévka ve skle  0,7l - Valašská kyselice,Z restovaných paprik	sterilovanapolevkaveskle0,7l-valasskakyselice,zrestovanychpaprik		\N	5
1177	Sterilovaná polévka ve skle  0,7l - Valašská kyselice,Z restovaných paprik,Gulášová,Kapustová	sterilovanapolevkaveskle0,7l-valasskakyselice,zrestovanychpaprik,gulasova,kapustova		\N	5
1178	Sterilovaná polévka ve skle  0,7l - Z restovaných paprik,Brokolicová,Kuřecí,hovězí  vývar,Sýrová,Kapustová,Dyňová,Masový vývar,Kukuřiční chowder,Gulášová	sterilovanapolevkaveskle0,7l-zrestovanychpaprik,brokolicova,kureci,hovezivyvar,syrova,kapustova,dynova,masovyvyvar,kukuricnichowder,gulasova		\N	5
1164	Sterilovaná polévka ve skle 0,7l -Valašská kyselice	sterilovanapolevkaveskle0,7l-valasskakyselice		Sterilovaná polévka ve skle  0,7l - Valašská kyselice	5
1179	Sterilovaná polévka ve skle  0,7l - Z restovaných paprik,Brokolicová,Kuřecí vývar,Sýrová,Kapustová,Dyňová,Masový vývar	sterilovanapolevkaveskle0,7l-zrestovanychpaprik,brokolicova,kurecivyvar,syrova,kapustova,dynova,masovyvyvar		\N	5
1181	Sterilovaná polévka ve skle  0,7l - Z restovaných paprik,Brokolicová,Sýrová,Masový vývar,Kukuřiční chowder,Gulášová	sterilovanapolevkaveskle0,7l-zrestovanychpaprik,brokolicova,syrova,masovyvyvar,kukuricnichowder,gulasova		\N	5
1182	Sterilovaná polévka ve skle  0,7l - Z restovaných paprik,Brokolicová,Sýrová,Masový vývar,Kukuřiční chowder,Gulášová,Dýňová,Valašská kyselice,Hovězí vývar	sterilovanapolevkaveskle0,7l-zrestovanychpaprik,brokolicova,syrova,masovyvyvar,kukuricnichowder,gulasova,dynova,valasskakyselice,hovezivyvar		\N	5
1183	Sterilovaná polévka ve skle 0,7l - Z restovaných paprik s rajčaty, Kulajda, Rozbaš hrachová  s masem a raj., Gulášová s vepř.masem	sterilovanapolevkaveskle0,7l-zrestovanychpapriksrajcaty,kulajda,rozbashrachovasmasemaraj.,gulasovasvepr.masem		\N	5
1184	Sterilovaná polévka ve skle 0,7l - Z restovaných paprik s rajčaty, Kulajda, Rozbaš hrachová  s masem a raj., Gulášová s vepř.masem, Kyselice s uz.masem, Hov.vývar s trh.masem	sterilovanapolevkaveskle0,7l-zrestovanychpapriksrajcaty,kulajda,rozbashrachovasmasemaraj.,gulasovasvepr.masem,kyselicesuz.masem,hov.vyvarstrh.masem		\N	5
1191	terilovaná polévka ve skle 0,7l - Rajská s rest. paprikami, Kapustová s klobásou	terilovanapolevkaveskle0,7l-rajskasrest.paprikami,kapustovasklobasou		\N	5
360	150g Kuřecí řízek Ondráš smažený v bramborákovém těstě, trhaný salát, bylinkový dip	150gkurecirizekondrassmazenyvbramborakovemteste,trhanysalat,bylinkovydip	1a, 3, 7, 9	150g Chicken Schnitzel in Potato Batter, shredded Lettuce, herb Dip	2
777	300g Zapečená máslová dýně se zeleninou, fazolemi, čočkou beluga a balkánským sýrem, trhaný salát	300gzapecenamaslovadynesezeleninou,fazolemi,cockoubelugaabalkanskymsyrem,trhanysalat	7, 9	300g Baked Squash with Vegetables, Beans, Beluga Lentils and Brined Curd Cheese, shredded Lettuce	2
1719	150g Smažené rybí filé, vařené brambory s máslem, sweet chilli dip	150gsmazenerybifile,varenebramborysmaslem,sweetchillidip	1a, 3, 4, 6, 7, 9, 10	150g Fried Fish Fillet, boiled Potatoes with Butter, sweet Chilli Dip	2
1720	150g Grilovaný kuřecí steak s bylinkovým máslem, pečená zelenina, steakové hranolky	150ggrilovanykurecisteaksbylinkovymmaslem,pecenazelenina,steakovehranolky	1a, 1b, 3, 5, 7, 9, 10, 11	150g Grillled Chicken Steak with Herb Butter, roasted Vegetables, french Fries in Steak Seasoning	6
1721	490g Pizza POLLO tomat, kuřecí maso, kukuřice,mozzarella, oregáno	490gpizzapollotomat,kurecimaso,kukurice,mozzarella,oregano	1a, 1b, 3, 5, 7, 9, 10, 11	490g Pizza POLLO Tomato Purée, Chicken Meat, Edam Cheese, Maize, Oregano	8
548	2 Sterilovaná hotovka ve skle  -	2sterilovanahotovkaveskle-		2 Sterilovaná hotovka ve skle  -	5
1722	300g Zapečené gnocchi s kuřecím masem, rajčatovou omáčkou, bazalkou a parmazánem	300gzapecenegnocchiskurecimmasem,rajcatovouomackou,bazalkouaparmazanem		300g Scalloped Gnocchi with Chicken Meat, Tomato Sauce, Basil and Parmesan Cheese	6
419	150g Smažené rybí filé, vařené brambory, sweet chilli dip	150gsmazenerybifile,varenebrambory,sweetchillidip	1a, 3, 4, 6, 7, 10	150g Fried Fish Fillet, boiled Potatoes, sweet Chilli Dip	2
1723	2 Sterilovaná hotovka ve skle  - Boloňská směs, Rajská s kuličkami, Vrabec se zelím, Vepř.krkovice s pepř.om., Segedínský guláš	2sterilovanahotovkaveskle-bolonskasmes,rajskaskulickami,vrabecsezelim,vepr.krkovicespepr.om.,segedinskygulas		2 Sterilovaná hotovka ve skle  - Boloňská směs, Rajská s kuličkami, Vrabec se zelím, Vepř.krkovice s pepř.om., Segedínský guláš	5
1724	3 Sterilovaná hotovka ve skle  - Rajská s hov.masem, Chow -main z vepř.panenky, Svíčková om., Znojemské nudličky, Chilli con carne, Kuř.medailonky s liškovou omáčkou	3sterilovanahotovkaveskle-rajskashov.masem,chow-mainzvepr.panenky,svickovaom.,znojemskenudlicky,chilliconcarne,kur.medailonkysliskovouomackou		3 Sterilovaná hotovka ve skle  - Rajská s hov.masem, Chow -main z vepř.panenky, Svíčková om., Znojemské nudličky, Chilli con carne, Kuř.medailonky s liškovou omáčkou	5
1725	150g Smažený holandský řízek, bramborová kaše, kyselý okurek	150gsmazenyholandskyrizek,bramborovakase,kyselyokurek	1a, 3, 7, 9, 10	150g Fried Slices of Minced Pork Meat and Cheese, mashed Potatoes, gherkin	2
1726	300g Pečené brambory s anglickou slaninou, klobásou, cibulí a uzeným masem, pikantí salát z kyselého zelí	300gpecenebramborysanglickouslaninou,klobasou,cibuliauzenymmasem,pikantisalatzkyselehozeli	1, 3, 5, 7, 9, 10, 11	300g Roasted Potatoes with Bacon, Smoked Sausage, Onion and Smoked Meat, spicy Sauerkraut Salad	2
1727	300g Zeleninový salát s pečenými jablky, ořechy a sušenými brusinkami, krůtí plátek	300gzeleninovysalatspecenymijablky,orechyasusenymibrusinkami,krutiplatek	1a, 8, 8c, 10	300g Vegetable Salad with Roasted Apples, Nuts and Dried Cranberries, Turkey Slice	2
1190	Telecí vývar s trhaným masem a julienne zeleninou	telecivyvarstrhanymmasemajuliennezeleninou	1a, 3, 7, 9	Veal Broth with Pulled Meat and Julienne Vegetables	9
1186	Sushi - Avokado maki, Maki rolka s omeletou, Sake nigiri s lososem	sushi-avokadomaki,makirolkasomeletou,sakenigirislososem	3, 4, 6, 11	\N	6
1187	Sushi - Uramaki se surimi, Maki rolka s okurkem a ředkví, Sake nigiri s lososem	sushi-uramakisesurimi,makirolkasokurkemaredkvi,sakenigirislososem	1a, 1b, 4, 11	\N	6
1188	Sýrová polévka s bylinkovými krutony	syrovapolevkasbylinkovymikrutony	1a, 7, 9	\N	9
1189	Telecí vývar s bio zeleninou a krupicovými noky	telecivyvarsbiozeleninouakrupicovyminoky	1a, 3, 7, 9	\N	9
1195	Vegetariánská zeleninová korma s kokosovým krémem a mandlemi, biryami rýže, bez lepku	vegetarianskazeleninovakormaskokosovymkrememamandlemi,biryamiryze,bezlepku	7, 8, 8a, 9, 10	\N	2
1197	Zapečený kuřecí steak se šunkou a sýrem, dušená rýže	zapecenykurecisteaksesunkouasyrem,dusenaryze	1a, 7, 9, 10	\N	2
\.


--
-- Name: categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.categories_id_seq', 11, true);


--
-- Name: meals_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.meals_id_seq', 1829, true);


--
-- Name: photos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.photos_id_seq', 1, false);


--
-- Name: categories categories_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_name_key UNIQUE (name);


--
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: meals meals_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.meals
    ADD CONSTRAINT meals_pkey PRIMARY KEY (id);


--
-- Name: meals meals_slug_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.meals
    ADD CONSTRAINT meals_slug_key UNIQUE (slug);


--
-- Name: photos photos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.photos
    ADD CONSTRAINT photos_pkey PRIMARY KEY (id);


--
-- Name: idx_meals_slug; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_meals_slug ON public.meals USING btree (slug);


--
-- Name: meals meals_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.meals
    ADD CONSTRAINT meals_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.categories(id);


--
-- Name: photos photos_meal_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.photos
    ADD CONSTRAINT photos_meal_id_fkey FOREIGN KEY (meal_id) REFERENCES public.meals(id) ON DELETE CASCADE;


--
-- Konec inicializace databáze
--
