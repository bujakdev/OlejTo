# 04 Implementation Plan (12 Weeks)

## Tydzien 1

- Setup Flutter + Android + iOS toolchain
- Konfiguracja projektu i struktury folderow
- Theme, routing, shell app
- DONE: app uruchamia sie na emulatorze Android i symulatorze iOS

## Tydzien 2

- Feature vehicles: CRUD pojazdu
- Formularz z walidacja
- Lista pojazdow i szczegoly
- DONE: zapis i odczyt z Hive

## Tydzien 3

- Feature services: wpis serwisowy
- Historia wpisow
- Powiazanie wpisow z pojazdem
- DONE: filtrowanie historii po pojezdzie

## Tydzien 4

- Logika statusu oleju (OK/Wkrotce/Pilne)
- Dashboard i ring progress
- Priorytet przypomnien
- DONE: status poprawnie liczony dla danych testowych

## Tydzien 5

- flutter_local_notifications
- Harmonogram przypomnien po dacie
- DONE: notyfikacja pojawia sie na Android i iOS

## Tydzien 6

- Logika przypomnien po przebiegu
- Ekran ustawien przypomnien
- DONE: dynamiczna aktualizacja triggerow

## Tydzien 7

- Freemium gate (1 auto free, limit historii)
- Ekran paywall mock
- DONE: ograniczenia dzialaja bez crashy

## Tydzien 8

- Integracja RevenueCat (sandbox Android + iOS)
- Flaga premium
- DONE: testowy zakup i restore na obu platformach

## Tydzien 9

- Stabilizacja UI/UX
- Empty/loading/error states
- DONE: wszystkie flow bez blockerow P0

## Tydzien 10

- QA regresja manualna
- Naprawa bugow
- DONE: crash-free test run na min. 2 urzadzeniach Android i 1 iPhone

## Tydzien 11

- Przygotowanie store assets (Google Play + App Store)
- Opis sklepu i screenshoty dla obu platform
- DONE: draft release Android i iOS gotowy

## Tydzien 12

- Release Android + iOS (phased rollout)
- Monitoring pierwszych opinii i crashy
- DONE: hotfix window 7 dni po publikacji

## Zasada execution

- Kazdy tydzien konczy sie buildem release i checklista PASS/FAIL.
- Brak przejscia do kolejnego tygodnia z otwartym blockerem P0.
