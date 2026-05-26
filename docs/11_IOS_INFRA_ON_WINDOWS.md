# 11 iOS Infra on Windows (Codemagic vs GitHub Actions)

Ten dokument opisuje jak budowac i wydawac iOS, gdy development robisz na Windows.

## TL;DR decyzja

- Wariant A (najprostszy start): Codemagic
- Wariant B (wieksza kontrola): GitHub Actions + macOS runner

Jesli celem jest najszybszy release iOS bez walki z infrastruktura, wybierz Wariant A.

## Decyzja dla OlejTo

- Wybrany wariant: B (GitHub Actions + macOS runner).
- Powod: pelna kontrola, lepsza skalowalnosc CI i jeden centralny pipeline w repo.

## Wymagania wspolne

- Konto Apple Developer Program (99 USD/rok)
- Konto App Store Connect
- Repo na GitHub
- Flutter projekt z poprawnym bundle id (np. com.bujakapps.olejto)
- Versioning w appce (build number rosnacy)

## Apple checklist (jednorazowa)

1. Utworz App ID w Apple Developer.
2. Utworz appke w App Store Connect.
3. Skonfiguruj certyfikaty i provisioning profile.
4. Przygotuj klucz API App Store Connect (Issuer ID, Key ID, private key).
5. Ustaw capability dla Push Notifications (jesli wymagane).

## Wariant A: Codemagic

## Kiedy wybrac

- Chcesz szybki start i najmniej konfiguracji.
- Nie chcesz utrzymywac wlasnego pipeline YAML od zera.

## Setup krok po kroku

1. Podlacz repo GitHub do Codemagic.
2. Wybierz workflow Flutter i platforme iOS.
3. Dodaj dane podpisywania:
   - certyfikat,
   - provisioning profile,
   - App Store Connect API key.
4. Ustaw build triggers na branch release/main.
5. Dodaj kroki:
   - flutter pub get
   - flutter test (opcjonalnie)
   - flutter build ipa --release
6. Wlacz upload do TestFlight.
7. Odpal pierwszy build i sprawdz status w TestFlight.

## Zalety

- Bardzo szybkie wdrozenie.
- Dobre UI do zarzadzania signingiem.
- Mniej DevOps do utrzymania.

## Wady

- Koszt moze rosnac wraz z liczba buildow.
- Mniejsza elastycznosc niz custom CI.

## Wariant B: GitHub Actions + macOS runner

## Kiedy wybrac

- Chcesz pelna kontrole pipeline.
- Zalezy Ci na standaryzacji CI pod caly projekt.

## Setup krok po kroku

1. Wlacz GitHub Actions w repo.
2. Dodaj sekrety:
   - APPSTORE_ISSUER_ID
   - APPSTORE_KEY_ID
   - APPSTORE_PRIVATE_KEY
   - MATCH_PASSWORD (jesli uzywasz fastlane match)
   - cert/provisioning jako secure files lub base64.
3. Utworz workflow iOS na runnerze macOS.
4. Kroki workflow:
   - checkout
   - setup Flutter
   - flutter pub get
   - flutter test
   - import cert/profiles
   - flutter build ipa --release
   - upload do TestFlight (fastlane pilot lub Transporter API)
5. Dodaj manual approval przed uploadem production.

## Zalety

- Maksymalna kontrola i audytowalnosc.
- Latwe laczenie z Android CI i testami.

## Wady

- Wieksza zlozonosc konfiguracji.
- Trzeba utrzymywac workflow i sekrety.

## Rekomendacja dla OlejTo

- Wybor finalny: Wariant B od razu.
- Wariant A zostaje jako plan awaryjny, gdyby byly blocker-y na signingu.

## Release flow iOS (praktyczny)

1. Merge do release branch.
2. CI buduje IPA.
3. Wysyłka do TestFlight.
4. Test wewnetrzny (min. 24h).
5. Poprawki, jesli potrzebne.
6. Submit do App Review.
7. Phased release na produkcji.

## Koszty orientacyjne

- Apple Developer: 99 USD/rok.
- Codemagic: zaleznie od planu i czasu buildow.
- GitHub Actions macOS: platne minuty runnera macOS.

## Ryzyka i zabezpieczenia

- Ryzyko: problemy z signingiem.
  - Zabezpieczenie: spisz raz procedury i trzymaj checklisty certyfikatow.
- Ryzyko: odrzut przez App Review.
  - Zabezpieczenie: wczesny test TestFlight + polityki prywatnosci.
- Ryzyko: rosnace koszty CI.
  - Zabezpieczenie: limity triggerow i nightly builds zamiast kazdego commita.

## Definition of Done dla iOS infra

1. Jednym kliknieciem uruchamiasz build iOS z CI.
2. Build automatycznie trafia do TestFlight.
3. Masz spisana procedure rotacji certyfikatow i kluczy.
4. Co najmniej 1 stabilny release iOS przeszedl przez pipeline end-to-end.
