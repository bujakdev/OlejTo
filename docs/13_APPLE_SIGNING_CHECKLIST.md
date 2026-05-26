# 13 Apple Signing Checklist (GitHub Actions)

Ten dokument to praktyczna checklista Apple Signing pod pipeline GitHub Actions i upload do TestFlight.

## Cel

Dostarczyc komplet danych do sekretow GitHub tak, aby workflow iOS przeszedl end-to-end.

## A. Przygotowanie kont

1. Potwierdz aktywne Apple Developer Program.
2. Potwierdz dostep do App Store Connect z rola App Manager lub Admin.
3. Potwierdz, ze aplikacja istnieje w App Store Connect.

## B. App ID i Bundle ID

1. Wejdz w Apple Developer -> Certificates, Identifiers & Profiles -> Identifiers.
2. Utworz nowy App ID typu App.
3. Ustaw Bundle ID identyczny z projektem Flutter (np. com.bujakapps.olejto).
4. Wlacz wymagane capabilities (minimum podstawowe; Push tylko jesli potrzebne).

## C. Certyfikat dystrybucyjny

1. Na Mac utworz CSR w Keychain Access.
2. W Apple Developer -> Certificates utworz certyfikat Apple Distribution.
3. Pobierz certyfikat i zainstaluj do Keychain.
4. Wyeksportuj certyfikat jako plik p12 z haslem.

## D. Provisioning Profile (App Store)

1. W Apple Developer -> Profiles utworz profil typu App Store.
2. Wybierz poprawny App ID.
3. Wybierz certyfikat Apple Distribution.
4. Wygeneruj i pobierz plik profile.mobileprovision.

## E. App Store Connect API Key

1. Wejdz w App Store Connect -> Users and Access -> Keys.
2. Utworz klucz API (App Manager wystarczy).
3. Zapisz Issuer ID.
4. Zapisz Key ID.
5. Pobierz plik AuthKey_XXXXXX.p8.

## F. Konwersja do base64 (na Mac)

```bash
base64 -i cert.p12 | pbcopy
base64 -i profile.mobileprovision | pbcopy
base64 -i AuthKey_XXXXXX.p8 | pbcopy
```

## G. Sekrety GitHub do ustawienia

1. IOS_CERTIFICATE_P12_BASE64
2. IOS_CERTIFICATE_PASSWORD
3. IOS_PROVISIONING_PROFILE_BASE64
4. IOS_TEAM_ID
5. IOS_BUNDLE_ID
6. IOS_PROFILE_NAME
7. APPSTORE_KEY_ID
8. APPSTORE_ISSUER_ID
9. APPSTORE_PRIVATE_KEY_BASE64

## H. Jak pobrac IOS_TEAM_ID i IOS_PROFILE_NAME

1. IOS_TEAM_ID:
- Xcode -> Settings -> Accounts -> Team ID.

2. IOS_PROFILE_NAME:
- Otworz profil w Apple Developer i skopiuj pole Name.
- Musi byc identyczne jak profil wybrany dla App Store distribution.

## I. Kontrola spojnosci przed pierwszym runem

1. IOS_BUNDLE_ID zgadza sie z App ID.
2. Provisioning profile jest typu App Store, nie Development.
3. Certyfikat to Apple Distribution, nie Apple Development.
4. APPSTORE_KEY_ID i APPSTORE_ISSUER_ID sa z tego samego klucza API.
5. Numer wersji i build number w appce sa zwiekszone.

## J. Pierwszy test end-to-end

1. Commit do brancha release lub odpal workflow recznie.
2. Sprawdz, czy workflow generuje IPA.
3. Sprawdz upload do TestFlight.
4. Potwierdz widocznosc builda w App Store Connect -> TestFlight.

## K. Najczestsze bledy i szybkie fixy

1. No signing certificate found:
- bledny p12 albo haslo do p12.

2. No provisioning profile matches bundle identifier:
- profil nie pasuje do IOS_BUNDLE_ID.

3. Authentication failed at Transporter:
- zly APPSTORE_KEY_ID, APPSTORE_ISSUER_ID lub private key.

4. Invalid binary:
- niespojne capabilities/provisioning albo metadane aplikacji.

## Definition of Done

1. Workflow przechodzi w GitHub Actions bez manualnych poprawek.
2. Build jest dostepny w TestFlight dla testerow wewnetrznych.
3. Checklista jest zapisana i powtarzalna dla kolejnych releasow.
