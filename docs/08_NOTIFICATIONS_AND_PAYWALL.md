# 08 Notifications and Paywall

## Powiadomienia

## Cele

- Przypominac odpowiednio wczesnie.
- Nie spamowac usera.

## Strategia triggerow

- Trigger date-based: np. 14 dni przed terminem.
- Trigger mileage-based: np. 1000 km przed progiem.
- Cooldown: nie wysylaj wiecej niz 1 powiadomienie/24h na pojazd.

## Scenariusze

1. Uzytkownik dodaje nowy wpis -> przelicz przypomnienia.
2. Uzytkownik zmienia prog km -> usun stare i ustaw nowe.
3. Uzytkownik wylacza notyfikacje -> anuluj wszystkie pending.

## Fail-safe

- Jesli brak uprawnienia notyfikacji, pokaz callout w dashboardzie.
- Na Android 13+ pros o zgode po onboardingu.
- Na iOS pros o zgode przy pierwszej wartosciowej akcji (np. po dodaniu auta).

## Paywall

## Free limity

- Max 1 pojazd
- Max 3 wpisy historii per pojazd (MVP mozna globalnie)
- Brak eksportu i dodatkowych funkcji premium

## Premium odblokowuje

- Nielimitowana liczba pojazdow
- Nielimitowana historia
- Zaawansowane raporty i dodatki

## Miejsca wejscia na paywall

- Proba dodania 2. pojazdu
- Proba dodania wpisu ponad limit
- Ustawienia -> sekcja Premium

## Metryki konwersji

- paywall_view
- paywall_cta_click
- purchase_success
- restore_success
