# 05 Environment Setup (VS Code)

## Narzedzia

- VS Code
- Flutter SDK (stable)
- Android Studio (SDK + emulator)
- Xcode (dla iOS)
- CocoaPods (dla iOS)
- Git
- JDK 17

## Rozszerzenia VS Code

- Dart
- Flutter
- Error Lens (opcjonalnie)
- GitLens (opcjonalnie)

## Minimalna konfiguracja lokalna

1. Zainstaluj Flutter SDK i dodaj do PATH.
2. Zainstaluj Android Studio i pobierz Android SDK.
3. Uruchom `flutter doctor` i napraw wszystkie czerwone pozycje.
4. Utworz emulator Pixel (API 34 lub nowszy).

## Konfiguracja iOS

1. iOS build lokalnie wymaga macOS + Xcode.
2. Zaloguj Apple ID w Xcode i skonfiguruj certyfikaty/signing.
3. Zainstaluj CocoaPods i uruchom `pod repo update`.
4. Uruchom `flutter doctor` i doprowadz sekcje iOS do zielonego stanu.
5. Utworz symulator iPhone (najnowszy iOS).

Jesli pracujesz na Windows, kod piszesz normalnie, a build iOS robisz przez:

- Mac (lokalny lub zdalny)
- Codemagic / CI z runnerem macOS

## Komendy startowe

```bash
flutter create olejto
cd olejto
flutter pub get
flutter run
```

## Buildy

```bash
flutter build apk --release
flutter build appbundle --release
flutter build ipa --release
```

## Branching i commity

- main: stabilny kod gotowy do release
- dev: praca biezaca
- feature/*: nowe funkcje

Konwencja commitow:

- feat: nowa funkcja
- fix: bugfix
- refactor: zmiana bez zmiany zachowania
- docs: dokumentacja
- chore: maintenance

## Definition of Ready dla taska

- User story jasno opisana
- Kryteria akceptacji wpisane
- Brak nierozwiazanych zaleznosci

## Definition of Done dla taska

- Kod dziala lokalnie
- Brak bledow analyzer
- Test manualny PASS
- Dla feature cross-platform: test Android + iOS PASS
- Commit z czytelnym opisem
