# 06 AI Workflow (ChatGPT + Claude + VS Code)

## Cel

Uzywac AI jako multiplikatora predkosci, nie jako zastepstwa decyzji produktowych.

## Podzial rol AI

- ChatGPT: szybkie scaffoldy kodu, poprawki, refactor, test-cases.
- Claude: dlugie planowanie, przeglady architektury, edge-case review.
- VS Code Copilot Chat: iteracje in-file, debug i szybkie fixy.

## Pipeline pracy na task

1. Opis taska: cel, wejscie, wyjscie, kryteria DONE.
2. Prompt do AI o implementacje kroku 1 (malego).
3. Wklejenie kodu i uruchomienie appki.
4. Debug i poprawki.
5. Commit.

## Prompt template (uniwersalny)

```text
Context:
Buduje aplikacje Flutter OlejTo.
Aktualny modul: <module_name>.

Task:
<co ma byc zrobione>

Constraints:
- zachowaj obecna architekture feature-based
- nie ruszaj niepowiazanych plikow
- dodaj walidacje i obsluge bledow

Output:
- lista zmienionych plikow
- kod gotowy do wklejenia
- krotka lista testow manualnych
```

## Prompt template (debug)

```text
Mam blad w Flutter:
<wklej stacktrace>

Daj mi:
1) root cause,
2) minimalny fix,
3) jak sprawdzic, ze blad zniknal,
4) jak zapobiec regresji.
```

## Zasady bezpieczenstwa

- Nigdy nie merguj kodu AI bez odpalenia appki.
- Nie rob wielkich zmian w jednym prompt.
- Kazdy prompt ma jedno zadanie.
- Po kazdej wiekszej zmianie zapisuj decyzje w dokumentacji.
