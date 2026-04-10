# Mapa Astral Interativo (Flutter)

Aplicativo Flutter para estudo de mapa astral com interface simplificada.

## Estrutura atual (simplificada)

O app foi reduzido para **4 botões interativos principais**:

1. **Nova dica** (aba Início)
2. **Sortear signo** (aba Signos)
3. **Marcar todas as casas visíveis** (aba Casas)
4. **Validar resposta** (aba Leitura)

> O botão de **favorito da aba Signos** foi mantido em cada item da lista, conforme solicitado.

## Abas

### Início
- Switch para modo parcial/completo.
- Chips de interesse.
- Botão `Nova dica` para atualizar dica dinâmica.

### Signos
- Filtro por elemento.
- Botão `Sortear signo` para destaque do dia.
- Botão de coração para favoritar cada signo.

### Casas
- Botão único para marcar todas as casas visíveis.
- Marcação individual por checkbox.

### Leitura
- Dropdowns de Sol, Lua e Ascendente.
- Quiz rápido com botão `Validar resposta`.

## Controle de estado

O estado continua centralizado no `HomeShell` e é distribuído para as páginas via propriedades e callbacks.

## Como executar

```bash
flutter pub get
flutter run
```

## Como testar

```bash
flutter test
```

## Arquivos

- `lib/main.dart`
- `README.md`
- `MANUAL_EXPLICAR_CODIGO.md`
- `test/widget_test.dart`
