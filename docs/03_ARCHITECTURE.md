# 03 Architecture

## Technologia

- Flutter (Dart)
- State management: Riverpod
- Lokalna baza: Hive
- Powiadomienia: flutter_local_notifications
- Subskrypcje: RevenueCat (po etapie MVP-core)

## Struktura projektu

```text
lib/
  core/
    config/
    constants/
    errors/
    utils/
  features/
    vehicles/
      data/
      domain/
      presentation/
    services/
      data/
      domain/
      presentation/
    reminders/
      data/
      domain/
      presentation/
    paywall/
      presentation/
  shared/
    widgets/
    theme/
  app.dart
  main.dart
```

## Zasady architektury

- Domain nie zna frameworka UI.
- Data layer odpowiada za repozytoria i lokalny storage.
- Presentation korzysta z use case i providerow.
- Kazdy feature ma niezalezny modul.

## Kontrakt warstw

- Presentation -> Domain: tylko use case i modele domenowe.
- Domain -> Data: interfejs repozytorium.
- Data -> Domain: implementacja repo i mapowanie modeli.

## Kodowanie i jakosc

- Preferencja: male pliki i male widgety.
- Jedna odpowiedzialnosc na klase.
- Nazwy po angielsku, opisy i dokumentacja po polsku.
- Komentarze tylko tam, gdzie logika nie jest oczywista.
