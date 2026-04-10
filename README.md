# Mapa Astral Interativo (Flutter)

Aplicativo Flutter para estudo de mapa astral com múltiplos botões interativos, controle de estado e leitura personalizada.

## Funcionalidades principais

- Navegação por 4 abas: **Início**, **Signos**, **Casas** e **Leitura**.
- Controle de estado central no `HomeShell`.
- Modo **parcial** e **completo** de conteúdo.
- Ações interativas com botões, chips, slider, dropdown, checkbox e quiz.

## Interações por página

### Início
- Botão **Concluir sessão** (incrementa sequência e progresso).
- Botão **Resetar** (limpa progresso e marcações).
- Botão **Mostrar/Ocultar resumo técnico**.
- Botão **Nova dica** com conteúdo randômico.
- `FilterChip` de interesses + `Slider` de progresso.

### Signos
- Botão **Sortear** para definir signo destaque.
- `ChoiceChip` para filtrar por elemento.
- Botão de coração por item para favoritar signo.

### Casas
- Botão **Marcar todas**.
- Botão **Limpar seleção**.
- `ExpansionTile` com `CheckboxListTile` para acompanhamento de estudo.

### Leitura
- Dropdowns de **Signo solar**, **Signo lunar** e **Ascendente**.
- Resumo textual automático com base nas seleções.
- Quiz com `RadioListTile` + botões **Validar resposta** e **Resetar quiz**.

## Manual para explicar o código

Além deste README, foi criado um guia dedicado:

- **`MANUAL_EXPLICAR_CODIGO.md`**

Esse documento traz um roteiro de apresentação, explicação de arquitetura, fluxo de estado e respostas prontas para perguntas comuns.

## Como executar

```bash
flutter pub get
flutter run
```

## Como testar

```bash
flutter test
```

## Arquivos principais

- `lib/main.dart`: app completo.
- `MANUAL_EXPLICAR_CODIGO.md`: guia para explicar o código.
- `test/widget_test.dart`: teste básico do shell.
