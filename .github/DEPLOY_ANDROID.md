# Deploy Android - Play Store (Internal Test)

**Idioma:** este guia está em **português brasileiro (pt-BR)**.

## Pré-requisitos
- Alterações feitas e testadas no FlutterFlow
- Deploy iOS concluído na App Store (opcional, mas recomendado fazer junto)

## Passo a passo

### 1. Atualizar versão no FlutterFlow
**Dev Environments (variáveis de ambiente):**
- Acesse Settings and Integrations → Dev Environments
- Atualize as variáveis `version` e `versionDate`

**Versão do app:**
- Acesse Settings and Integrations → Mobile Deployment → Version
- Atualize `App Version` (Version Name) — confira o valor atual em `pubspec.yaml` (ex.: 1.1.59 → 1.1.60)
- Atualize `Build Number` (Version Code) — confira o valor atual em `pubspec.yaml` (ex.: 59 → 60)

### 2. Deploy iOS (App Store)
- No FlutterFlow, faça o deploy normal pela App Store
- Aguarde a confirmação de sucesso

### 3. Push para GitHub
- No FlutterFlow, clique no botão de push para GitHub (ícone do GitHub)
- Confirme o push para a branch `flutterflow`

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
- Mantenha `applicationId "com.cwrsiqueira.crp_app"` com underscore

**`android/app/src/main/AndroidManifest.xml`** → manter **current** (develop)
- Mantenha `package="com.cwrsiqueira.crp_app"` com underscore

No VS Code, use **"Accept Incoming Change"** no `version` do `pubspec.yaml`
e **"Accept Current Change"** nos demais conflitos.

### 6. Commit e push
```bash
git add .
git commit -m "merge: flutterflow - [descrição resumida das mudanças]"
git push origin develop
```

### 7. Acompanhar o build
- Acesse GitHub → aba Actions
- Aguarde o workflow "Deploy Android to Internal Test" concluir (~12 min)
- Verifique se o status ficou verde ✅

### 8. Testar na Play Store
- Acesse o Google Play Console → Teste interno
- Instale a nova versão no dispositivo
- Teste as funcionalidades alteradas

### 9. Promover para Produção (quando pronto)
- No Google Play Console, promova a versão de Teste interno → Produção

## Arquivos que NUNCA devem ser sobrescritos pela branch flutterflow
- `android/app/build.gradle` — applicationId com underscore
- `android/app/src/main/AndroidManifest.xml` — package com underscore
- `android/app/src/main/kotlin/com/cwrsiqueira/crp_app/MainActivity.kt`
- `.github/workflows/deploy_android.yml` — workflow do GitHub Actions
- `pubspec.yaml` → apenas o campo `dependency_overrides` (collection: 1.19.1)

## Observações
- "X commits ahead of and Y commits behind flutterflow" é normal e esperado
- O build leva aproximadamente 12 minutos para completar
- Faça o deploy iOS antes do push para o GitHub
- O campo `version` do `pubspec.yaml` é sempre atualizado pelo FlutterFlow