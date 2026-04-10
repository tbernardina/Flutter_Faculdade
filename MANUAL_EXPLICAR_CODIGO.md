# Manual: como explicar o código do app **Mapa Astral Interativo**

Este documento é um roteiro para você apresentar o projeto para professores, colegas ou recrutadores.

---

## 1) Pitch de 30 segundos

> "Este app em Flutter ensina fundamentos de mapa astral com navegação por abas e alto nível de interatividade. O estado é centralizado no `HomeShell`, e cada página recebe dados e callbacks para atualizar UI em tempo real." 

---

## 2) Estrutura geral para explicar

### 2.1 Entrada do app
- Arquivo principal: `lib/main.dart`.
- `main()` chama `runApp(const MapaAstralInterativoApp())`.
- `MapaAstralInterativoApp` configura tema, título e define `HomeShell` como tela inicial.

### 2.2 Camada de modelo (dados)
Explique que existem duas classes simples de domínio:
- `Signo` (`nome`, `elemento`, `traco`)
- `CasaAstral` (`numero`, `tema`, `resumo`)

Essas classes mantêm o código organizado e evitam arrays soltos sem significado.

### 2.3 Estado global da interface
No `HomeShell` (StatefulWidget) ficam os estados compartilhados:
- navegação (`_paginaAtual`)
- modo de conteúdo (`_modoCompleto`)
- filtros e seleções (ex.: `_elementoFiltro`, `_interesses`)
- progresso (`_progressoEstudo`, `_sequenciaDias`)
- controles de estudo (`_casasEstudadas`, `_signosFavoritos`)
- quiz (`_respostaQuizSelecionada`, `_acertosQuiz`, `_feedbackQuiz`)

Mostre que o app usa **state lifting**:
- o estado fica no pai (`HomeShell`)
- os filhos recebem dados + callbacks para atualizar esse estado.

---

## 3) Como explicar cada página

### 3.1 Início (`InicioInterativoPage`)
Pontos para comentar:
- Botões de ação rápida: **Concluir sessão** e **Resetar**.
- `SwitchListTile` para modo parcial/completo.
- `FilterChip` para interesses.
- `Slider` para progresso.
- botão **Nova dica** para conteúdo dinâmico.

Dica de fala:
> "A página de início funciona como painel de controle do estudo. Quase tudo aqui altera estado global que impacta as demais abas." 

### 3.2 Signos (`SignosInterativoPage`)
Pontos para comentar:
- botão **Sortear** para destacar um signo.
- filtros por elemento com `ChoiceChip`.
- favoritos com `IconButton` de coração por item.

Dica de fala:
> "Aqui eu demonstro filtragem de lista e atualização condicional da interface com base no estado." 

### 3.3 Casas (`CasasInterativoPage`)
Pontos para comentar:
- botões em lote: **Marcar todas** e **Limpar seleção**.
- cada casa abre em `ExpansionTile`.
- `CheckboxListTile` para registrar estudo por casa.

Dica de fala:
> "Essa página mostra controle de estado por coleção (`Set<int>`) e operações individuais e em lote." 

### 3.4 Leitura (`LeituraInterativaPage`)
Pontos para comentar:
- 3 dropdowns (Sol, Lua, Ascendente).
- geração de resumo com base nas escolhas.
- quiz com `RadioListTile`, validação e pontuação acumulada.

Dica de fala:
> "É a aba mais orientada a lógica: combina entradas do usuário, personaliza texto e aplica regra de validação no quiz." 

---

## 4) Como explicar o fluxo de estado

Use esse roteiro:
1. Usuário clica em um botão/chip/switch.
2. Callback sobe para `HomeShell`.
3. `setState` atualiza variável.
4. Flutter reconstrói widgets afetados.
5. Interface mostra o novo estado imediatamente.

Esse padrão aparece no app inteiro e é ótimo para explicar Flutter básico/intermediário.

---

## 5) Perguntas comuns e respostas prontas

### "Por que usar `Set` em vez de `List` para favoritos/marcações?"
Porque `Set` evita duplicidade automaticamente e permite consulta eficiente com `contains`.

### "Por que tudo está em um arquivo?"
Para didática inicial. Em produção, o ideal é separar por:
- `models/`
- `pages/`
- `widgets/`
- `controllers`/`state`.

### "Como escalar esse estado?"
Pode migrar para Provider, Riverpod ou Bloc quando o projeto crescer.

---

## 6) Sugestão de apresentação em 5 minutos

1. **30s**: objetivo do app.
2. **1 min**: arquitetura e estado no `HomeShell`.
3. **2 min**: navegação nas 4 abas com demo de interações.
4. **1 min**: explicar quiz e personalização da leitura.
5. **30s**: melhorias futuras (persistência local e separação em múltiplos arquivos).

---

## 7) Melhorias futuras para mencionar

- Persistir progresso/favoritos com `shared_preferences`.
- Separar cada tela em arquivo próprio.
- Adicionar testes de interação (tap em botões e validação do quiz).
- Internacionalização (PT/EN).

