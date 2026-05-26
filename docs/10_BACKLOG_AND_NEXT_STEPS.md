# 10 Backlog and Next Steps

## Backlog P1 (po MVP)

- OCR paragonow
- PDF eksport historii
- Chmura (sync miedzy urzadzeniami)
- Rozszerzone statystyki kosztow
- iOS release

## Backlog P2

- VIN decoder
- Wersja webowa dla warsztatu
- Multi-user workspace (warsztat + klienci)
- White-label

## Backlog techniczny

- CI/CD dla buildow Android
- Testy integracyjne
- Feature flags dla eksperymentow

## Najblizsze 14 dni (operacyjnie)

1. Day 1-2: setup i skeleton app
2. Day 3-5: CRUD vehicles
3. Day 6-8: service entries + history
4. Day 9-10: status engine oil + dashboard
5. Day 11-12: local notifications
6. Day 13: free limits + paywall mock
7. Day 14: stabilizacja i release candidate

## Decyzje architektoniczne (ADR mini)

- Wybor Flutter i Riverpod ze wzgledu na szybkosc MVP.
- Offline-first na Hive z pozniejsza mozliwoscia sync.
- RevenueCat dopiero po stabilnym core.

## Ryzyka i plan B

- Ryzyko: opoznienia przez konfiguracje Android.
  - Plan B: odpalic minimalny build i iterowac funkcje po jednej.
- Ryzyko: niedzialajace notyfikacje na wybranych modelach.
  - Plan B: fallback przypomnienia date-based + ekran ostrzezen.
- Ryzyko: zbyt szeroki scope.
  - Plan B: zamrozic backlog P1/P2 i dowiezc tylko MVP core.
