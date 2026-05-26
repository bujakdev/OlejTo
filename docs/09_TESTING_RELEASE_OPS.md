# 09 Testing, Release, Ops

## Strategia testow

## Testy manualne (MVP)

1. Dodanie pojazdu z poprawnymi danymi.
2. Walidacja dla pustych pol.
3. Dodanie wpisu serwisowego.
4. Poprawne wyliczenie statusu oleju.
5. Dzialanie powiadomienia na urzadzeniu.
6. Ograniczenia free i wejscie na paywall.

## Testy automatyczne (minimum)

- unit: kalkulacja statusu oleju
- unit: walidacja formularzy
- widget: render dashboard i listy historii

## Lista pre-release

- flutter analyze bez bledow
- build apk release przechodzi
- build ipa release przechodzi
- test na min. 2 urzadzeniach Android
- test na min. 1 urzadzeniu iOS
- brak blockerow P0/P1
- teksty i lokalizacja sprawdzone

## Publikacja Android

1. Przygotuj app bundle.
2. Wgraj do Google Play Console (internal testing).
3. Zbierz feedback i crash report.
4. Wydaj production po 24-72h stabilnosci.

## Publikacja iOS

1. Przygotuj build iOS i wgraj do TestFlight.
2. Przejdz testy wewnetrzne na TestFlight.
3. Uzupelnij metadane App Store (opis, screenshoty, privacy).
4. Wyslij do App Review i uruchom phased release.

## Monitoring po wydaniu

- Crash rate
- ANR rate
- uninstall trend
- retention D1/D7

## Incident flow

1. Potwierdz reprodukcje.
2. Oznacz priorytet (P0-P3).
3. Hotfix branch.
4. Release patch.
5. Notatka postmortem w docs.
