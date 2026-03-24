# Guia do Mapa Astral (Flutter)

Aplicativo Flutter educativo para ensinar **mapa astral** de forma **parcial ou completa**.

## Objetivo do app

Este projeto foi feito para explicar os fundamentos da astrologia natal de forma didática:

- Signos e elementos.
- Casas astrais.
- Leitura básica (Sol, Lua e Ascendente).
- Leitura completa com planetas pessoais e sociais.

## Como executar

1. Instale o Flutter SDK.
2. Na raiz do projeto, rode:

```bash
flutter pub get
flutter run
```

## Como cada página funciona

### 1) Introdução
- Classe: `IntroducaoPage`.
- Apresenta o que é mapa astral.
- Possui um `Switch` para alternar entre:
  - **Modo parcial**: conteúdo essencial.
  - **Modo completo**: conteúdo mais aprofundado.
- Esse estado fica no `HomeShell` (`_modoCompleto`) e afeta as outras páginas.

### 2) Signos
- Classe: `SignosPage`.
- Lista os **12 signos** com resumo de características.
- Também mostra o elemento de cada signo (Fogo, Terra, Ar, Água).

### 3) Casas
- Classe: `CasasPage`.
- No modo parcial exibe as **6 primeiras casas**.
- No modo completo exibe as **12 casas astrais**.
- Cada card mostra número da casa, tema e explicação objetiva.

### 4) Leitura
- Classe: `LeituraPage`.
- Monta um roteiro de interpretação do mapa:
  - Sempre: Sol, Lua e Ascendente.
  - No modo completo: inclui Mercúrio, Vênus, Marte, Júpiter e Saturno.

## Navegação

- O app usa `NavigationBar` com 4 abas: Introdução, Signos, Casas e Leitura.
- A troca de telas ocorre no `HomeShell` pelo índice `_paginaAtual`.
- Foi usado `AnimatedSwitcher` para transição suave entre as páginas.

## Estrutura

- `lib/main.dart`: app completo (tema, modelos, estado e páginas).
- `test/widget_test.dart`: teste de renderização inicial.
- `pubspec.yaml`: metadados e dependências do projeto.
