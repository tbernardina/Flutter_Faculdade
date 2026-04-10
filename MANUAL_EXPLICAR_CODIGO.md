# Manual rápido: como explicar este código

## 1) Resumo em 20 segundos

> "Este app Flutter ensina mapa astral com 4 abas e estado centralizado no `HomeShell`. Ele foi simplificado para ter 4 botões principais, mantendo o favorito da aba de signos." 

## 2) Onde está o controle de estado

No `_HomeShellState` estão os estados principais:
- aba selecionada
- modo completo/parcial
- filtro de elemento
- signos favoritos
- casas estudadas
- dados da leitura (Sol, Lua, Ascendente)
- estado do quiz

## 3) Os 4 botões principais do app

1. **Nova dica**: sorteia uma dica de estudo.
2. **Sortear signo**: atualiza o signo destaque.
3. **Marcar todas as casas visíveis**: marca checklist das casas da aba.
4. **Validar resposta**: confere resposta do quiz e gera feedback.

## 4) Favoritos da aba Signos

- Cada signo mantém um botão de coração (`IconButton`).
- O app salva/remover favorito usando `Set<String>`.

## 5) Roteiro para apresentar em sala

1. Mostrar navegação nas 4 abas.
2. Demonstrar os 4 botões principais.
3. Mostrar favorito na aba Signos.
4. Explicar que o estado fica no `HomeShell` e os filhos usam callbacks.
