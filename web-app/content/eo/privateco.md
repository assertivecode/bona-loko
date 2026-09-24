---
id: privacy_policy
title: "Privateca Politiko & Datuma Suvereneco"
slug: "privateco"
last_updated: "2026-09-24"
summary: "Komprenu kiel Bona Loko respektas vian privatecon per nula rekta datumkolektado kaj kiel servoj kiel Cloudflare kaj Google prilaboras ĝeneralajn teknikajn informojn."
---

# Privateca Politiko & Datuma Suvereneco

> *"Vera persona transformiĝo postulas mensan trankvilon kaj nedisputeblan sendependecon. Bona Loko estas arkitekturita ekde la komenco por respekti homan atenton, privatan reflektadon kaj individuan suverenecon."*

**Dato de Efikeco:** 24-a de septembro 2026  
**Aplikeblo:** Reteja Aplikaĵo Bona Loko ([bonaloko.com](https://bonaloko.com)) & Poŝtelefona Aplikaĵo Bona Loko.

---

## 1. Fundamenta Devontigo: Nula Rekta Datumkolektado

Bona Loko funkcias laŭ **nula-scia (zero-knowledge) kaj unue-loka (local-first) arkitekturo**. Ĉu vi uzas la retpaĝaron aŭ la poŝtelefonan apon:

- **Ni ne kolektas, petas aŭ konservas viajn personajn informojn.**
- **Neniu kont-registriĝo:** Vi ne bezonas doni nomon, retpoŝton, pasvorton, telefonnumeron aŭ socian saluton por uzi la platformon.
- **Neniu centra uzant-datumbazo:** Bona Loko ne funkciigas nubajn servilojn por stoki viajn profilojn, privatajn notojn, poentarojn aŭ kutimojn.

### Ekskluzive Loka Stokado
- **Reta Aplikaĵo:** Ĉiuj taksadoj pri vivkampoj, reflektaj notoj kaj ekranaj preferoj restas konservitaj en via propra retumilo per HTML5 `localStorage` kaj kuketoj destinitaj sole por lingvoelekto (`bona_loko_locale`).
- **Poŝtelefona Aplikaĵo:** Ĉiuj kutimoj, dankemaj kialoj, ekzercoj kaj financaj enskriboj estas registritaj ekskluzive en la loka SQLite-datumbazo (per Drift) de via aparato. Nenio estas sendata al eksteraj serviloj.

---

## 2. Triapartia Infrastrukturo & Analitikaj Servoj

Kvankam Bona Loko ne kolektas datumojn rekte, vizito al la reta platformo teknike postulas komunikadon kun reta infrastrukturo. Ni kredas je plena travidebleco pri la rolo de ĉi tiuj partneroj.

### Resumo: Ĝeneralaj Informoj kontraŭ Personaj Informoj

| Servo | Ĉefa Rolo | Informtipo | Klasifiko | Celo |
| :--- | :--- | :--- | :--- | :--- |
| **Cloudflare** | Randa gastigado, CDN & DDoS-ŝildo | Teknikaj retaj kaplinioj, IP-adreso, retumila tipo (user-agent), TLS-ĉifro, petita URL, tempindiko | **Ĝenerala Teknika Informo** *(Pseŭdonima IP traktata je reta tavolo)* | Liveri retpaĝojn rapide tutmonde, forpuŝi retatakojn kaj bloki damaĝajn robotojn |
| **Google Analytics (GA4)** | Sumigitaj Uzad-Metrikoj | Paĝvidoj, daŭro de vizito, aparata kategorio, retumilo, proksimuma urbo/lando, trafika fonto | **Ĝeneralaj Sumigitaj Metrikoj** *(Sen personaj identigiloj)* | Kompreni kiuj gvidiloj helpas homojn, kontroli rapidecon kaj ripari paneojn |
| **Google Search** | Reta Serĉilo & Indekso | Serĉvortoj kaj klakoj en la rezultaj paĝoj de Google | **Eksteraj Ĝeneralaj Metrikoj** | Ebligi al serĉantoj trovi viv-ekvilibrajn gvidilojn en la serĉilo |

---

## 3. Gastigado & Randa Livero per Cloudflare

La reta aplikaĵo estas gastigata kaj tutmonde distribuata per la randa reto de **Cloudflare Pages & Workers** (Cloudflare, Inc.).

### Kiujn informojn ĝi prilaboras:
Kiam vi petas paĝon en nia retejo, la reto de Cloudflare ricevas:
- **IP-Adreson:** Teknike bezonatan por liveri la datumajn pakaĵojn al via aparato.
- **Teknikajn Kapliniojn:** Operaciumon, retumilon (user-agent), petitan retadreson kaj lingvan agordon.
- **Sekurecajn Metrikojn:** Trafikajn ŝablonojn por malkovri aŭtomatajn atakojn (DDoS) kaj spamaĵojn.

### Distingo inter Personaj kaj Ĝeneralaj Informoj:
- **Ĝeneralaj Datumoj:** Retumilaj versioj, respondrapido, kaŝmemora efikeco kaj operaciumoj estas plene teknikaj kaj nepersonaj.
- **IP-Adresoj:** Kvankam IP-adreso estas konsiderata pseŭdonima persona datumo laŭ iuj leĝoj (kiel GDPR), Cloudflare uzas ĝin nur por sekura reta vojigo kaj ciber-defendo. Cloudflare ne vendas ĉi tiujn datumojn, kaj Bona Loko havas neniun rimedon por ligi IP-adreson al la persona identeco de vizitanto.

Por pliaj detaloj, vidu la [Privatecan Politikon de Cloudflare](https://www.cloudflare.com/privacypolicy/).

---

## 4. Google Analytics & Google Search

Nia retejo uzas **Google Analytics (GA4)** por mezuri la ĝeneralan atenton kaj plibonigi la edukan materialon de la platformo.

### Kiujn informojn ĝi kolektas:
Google Analytics kolektas nur ĝeneralajn kaj sumigitajn interagojn:
- **Reteja Vizitado:** Vizititaj paĝoj, vizitdaŭro, rulaj atingoj kaj klakoj al eksteraj ligiloj.
- **Aparata Medio:** Aparata tipo (poŝtelefono, komputilo, tabulkomputilo), ekrana distingivo, retumila familio kaj operaciumo.
- **Proksimuma Loko:** Lando kaj urbo derivitaj de aŭtomata maskado de IP.

### Distingo inter Personaj kaj Ĝeneralaj Informoj:
- **Strikte Ĝenerala kaj Anonimigita:** GA4 defaŭlte maskas IP-adresojn kaj ne registras individuajn IP-adresojn.
- **Neniuj Sentemaj Datumoj Sendataj:** Bona Loko neniam sendas personajn notojn, financajn registrojn, vivpoentojn aŭ kutimajn detalojn al Google Analytics.
- **Sen Reklama Profilado:** Ni ne aktivigas Google Signals aŭ personigitan reklaman spuradon.

### Google Search
Niaj paĝoj estas publike indeksitaj en Google Search. Serĉpetoj enmetitaj en Google estas regataj de la [Privateca Politiko de Google](https://policies.google.com/privacy). Bona Loko vidas nur altnivelajn sumigitajn nombrojn (kiel totalajn klakojn kaj montrojn) per Google Search Console.

---

## 5. Kuketoj kaj Loka Stokada Kontrolo

Bona Loko uzas nur la plej necesajn lokajn stokerojn:

1. **Funkcia Kuketo (`bona_loko_locale`):** Memoras vian elektitan lingvon (`eo`, `pt-BR`, aŭ `en-US`).
2. **Loka Stokado (`localStorage`):** Konservas viajn respondojn de la Rado de la Vivo rekte en via retumilo.
3. **Analitikaj Kuketoj (`_ga`, `_ga_*`):** Metitaj de Google Analytics por rekoni anonimajn sesiojn.

### Kiel vi povas regi tion:
- **Vakigi Retumilon:** Vi povas iam ajn forviŝi kuketojn kaj lokajn datumojn en la agordoj de via retumilo.
- **Ne Spuri (DNT / GPC):** Vi povas ŝalti la opcion "Do Not Track" aŭ "Global Privacy Control" en via retumilo.
- **Malŝalti Analitikon:** Vi povas instali la oficialan [Kromprogramon por Malŝalti Google Analytics](https://tools.google.com/dlpage/gaoptout) aŭ uzi privaecajn blokilojn.

---

## 6. Poŝtelefona Aplikaĵo: Plena Senreta Protekto

La poŝtelefona aplikaĵo de Bona Loko (Kutimfarilo) havas eĉ pli striktan limon:
- **100% Senreta:** Ĉiuj kutimoj, dankemaj notoj, sportaj ekzercoj kaj financaj enskriboj restas nur en la loka SQLite-datumbazo de via aparato.
- **Neniuj Reklamaj SDK-oj:** La apo enhavas neniujn reklamajn modulojn, neniujn kaŝitajn spurilojn kaj neniun fonan lok-spuradon.
- **Tuta Forigo:** Se vi forigas enskribon aŭ malinstalas la apon, ĉiuj datumoj tuj kaj definitive malaperas el via aparato.

---

## 7. Privateco de Infanoj (COPPA & GDPR-K)

Bona Loko ne celas kaj ne kolektas datumojn de infanoj. Ĉar la sistemo ne postulas konton kaj konservas informojn nur en la aparato de la uzanto, neniu infana profilo estas kreata aŭ tenata en niaj serviloj.

---

## 8. Ĝisdatigoj de Ĉi Tiu Politiko

Ĉi tiu dokumento povas esti ĝisdatigita por reflekti teknikajn plibonigojn aŭ leĝajn postulojn. Ĉiu revizio estos anoncita sur ĉi tiu paĝo kun la indikita "Dato de Efikeco".

---

## 9. Kontakto & Malferma Administrado

Bona Loko estas malfermkoda persona disvolva iniciato. Se vi havas demandojn pri nia arkitekturo, bonvolu esplori nian fontkodon aŭ kontakti nin:

- **Fontkoda Deponejo:** [github.com/assertivecode/bona-loko](https://github.com/assertivecode/bona-loko)
- **Morala Konstitucio:** [FOUNDATION.md](https://github.com/assertivecode/bona-loko/blob/main/FOUNDATION.md)
