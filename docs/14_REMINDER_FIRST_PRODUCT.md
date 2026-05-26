# 14 Reminder-First Product Direction

## Glowna idea aplikacji

OlejTo ma byc aplikacja przypomnieniowa, ktora pomaga regularnie dbac o auto i unikac drogich napraw.

Haslo produktu:

- Olej to - dbaj regularnie, nie plac pozniej.

## Core value proposition

- Uzytkownik nie musi pamietac o terminach.
- Aplikacja sama pilnuje kluczowych terminow serwisowych.
- Wszystko jest podane jasno: co, kiedy, jak pilne.

## Priorytetowe typy przypomnien

1. Kontrola poziomu oleju (regularna, np. co 2-4 tygodnie)
2. Wymiana oleju (po km i/lub dacie)
3. Badanie okresowe (przeglad techniczny)
4. Badanie LPG (jesli auto ma LPG)

## Struktura produktu (MVP)

## Dashboard reminder-first

Dashboard ma pokazac przede wszystkim przypomnienia i pilnosc, a nie liste funkcji.

Sekcje:

1. Dzisiaj / W tym tygodniu
2. Pilne
3. Nadchodzace
4. Historia wykonanych przypomnien

## Karty przypomnien

Kazda karta powinna miec:

- typ przypomnienia
- pojazd
- termin (data/km)
- status pilnosci (OK/Wkrotce/Pilne)
- CTA: Oznacz jako wykonane

## Model danych przypomnien (prosty)

Reminder:

- id
- vehicleId
- type (oil_check|oil_change|inspection|lpg_inspection)
- dueDate
- dueMileage
- isCompleted
- completedAt
- intervalDays
- intervalKm
- notes

## Logika powiadomien

## Zasady default

1. Oil check: co 21 dni
2. Oil change: 1000 km przed progiem + 30 dni przed data
3. Badanie okresowe: 30 i 7 dni przed terminem
4. LPG: 45 i 14 dni przed terminem

## Ciche godziny i anti-spam

- Brak pushy w nocy (22:00-08:00)
- Max 1 push per vehicle per day
- Grupowanie przypomnien jednego dnia

## UX tone

Komunikaty maja byc:

- konkretne
- wspierajace
- bez straszenia

Przyklad:

- Czas sprawdzic olej w BMW E90. To 2 minuty i spokoj na kolejne tygodnie.

## Freemium i monetyzacja

## Free

- 1 pojazd
- 2 aktywne typy przypomnien (oil check + oil change)
- podstawowe powiadomienia
- historia do 30 dni

## Premium

- nieograniczona liczba pojazdow
- wszystkie typy przypomnien (w tym badanie okresowe i LPG)
- inteligentne harmonogramy i custom interwaly
- pelna historia i statystyki
- backup/export
- brak reklam

## Sugerowane ceny

- miesiecznie: 9.99 PLN
- rocznie: 49.99 PLN
- lifetime: 149.99 PLN

## Miejsca konwersji na premium

1. Dodanie 2. pojazdu
2. Proba wlaczenia badania okresowego/LPG
3. Proba wejscia do pelnej historii
4. Banner premium na dashboardzie

## Eventy analityczne (must-have)

- reminder_created
- reminder_completed
- reminder_snoozed
- reminder_push_opened
- paywall_view
- paywall_cta_click
- purchase_success

## Plan implementacji (kolejne sprinty)

## Sprint A

- model Reminder
- ekran listy przypomnien (Today/Upcoming/Overdue)
- oznaczanie jako wykonane

## Sprint B

- harmonogram push lokalnych
- konfiguracja interwalow per reminder
- reminder center na dashboardzie

## Sprint C

- freemium gates
- paywall
- podstawowa analityka produktu

## Definicja sukcesu MVP reminder-first

1. Uzytkownik dodaje auto i ustawia reminder w < 2 minuty.
2. Push przychodzi o czasie i da sie jednym kliknieciem oznaczyc jako wykonane.
3. W dashboardzie od razu widac co jest do zrobienia dzisiaj.
4. Free user rozumie wartosc premium bez irytacji.
