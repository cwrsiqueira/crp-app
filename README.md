# Calculadora Renda Passiva (CRP)

App **Flutter** para calcular renda, juros, valor investido e apoiar o planejamento de aposentadoria. O código vem em grande parte do **FlutterFlow**, com ajustes mantidos na branch `develop` (por exemplo `dependency_overrides` e configuração Android com `applicationId` em underscore).

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

## Execução local

```bash
flutter pub get
flutter run
```

## Documentação adicional

- [Deploy Android (Play Store — teste interno)](.github/DEPLOY_ANDROID.md)

## Arquivos que o merge da `flutterflow` não deve sobrescrever

Resumo (detalhes no guia de deploy): `android/app/build.gradle`, `AndroidManifest.xml`, `MainActivity.kt`, workflow em `.github/workflows/`, e o bloco `dependency_overrides` do `pubspec.yaml`.
