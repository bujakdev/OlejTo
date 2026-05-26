# OlejTo! — Pełny plan budowy aplikacji mobilnej

> Android & iOS · Flutter · Freemium  
> Autor/twórca: **Bujak Apps**  
> Czas budowy MVP: ~3 miesiące | Koszt startu: ~100–500 zł

## Dokumentacja wykonawcza (VS Code)

- [docs/README.md](docs/README.md) — indeks dokumentacji
- [docs/01_PRODUCT_BRIEF.md](docs/01_PRODUCT_BRIEF.md) — cel produktu i KPI
- [docs/02_MVP_SCOPE.md](docs/02_MVP_SCOPE.md) — zakres MVP i kryteria akceptacji
- [docs/03_ARCHITECTURE.md](docs/03_ARCHITECTURE.md) — architektura Flutter
- [docs/04_IMPLEMENTATION_PLAN_12_WEEKS.md](docs/04_IMPLEMENTATION_PLAN_12_WEEKS.md) — harmonogram wdrozenia
- [docs/05_ENV_SETUP_VSCODE.md](docs/05_ENV_SETUP_VSCODE.md) — setup srodowiska
- [docs/06_AI_WORKFLOW_CHATGPT_CLAUDE.md](docs/06_AI_WORKFLOW_CHATGPT_CLAUDE.md) — workflow AI
- [docs/07_DATA_MODEL.md](docs/07_DATA_MODEL.md) — model danych
- [docs/08_NOTIFICATIONS_AND_PAYWALL.md](docs/08_NOTIFICATIONS_AND_PAYWALL.md) — notyfikacje i freemium
- [docs/09_TESTING_RELEASE_OPS.md](docs/09_TESTING_RELEASE_OPS.md) — testy i release
- [docs/10_BACKLOG_AND_NEXT_STEPS.md](docs/10_BACKLOG_AND_NEXT_STEPS.md) — backlog i kolejne kroki
- [docs/11_IOS_INFRA_ON_WINDOWS.md](docs/11_IOS_INFRA_ON_WINDOWS.md) — iOS infra na Windows (Codemagic vs GitHub Actions)
- [docs/12_GITHUB_ACTIONS_IOS_RUNBOOK.md](docs/12_GITHUB_ACTIONS_IOS_RUNBOOK.md) — runbook wdrozenia iOS CI (GitHub Actions)
- [docs/13_APPLE_SIGNING_CHECKLIST.md](docs/13_APPLE_SIGNING_CHECKLIST.md) — checklista Apple Signing krok po kroku

---

## 1. Pomysł i koncepcja

### 1.1 Co to jest OlejTo?

OlejTo! to aplikacja mobilna na Android i iOS pomagająca kierowcom i właścicielom warsztatów śledzić wymianę oleju oraz innych płynów eksploatacyjnych. Wysyła powiadomienia push gdy zbliża się termin wymiany (na podstawie przebiegu lub daty), przechowuje historię serwisów i pozwala zarządzać wieloma pojazdami.

### 1.2 Problem który rozwiązuje

- Kierowcy zapominają o wymianie oleju i niszczą silnik
- Brak jednego miejsca na historię serwisową pojazdu
- Warsztaty i floty nie mają prostego narzędzia do monitorowania wielu aut
- Paragony z serwisów giną — nie wiadomo co, kiedy i za ile było robione

### 1.3 Grupy docelowe

| Segment | Charakterystyka |
|---|---|
| Kierowca indywidualny | 1 auto, proste przypomnienie, główna masa użytkowników |
| Rodzina / kilka aut | 2–4 pojazdy, zarządzanie flotą domową, segment premium |
| Mechanik / warsztat | 10–50+ pojazdów klientów, historia, raporty |
| Flota firmowa | Firmowe auta, kontrola kosztów, eksport danych, potencjał B2B SaaS |

### 1.4 USP (unikalna propozycja wartości)

Większość aplikacji serwisowych jest skomplikowana lub brzydka. OlejTo! stawia na prostotę: dodajesz auto, ustawiasz próg km — reszta działa automatycznie. Polska lokalizacja, brak zbędnych funkcji, uczciwy model freemium.

---

## 2. Funkcjonalności

### 2.1 Wersja darmowa (Free)

- Dodanie 1 pojazdu (marka, model, rok, tablica rejestracyjna)
- Śledzenie wymiany oleju silnikowego
- Przypomnienia push — na X km przed wymianą lub Y dni przed datą
- Wizualny wskaźnik stanu oleju (pierścień procentowy)
- Podstawowy wpis serwisowy (data, przebieg, rodzaj oleju)
- Prosta historia — ostatnie 3 wpisy

### 2.2 Wersja Premium (płatna)

- Nieograniczona liczba pojazdów
- Śledzenie wszystkich płynów: hamulcowy, chłodniczy, skrzynia biegów, wspomaganie
- Pełna historia serwisów bez limitu wpisów
- Statystyki wydatków (wykresy miesięczne i roczne)
- Eksport historii do PDF — raport dla kupującego auto
- Skanowanie paragonu z warsztatu (OCR przez aparat)
- Przypomnienia o przeglądzie technicznym (OC, badanie techniczne)
- Widget na ekran główny telefonu
- Brak reklam

### 2.3 Lista ekranów

| Ekran | Opis |
|---|---|
| Splash / Onboarding | Ekran powitalny z logo, 3 slajdy onboardingu |
| Dashboard | Karty samochodów z pierścieniami stanu oleju, lista pilnych przypomnień |
| Dodaj auto | Formularz: marka, model, rok, tablica, aktualny przebieg |
| Szczegóły auta | Wszystkie wskaźniki płynów, przyciski dodania wpisu |
| Historia serwisu | Lista wpisów z datą, km, kosztem, typem serwisu |
| Dodaj wpis | Typ, km, data, rodzaj oleju, koszt, notatka |
| Ustawienia | Jednostki, dark mode, powiadomienia, konto premium |
| Paywall | Ekran zachęty do zakupu z listą korzyści premium |

---

## 3. Model monetyzacji

### 3.1 Model: Freemium

Aplikacja bezpłatna do pobrania. Użytkownik z 2+ autami lub potrzebujący historii trafia na paywall.

### 3.2 Ceny subskrypcji

| Plan | Cena | Uwagi |
|---|---|---|
| Miesięczna | 9,99 zł / miesiąc | Niski próg wejścia |
| Roczna | 49,99 zł / rok | Oszczędność ~58%, opcja główna |
| Dożywotnia | 149,99 zł jednorazowo | Wysoka LTV |

### 3.3 Mechanizmy konwersji Free → Premium

- Przy dodaniu 2. auta: paywall "Odblokuj więcej aut"
- Po 3 wpisach historii: "Twoja historia jest pełna — odblokuj premium"
- Przy próbie eksportu PDF: paywall
- Banner w ustawieniach z listą korzyści
- Push promo po 7 dniach: "50% zniżki tylko przez 48h"

> **Dlaczego nie tylko reklamy?** Przy 200 płatnych użytkownikach subskrypcja przynosi ~10 000 zł rocznie bez milionowych pobrań. Reklamy wymagają dziesiątek tysięcy aktywnych użytkowników żeby zarobić cokolwiek sensownego.

---

## 4. Stack technologiczny

### 4.1 Framework: Flutter

Flutter (Google) kompiluje jeden kod Dart do natywnych aplikacji na Android i iOS. Idealne dla solo-dewelopera. AI (Claude, Cursor) doskonale zna ten framework.

### 4.2 Kluczowe biblioteki

| Biblioteka | Zastosowanie |
|---|---|
| `flutter_local_notifications` | Powiadomienia push lokalne (km lub data) |
| `hive` / `sqflite` | Lokalna baza danych offline |
| `provider` / `riverpod` | State management |
| `RevenueCat` | Subskrypcje in-app — Android + iOS jednocześnie |
| `google_mobile_ads` | Reklamy AdMob (opcjonalnie) |
| `pdf` / `printing` | Generowanie i eksport raportów PDF |
| `image_picker` + `google_mlkit` | Skanowanie paragonów (OCR) |
| `shared_preferences` | Zapis ustawień użytkownika |
| `fl_chart` | Wykresy wydatków na serwis |
| `home_widget` | Widget na ekran główny (premium) |

### 4.3 Narzędzia deweloperskie

- **Cursor IDE** — edytor z AI, pisze 70–80% kodu
- **Android Studio** — emulator Android
- **Xcode** (Mac) — wymagany do buildu i publikacji iOS
- **Git + GitHub** — wersjonowanie kodu
- **Figma** — projektowanie UI
- **Firebase Analytics** — śledzenie użytkowników (darmowe)

> **Ważne:** Publikacja na App Store wymaga Maca. Możesz zacząć od samego Androida i dodać iOS później przez Codemagic (chmurowe buildy).

---

## 5. Harmonogram — 10 tygodni

### Faza 1 | Tyg. 1–2 | Setup + ekrany podstawowe

- Instalacja Flutter SDK, Dart, Android Studio
- Konfiguracja projektu w Cursor IDE
- Splash screen i onboarding (3 slajdy)
- Dashboard — karta auta, pierścień stanu oleju
- Bottom navigation bar
- Prompt w Cursor: *"zrób mi dashboard OlejTo w Flutter"*

### Faza 2 | Tyg. 3–4 | Baza danych i logika

- Integracja Hive (lokalna baza danych offline)
- Model danych: `Vehicle`, `ServiceEntry`, `Reminder`
- Formularz dodania pojazdu z walidacją
- Formularz dodania wpisu serwisowego
- Obliczanie % zużycia oleju na podstawie km
- Przechowywanie i odczyt historii

### Faza 3 | Tyg. 5–6 | Powiadomienia push

- Integracja `flutter_local_notifications`
- Logika: sprawdzanie co 24h czy zbliża się wymiana
- Powiadomienie na X km przed wymianą (konfigurowalne)
- Powiadomienie na Y dni przed datą
- Ekran ustawień przypomnień
- Testowanie na emulatorze i fizycznym telefonie

### Faza 4 | Tyg. 7–8 | Premium i monetyzacja

- Integracja RevenueCat (plany miesięczny/roczny/dożywotni)
- Ekran paywall z listą korzyści
- Logika freemium: blokada 2. auta, limity historii
- Konfiguracja produktów w Google Play Console i App Store Connect
- Testowanie zakupów w trybie sandbox
- Opcjonalnie: AdMob dla wersji darmowej

### Faza 5 | Tyg. 9–10 | Szlif, testy, publikacja

- Dopracowanie UI: ikony, animacje, dark mode
- Ikona aplikacji i splash screen (Figma → Flutter)
- Testy na prawdziwych urządzeniach (Android + iPhone)
- Konfiguracja Google Play Console — opis, screenshoty, ASO
- Publikacja Google Play (koszt: $25 jednorazowo)
- Publikacja App Store (koszt: $99/rok ≈ 399 zł)

---

## 6. Koszty startowe

### 6.1 Obowiązkowe

| Koszt | Kwota |
|---|---|
| Google Play — rejestracja | $25 jednorazowo ≈ 100 zł |
| Apple Developer Program | $99/rok ≈ 399 zł/rok |
| Cursor IDE (AI coding) | $20/mies ≈ 80 zł (darmowy plan wystarczy na start) |
| RevenueCat | Darmowy do $2 500/mies przychodu, potem 1% |

**Minimum to ~100 zł** (tylko Google Play, tylko Android na start).

### 6.2 Opcjonalne

- Grafik do ikony aplikacji: 100–300 zł
- Mac mini M2 (jeśli brak Maca): ~2 500 zł
- Promocja (Google/Meta Ads): 200–500 zł na test

---

## 7. Strategia ASO i marketingu

### 7.1 ASO — optymalizacja w sklepach

- **Nazwa:** "OlejTo! — Przypomnienie o wymianie oleju"
- **Słowa kluczowe:** wymiana oleju, serwis samochodu, przypomnienie serwisowe, oil change reminder
- **Opis:** pierwsza linia = główna korzyść, nie opis techniczny
- **Screenshoty:** 5–8 grafik z UI (Figma lub Canva)
- **Ikona:** prosta, czytelna w małym rozmiarze — zielone tło + ikonka oleju

### 7.2 Darmowe kanały promocji

- Grupy Facebook: "Motoryzacja", "Youngtimery", "Auta bez tajemnic"
- Reddit: r/motoryzacja, r/samochody
- Forum: motooficyna.pl, autokult.pl
- TikTok / Instagram Reels — krótkie wideo "Jak nigdy nie zapomnę o wymianie oleju"
- Producthunt.com — anglojęzyczna platforma do lansowania produktów

### 7.3 Cele na pierwsze 6 miesięcy

| Okres | Cel |
|---|---|
| Miesiąc 1–2 | Publikacja, 100 pobrań, zbieranie opinii i bugów |
| Miesiąc 3 | 500 pobrań, pierwsze 10–20 płatnych subskrypcji |
| Miesiąc 4–5 | 1 000 pobrań, optymalizacja konwersji, aktualizacja z feedbacku |
| Miesiąc 6 | 2 000 pobrań, 50–100 płatnych = ~2 500–5 000 zł/rok |

---

## 8. Gotowe prompty do Cursor AI

Wklej poniższe prompty do Cursor IDE (Ctrl+K / Cmd+K):

### Prompt #1 — Dashboard główny

```
Stwórz w Flutter ekran Dashboard dla aplikacji OlejTo. Powinien zawierać:
- kartę pojazdu z nazwą, tablicą rejestracyjną i aktualnym przebiegiem
- okrągły wskaźnik postępu (CircularProgressIndicator) pokazujący % zużycia oleju w kolorze zielonym
- listę przypomnień z ikonami i etykietami statusu (OK, Wkrótce, Pilne)
Użyj koloru głównego #2d6a4f.
```

### Prompt #2 — Powiadomienia push

```
Zaimplementuj w Flutter powiadomienia lokalne używając flutter_local_notifications.
Powiadomienie ma się uruchamiać gdy przebieg pojazdu jest mniejszy niż 1000 km od ustawionego progu wymiany.
Zaplanuj codzienne sprawdzanie w tle o godzinie 9:00.
Przykładowe powiadomienie:
- Tytuł: "Czas na wymianę oleju!"
- Treść: "Do kolejnej wymiany zostało Ci już tylko 800 km. Zadbaj o silnik!"
```

### Prompt #3 — Baza danych Hive

```
Stwórz w Flutter modele danych dla aplikacji serwisowej używając Hive. Potrzebuję:
1) Model Vehicle z polami: id, make, model, year, licensePlate, currentMileage, oilChangeMileage, oilChangeDate, oilChangeInterval
2) Model ServiceEntry z polami: id, vehicleId, date, mileage, serviceType, oilType, cost, notes
Wygeneruj adaptery Hive i pokaż jak zainicjować bazę w main.dart.
```

### Prompt #4 — Paywall RevenueCat

```
Zintegruj RevenueCat w Flutter. Stwórz ekran Paywall pokazujący:
- tytuł "OlejTo! Premium"
- listę 4 korzyści z ikonami checkmark
- przyciski dla planu miesięcznego (9,99 zł), rocznego (49,99 zł, oznaczony "Najpopularniejszy") i dożywotniego (149,99 zł)
Obsłuż zakup przez RevenueCat SDK i zapisz status premium w SharedPreferences.
```

---

## 9. Potencjalne problemy i rozwiązania

| Problem | Rozwiązanie |
|---|---|
| Nie mam Maca do iOS | Zacznij od Androida. iOS dodaj przez Codemagic (chmurowe buildy bez Maca). |
| Nie znam Dart / Flutter | AI pisze 80% kodu. Potrzebujesz rozumieć strukturę, nie znać składni na pamięć. |
| Aplikacja nie zarabia | Pierwsze 3 miesiące to normalnie zero. Liczy się ASO, opinie i aktualizacje co 2–3 tygodnie. |
| Konkurencja już istnieje | Sprawdź 1-gwiazdkowe recenzje konkurentów — to lista rzeczy do zrobienia lepiej. |
| Powiadomienia nie działają | Na Android 13+ wymagana osobna zgoda. Poproś o nią przy onboardingu. |
| Zakupy in-app nie przechodzą | RevenueCat ma tryb sandbox. Przetestuj cały flow przed publikacją. |
| Brak czasu | Jeden wieczór w tygodniu = 2h. W 3 miesiące weekendowo zrobisz MVP spokojnie. |

---

## 10. Roadmapa v2.0

### Krótkoterminowe (3–6 mies. po MVP)

- Synchronizacja danych w chmurze (Firebase Firestore)
- Dark mode
- Widget na ekran główny z aktualnym stanem oleju
- Import danych z CSV

### Długoterminowe (6–12 mies. po MVP)

- Wersja webowa (dashboard dla warsztatu w przeglądarce)
- Funkcja B2B — warsztat zaprasza klientów, klient widzi historię swojego auta
- Integracja z VIN decoder — autouzupełnianie danych po numerze VIN
- AI recommendations — "Przy 90 000 km sprawdź też rozrząd"
- White-label dla sieci warsztatów — dodatkowy strumień przychodów

---

## Podsumowanie

OlejTo! ma realny potencjał zarobkowy przy niskim koszcie wejścia. Nisza "przypomnienia serwisowe" nie jest nasycona w Polsce. Model freemium z subskrypcją to najlepszy balans między pozyskaniem użytkowników a monetyzacją.

Przy **100 płatnych użytkownikach rocznie** zarabiasz ~5 000 zł pasywnie.  
Czas budowy MVP: ~3 miesiące weekendowe.  
Koszt startu: ~100–500 zł.

---

*Plan stworzony dla: Bujak Apps*  
*Wygenerowano przez Claude · Anthropic · 2026*
