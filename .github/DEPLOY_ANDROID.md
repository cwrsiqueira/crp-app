# Deploy Android - Play Store (Internal Test)

## Pré-requisitos
- Alterações feitas e testadas no FlutterFlow
- Build iOS deployada (opcional, mas recomendado fazer junto)

## Passo a passo

### 1. Atualizar versão no FlutterFlow
**Dev Environments (variáveis de ambiente):**
- Ir em Settings and Integrations → Dev Environments
- Atualizar as variáveis `version` e `versionDate`

**Versão do app:**
- Ir em Settings and Integrations → Mobile Deployment → Version
- Atualizar `App Version` (Version Name) — conferir o valor atual em `pubspec.yaml` (ex.: 1.1.54 → 1.1.55)
- Atualizar `Build Number` (Version Code) — conferir o valor atual em `pubspec.yaml` (ex.: 54 → 55)

### 2. Deploy iOS (App Store)
- No FlutterFlow, fazer deploy normal pela App Store
- Aguardar confirmação de sucesso

### 3. Push para GitHub
- No FlutterFlow, clicar no botão de push para GitHub (ícone do GitHub)
- Confirmar push para branch `flutterflow`

### 4. Merge no terminal (VS Code)
```bash
git checkout develop
git fetch origin
git merge origin/flutterflow
```

> **Atenção:** Se o terminal abrir um editor de texto (vim) pedindo uma mensagem de commit,
> digite `:wq` e pressione Enter para confirmar e fechar.

### 5. Resolver conflitos
Os conflitos sempre ocorrem nos mesmos arquivos:

**`pubspec.yaml`**
- Campo `version` → manter **incoming** (FlutterFlow) — é a versão atualizada
- Campo `dependency_overrides` → manter **current** (develop) — não existe no FlutterFlow

**`android/app/build.gradle`** → manter **current** (develop)
- Mantém `applicationId "com.cwrsiqueira.crp_app"` com underscore

**`android/app/src/main/AndroidManifest.xml`** → manter **current** (develop)
- Mantém `package="com.cwrsiqueira.crp_app"` com underscore

No VS Code, use **"Accept Incoming Change"** para o `version` do pubspec.yaml
e **"Accept Current Change"** para todos os demais conflitos.

### 6. Commit e push
```bash
git add .
git commit -m "merge: flutterflow - [descrição resumida das mudanças]"
git push origin develop
```

### 7. Acompanhar o build
- Acessar GitHub → aba Actions
- Aguardar o workflow "Deploy Android to Internal Test" concluir (~12 min)
- Verificar se status ficou verde ✅

### 8. Testar na Play Store
- Acessar Google Play Console → Teste interno
- Instalar a nova versão no dispositivo
- Testar as funcionalidades alteradas

### 9. Promover para Produção (quando pronto)
- No Google Play Console, promover a versão de Teste interno → Produção

## Arquivos que NUNCA devem ser sobrescritos pela branch flutterflow
- `android/app/build.gradle` — applicationId com underscore
- `android/app/src/main/AndroidManifest.xml` — package com underscore
- `android/app/src/main/kotlin/com/cwrsiqueira/crp_app/MainActivity.kt`
- `.github/workflows/deploy_android.yml` — workflow do GitHub Actions
- `pubspec.yaml` → apenas o campo `dependency_overrides` (collection: 1.19.1)

## Observações
- "X commits ahead of and Y commits behind flutterflow" é normal e esperado
- O build leva aproximadamente 12 minutos para completar
- Sempre fazer o deploy iOS antes do push para GitHub
- O campo `version` do pubspec.yaml é sempre atualizado pelo FlutterFlow