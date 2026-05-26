# 12 GitHub Actions iOS Runbook

Ten runbook wdraza wariant 2: GitHub Actions + macOS runner.

## 1. Co ten pipeline robi

1. Buduje Flutter iOS na runnerze macOS.
2. Podpisuje appke certyfikatem i provisioning profile.
3. Generuje IPA.
4. Wysyla build do TestFlight.

Workflow jest w pliku [.github/workflows/ios-testflight.yml](.github/workflows/ios-testflight.yml).

## 2. Sekrety wymagane w GitHub

Ustaw w repo -> Settings -> Secrets and variables -> Actions:

1. IOS_CERTIFICATE_P12_BASE64
2. IOS_CERTIFICATE_PASSWORD
3. IOS_PROVISIONING_PROFILE_BASE64
4. IOS_TEAM_ID
5. IOS_BUNDLE_ID
6. IOS_PROFILE_NAME
7. APPSTORE_KEY_ID
8. APPSTORE_ISSUER_ID
9. APPSTORE_PRIVATE_KEY_BASE64

## 3. Jak wygenerowac sekrety

### Certyfikat p12 -> base64

Na Mac:

```bash
base64 -i cert.p12 | pbcopy
```

Wklej do secretu IOS_CERTIFICATE_P12_BASE64.

### Provisioning profile -> base64

```bash
base64 -i profile.mobileprovision | pbcopy
```

Wklej do IOS_PROVISIONING_PROFILE_BASE64.

### App Store Connect API key p8 -> base64

```bash
base64 -i AuthKey_XXXXXX.p8 | pbcopy
```

Wklej do APPSTORE_PRIVATE_KEY_BASE64.

## 4. Pierwsze uruchomienie

1. Wrzuc workflow do repo.
2. Wejdz w GitHub Actions.
3. Odpal workflow recznie przez workflow_dispatch.
4. Sprawdz, czy build pojawil sie w TestFlight.

## 5. Najczestsze problemy

1. Signing/provisioning mismatch:
- Sprawdz, czy IOS_BUNDLE_ID zgadza sie z profilem.
- Sprawdz Team ID.

2. Brak IPA po buildzie:
- Sprawdz, czy flutter build ipa przeszedl bez warningow signingu.

3. Upload do TestFlight nie przechodzi:
- Sprawdz APPSTORE_KEY_ID, APPSTORE_ISSUER_ID, private key.
- Potwierdz uprawnienia klucza API w App Store Connect.

## 6. Definition of Done

1. Workflow przechodzi na branchu main/release.
2. IPA laduje sie do TestFlight.
3. Build jest widoczny dla testerow wewnetrznych.
