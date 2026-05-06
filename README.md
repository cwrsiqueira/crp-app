# Calculadora Renda Passiva (CRP)

App **Flutter** para calcular renda, juros, valor investido e apoiar o planejamento de aposentadoria. O código vem em grande parte do **FlutterFlow**, com ajustes mantidos na branch `develop` (por exemplo `dependency_overrides` e configuração Android com `applicationId` em underscore).

## Idioma (documentação e assistentes de IA)

Use **português brasileiro (pt-BR)** em toda documentação deste repositório e nas respostas de assistentes (Cursor, Copilot, etc.) ao trabalhar aqui. Regra do projeto: [.cursor/rules/portugues-brasileiro.mdc](.cursor/rules/portugues-brasileiro.mdc). Resumo para quem lê só o README: [AGENTS.md](AGENTS.md).

## Repositório e branches

| Branch        | Uso |
|---------------|-----|
| `flutterflow` | Push direto do FlutterFlow (origem). |
| `develop`     | Integração local: merge da `flutterflow`, resolução de conflitos e CI. |

Fluxo detalhado de merge e deploy: [.github/DEPLOY_ANDROID.md](.github/DEPLOY_ANDROID.md).

## Pacote e versão

- Nome do pacote no `pubspec.yaml`: `calculadora_renda_passiva`.
- Versão de release: campos `version` / build no `pubspec.yaml` (sincronizados com FlutterFlow no fluxo de deploy).

## Estrutura do código (`lib/`)

| Área | Descrição |
|------|-----------|
| `pages/` | Telas: calculadora, resultado, cálculos salvos, paywall, sobre, contato. |
| `componentes/` | Widgets reutilizáveis (ex.: paywall, confirmação de exclusão). |
| `flutter_flow/` | Tema, `go_router` (`nav/nav.dart`), utilitários e modelos FlutterFlow. |
| `backend/schema/` | Structs (ex.: resultados de cálculo). |
| `custom_code/actions/` | Ações Dart customizadas. |
| `app_state.dart` | Estado global (`FFAppState`) com persistência. |

## Stack relevante

- **Navegação:** `go_router`
- **Estado:** `provider`
- **Monetização:** RevenueCat (`purchases_flutter`), anúncios (`google_mobile_ads`)
- **Armazenamento local:** `shared_preferences`, `sqflite` (conforme dependências do `pubspec.yaml`)

## Manutenção local na `develop` (além do FlutterFlow)

Estes **arquivos** em `lib/` costumam ser alterados no export do FlutterFlow; após o merge, é recomendável **reaplicar ou revisar** alterações manuais se o diff apagar o que está documentado aqui:

| Arquivo | Nota |
|---------|------|
| `flutter_flow/revenue_cat_util.dart` | Compras com API atual do SDK: `Purchases.purchase(PurchaseParams.package(...))` (substitui `purchasePackage`, deprecado em `purchases_flutter` 9.x). |
| `flutter_flow/nav/serialization_util.dart` | `switch` em `ParamType` **exaustivo** (enum completo): sem ramo `default` redundante — exigência do analyzer Dart 3. |
| `app_state.dart` | Sem código morto (ex.: helpers privados não referenciados), para manter `dart analyze` limpo. |

## Execução local

```bash
flutter pub get
flutter run
```

## Documentação adicional

- [Deploy Android (Play Store — teste interno)](.github/DEPLOY_ANDROID.md)

## Arquivos que o merge da `flutterflow` não deve sobrescrever

Resumo (detalhes no guia de deploy): `android/app/build.gradle`, `AndroidManifest.xml`, `MainActivity.kt`, workflow em `.github/workflows/`, e o bloco `dependency_overrides` do `pubspec.yaml`.

## Estado e próximos passos (visão de produto / release)

1. **Versão atual** — ver `version` em `pubspec.yaml` (ex.: `1.1.54+54`); alinhar FlutterFlow + lojas conforme [.github/DEPLOY_ANDROID.md](.github/DEPLOY_ANDROID.md).
2. **Novo ciclo FlutterFlow** — push para `flutterflow` → merge em `develop` → resolver conflitos nos **arquivos** listados no guia de deploy e **revisar** a seção “Manutenção local” acima.
3. **Qualidade** — `flutter analyze` / testes antes de subir versão; após merge, validar paywall (RevenueCat) e **telas** críticas na build de internal test.
4. **Repo** — na raiz ainda podem aparecer artefatos locais não versionados (ex.: `.dart_tool/`, `pubspec.lock`); definir `.gitignore` de projeto e política de lockfile se a **equipe** quiser builds reproduzíveis entre máquinas.
