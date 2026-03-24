# Roteiro Estelar (Flutter)

Aplicativo Flutter com tema espacial para praticar navegação entre páginas, estado local e organização de interface.

## Tema

O tema escolhido foi **turismo espacial**. O usuário consegue visualizar destinos, marcar favoritos e acompanhar um perfil de viajante.

## Como executar

1. Instale o Flutter SDK (canal estável) e verifique com:
   ```bash
   flutter --version
   ```
2. Na raiz do projeto, execute:
   ```bash
   flutter pub get
   flutter run
   ```

## Estrutura principal

- `lib/main.dart`: contém toda a estrutura do app (modelo de dados, shell com navegação inferior e páginas).
- `test/widget_test.dart`: teste básico de renderização.

## Explicação de como cada página funciona

### 1) Página **Início**
- Classe: `InicioPage`.
- Mostra um card de destaque com mensagem de boas-vindas.
- Exibe um resumo com a quantidade de destinos disponíveis.
- Mostra dois destinos em formato de lista (preview), incluindo nome, descrição e preço.

### 2) Página **Destinos**
- Classe: `DestinosPage`.
- Renderiza todos os destinos via `ListView.builder`.
- Cada item possui botão de coração para adicionar/remover favorito.
- O estado de favoritos é controlado no `HomeShell` pelo método `_alternarFavorito`.

### 3) Página **Favoritos**
- Classe: `FavoritosPage`.
- Filtra a lista total de destinos para exibir apenas os que estão salvos no conjunto `_favoritos`.
- Se o usuário ainda não favoritou nada, aparece uma mensagem de estado vazio.

### 4) Página **Perfil**
- Classe: `PerfilPage`.
- Mostra avatar, nome de viajante e dados estáticos (viagens concluídas e pontuação).
- É uma página informativa para centralizar indicadores do usuário.

## Como a navegação funciona

- A navegação é feita por uma `NavigationBar` no `Scaffold` principal (`HomeShell`).
- O índice selecionado (`_paginaAtual`) define qual widget será exibido no corpo (`body`).
- O conteúdo da página é trocado com `AnimatedSwitcher` para uma transição suave.

## Gerenciamento de estado

- Foi usado **estado local** com `StatefulWidget` no `HomeShell`.
- Lista de destinos: `_destinos` (imutável).
- Favoritos: `_favoritos` (`Set<String>`) para evitar duplicidades.

## Versionamento por branch

Conforme solicitado, as versões do projeto ficam separadas por branch:

- `versao-0-inicial`: estado inicial do repositório.
- `versao-1-roteiro-estelar`: primeira versão completa do app Flutter com README.
- `work`: branch atual para evolução contínua.

Você pode alternar entre versões com:

```bash
git checkout versao-0-inicial
git checkout versao-1-roteiro-estelar
```

## Possíveis melhorias

- Separar cada página em arquivo próprio (`lib/pages`).
- Persistir favoritos com `shared_preferences` ou banco local.
- Adicionar tela de detalhes do destino com imagens.
