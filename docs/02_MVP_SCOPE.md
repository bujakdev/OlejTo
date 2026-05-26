# 02 MVP Scope

## In Scope (MVP)

- Onboarding prosty (1-2 ekrany)
- Dashboard ze statusem serwisu
- Dodawanie/edycja/usuwanie pojazdu
- Dodawanie wpisu serwisowego
- Historia wpisow
- Lokalne przypomnienia (data + prog km)
- Prosty paywall logiczny (feature gate bez finalnej platnosci)
- Ustawienia podstawowe

## Out of Scope (po MVP)

- OCR paragonow
- PDF export
- Synchronizacja cloud
- Web dashboard
- Integracja VIN decoder
- Rozbudowana analityka wydatkow

## User Stories MVP

1. Jako kierowca chce dodac auto, aby monitorowac terminy wymiany.
2. Jako kierowca chce dodac wpis serwisowy, aby miec historie.
3. Jako kierowca chce zobaczyc status oleju, aby wiedziec czy musze dzialac.
4. Jako kierowca chce dostac przypomnienie, aby nie przegapic wymiany.
5. Jako user free chce widziec ograniczenia i opcje premium.

## Kryteria akceptacji

- Kazda user story ma test manualny i status PASS.
- Brak blockerow P0/P1 przed wydaniem.
- Czas startu appki < 3 sek na srednim telefonie Android.
