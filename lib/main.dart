import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MapaAstralInterativoApp());
}

class MapaAstralInterativoApp extends StatelessWidget {
  const MapaAstralInterativoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mapa Astral Interativo',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6D28D9),
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: const Color(0xFF0B1120),
      ),
      home: const HomeShell(),
    );
  }
}

class Signo {
  const Signo({required this.nome, required this.elemento, required this.traco});

  final String nome;
  final String elemento;
  final String traco;
}

class CasaAstral {
  const CasaAstral({required this.numero, required this.tema, required this.resumo});

  final int numero;
  final String tema;
  final String resumo;
}

class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _paginaAtual = 0;
  bool _modoCompleto = false;
  bool _mostrarResumoTecnico = false;

  String _elementoFiltro = 'Todos';
  String _signoSolar = 'Áries';
  String _signoLunar = 'Câncer';
  String _ascendente = 'Libra';
  String _signoDestaque = 'Áries';

  String _dicaAtual = 'Toque em “Nova dica” para receber um insight de estudos.';

  int _sequenciaDias = 1;
  int _acertosQuiz = 0;
  int? _respostaQuizSelecionada;
  String _feedbackQuiz = 'Responda o quiz para testar seu entendimento.';

  final Set<String> _interesses = <String>{'Autoconhecimento'};
  final Set<int> _casasEstudadas = <int>{};
  final Set<String> _signosFavoritos = <String>{};

  double _progressoEstudo = 20;

  final List<String> _dicas = const [
    'Comece pelo trio base: Sol, Lua e Ascendente.',
    'Observe repetição de elementos no seu mapa para encontrar padrões.',
    'Casas mostram áreas da vida; signos mostram estilo de expressão.',
    'No estudo completo, planetas pessoais trazem nuances importantes.',
    'Faça pequenas sessões diárias e compare seus aprendizados.',
  ];

  final List<Signo> _signos = const [
    Signo(nome: 'Áries', elemento: 'Fogo', traco: 'Ação direta e iniciativa.'),
    Signo(nome: 'Touro', elemento: 'Terra', traco: 'Constância e segurança.'),
    Signo(nome: 'Gêmeos', elemento: 'Ar', traco: 'Curiosidade e troca.'),
    Signo(nome: 'Câncer', elemento: 'Água', traco: 'Acolhimento e emoção.'),
    Signo(nome: 'Leão', elemento: 'Fogo', traco: 'Expressão e criatividade.'),
    Signo(nome: 'Virgem', elemento: 'Terra', traco: 'Análise e aperfeiçoamento.'),
    Signo(nome: 'Libra', elemento: 'Ar', traco: 'Equilíbrio e diplomacia.'),
    Signo(nome: 'Escorpião', elemento: 'Água', traco: 'Intensidade e profundidade.'),
    Signo(nome: 'Sagitário', elemento: 'Fogo', traco: 'Expansão e propósito.'),
    Signo(nome: 'Capricórnio', elemento: 'Terra', traco: 'Estrutura e responsabilidade.'),
    Signo(nome: 'Aquário', elemento: 'Ar', traco: 'Originalidade e coletivo.'),
    Signo(nome: 'Peixes', elemento: 'Água', traco: 'Empatia e imaginação.'),
  ];

  final List<CasaAstral> _casas = const [
    CasaAstral(numero: 1, tema: 'Identidade', resumo: 'Como você começa ciclos e se apresenta.'),
    CasaAstral(numero: 2, tema: 'Valores', resumo: 'Dinheiro, autoestima e recursos pessoais.'),
    CasaAstral(numero: 3, tema: 'Comunicação', resumo: 'Aprendizagem e trocas do cotidiano.'),
    CasaAstral(numero: 4, tema: 'Raízes', resumo: 'Família, lar e base emocional.'),
    CasaAstral(numero: 5, tema: 'Criatividade', resumo: 'Prazer, romances e autenticidade.'),
    CasaAstral(numero: 6, tema: 'Rotina', resumo: 'Trabalho diário e cuidados com a saúde.'),
    CasaAstral(numero: 7, tema: 'Parcerias', resumo: 'Relacionamentos e acordos importantes.'),
    CasaAstral(numero: 8, tema: 'Transformação', resumo: 'Intimidade, crises e renascimentos.'),
    CasaAstral(numero: 9, tema: 'Expansão', resumo: 'Filosofia, viagens e sentido de vida.'),
    CasaAstral(numero: 10, tema: 'Carreira', resumo: 'Vocação, reputação e metas públicas.'),
    CasaAstral(numero: 11, tema: 'Comunidade', resumo: 'Amizades, grupos e projetos futuros.'),
    CasaAstral(numero: 12, tema: 'Inconsciente', resumo: 'Espiritualidade e encerramento de ciclos.'),
  ];

  @override
  Widget build(BuildContext context) {
    final casasVisiveis = _modoCompleto ? _casas : _casas.take(6).toList();

    final paginas = <Widget>[
      InicioInterativoPage(
        modoCompleto: _modoCompleto,
        dicaAtual: _dicaAtual,
        progressoEstudo: _progressoEstudo,
        interesses: _interesses,
        sequenciaDias: _sequenciaDias,
        mostrarResumoTecnico: _mostrarResumoTecnico,
        onModoChanged: (value) => setState(() => _modoCompleto = value),
        onInteresseToggle: _alternarInteresse,
        onNovaDica: _gerarNovaDica,
        onProgressoChanged: (value) => setState(() => _progressoEstudo = value),
        onSessaoConcluida: _registrarSessaoConcluida,
        onResetProgresso: _resetarProgresso,
        onToggleResumoTecnico: () => setState(() => _mostrarResumoTecnico = !_mostrarResumoTecnico),
      ),
      SignosInterativoPage(
        signos: _signos,
        elementoFiltro: _elementoFiltro,
        signoDestaque: _signoDestaque,
        signosFavoritos: _signosFavoritos,
        onFiltroChanged: (filtro) => setState(() => _elementoFiltro = filtro),
        onSortearSigno: _sortearSignoDestaque,
        onFavoritarSigno: _alternarFavoritoSigno,
      ),
      CasasInterativoPage(
        casas: casasVisiveis,
        casasEstudadas: _casasEstudadas,
        onToggleEstudada: _alternarCasaEstudada,
        onMarcarTodas: () => _marcarTodasCasas(casasVisiveis),
        onLimparMarcacoes: () => _limparCasas(casasVisiveis),
      ),
      LeituraInterativaPage(
        modoCompleto: _modoCompleto,
        signos: _signos.map((e) => e.nome).toList(),
        signoSolar: _signoSolar,
        signoLunar: _signoLunar,
        ascendente: _ascendente,
        interesses: _interesses,
        acertosQuiz: _acertosQuiz,
        respostaSelecionada: _respostaQuizSelecionada,
        feedbackQuiz: _feedbackQuiz,
        onSignoSolarChanged: (value) => setState(() => _signoSolar = value),
        onSignoLunarChanged: (value) => setState(() => _signoLunar = value),
        onAscendenteChanged: (value) => setState(() => _ascendente = value),
        onSelecionarRespostaQuiz: (value) => setState(() => _respostaQuizSelecionada = value),
        onValidarQuiz: _validarRespostaQuiz,
        onResetQuiz: _resetQuiz,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mapa Astral Interativo'),
        centerTitle: true,
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        child: paginas[_paginaAtual],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _paginaAtual,
        onDestinationSelected: (index) => setState(() => _paginaAtual = index),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Início',
          ),
          NavigationDestination(
            icon: Icon(Icons.auto_awesome_outlined),
            selectedIcon: Icon(Icons.auto_awesome),
            label: 'Signos',
          ),
          NavigationDestination(
            icon: Icon(Icons.grid_view_outlined),
            selectedIcon: Icon(Icons.grid_view_rounded),
            label: 'Casas',
          ),
          NavigationDestination(
            icon: Icon(Icons.psychology_alt_outlined),
            selectedIcon: Icon(Icons.psychology_alt),
            label: 'Leitura',
          ),
        ],
      ),
    );
  }

  void _alternarInteresse(String interesse) {
    setState(() {
      if (_interesses.contains(interesse)) {
        _interesses.remove(interesse);
      } else {
        _interesses.add(interesse);
      }
    });
  }

  void _gerarNovaDica() {
    final random = Random();
    setState(() {
      _dicaAtual = _dicas[random.nextInt(_dicas.length)];
    });
  }

  void _registrarSessaoConcluida() {
    setState(() {
      _sequenciaDias += 1;
      _progressoEstudo = min<double>(100, _progressoEstudo + 5);
    });
  }

  void _resetarProgresso() {
    setState(() {
      _sequenciaDias = 1;
      _progressoEstudo = 0;
      _casasEstudadas.clear();
    });
  }

  void _sortearSignoDestaque() {
    final random = Random();
    setState(() {
      _signoDestaque = _signos[random.nextInt(_signos.length)].nome;
    });
  }

  void _alternarFavoritoSigno(String nomeSigno) {
    setState(() {
      if (_signosFavoritos.contains(nomeSigno)) {
        _signosFavoritos.remove(nomeSigno);
      } else {
        _signosFavoritos.add(nomeSigno);
      }
    });
  }

  void _alternarCasaEstudada(int numeroCasa) {
    setState(() {
      if (_casasEstudadas.contains(numeroCasa)) {
        _casasEstudadas.remove(numeroCasa);
      } else {
        _casasEstudadas.add(numeroCasa);
      }
    });
  }

  void _marcarTodasCasas(List<CasaAstral> casasVisiveis) {
    setState(() {
      _casasEstudadas.addAll(casasVisiveis.map((casa) => casa.numero));
    });
  }

  void _limparCasas(List<CasaAstral> casasVisiveis) {
    setState(() {
      for (final casa in casasVisiveis) {
        _casasEstudadas.remove(casa.numero);
      }
    });
  }

  void _validarRespostaQuiz() {
    if (_respostaQuizSelecionada == null) {
      setState(() {
        _feedbackQuiz = 'Selecione uma opção antes de validar.';
      });
      return;
    }

    setState(() {
      if (_respostaQuizSelecionada == 1) {
        _acertosQuiz += 1;
        _feedbackQuiz = 'Correto! O Ascendente fala sobre sua forma de agir e se apresentar.';
      } else {
        _feedbackQuiz = 'Quase! A resposta correta é Ascendente (opção 2).';
      }
    });
  }

  void _resetQuiz() {
    setState(() {
      _respostaQuizSelecionada = null;
      _feedbackQuiz = 'Quiz reiniciado. Escolha uma opção e valide.';
    });
  }
}

class InicioInterativoPage extends StatelessWidget {
  const InicioInterativoPage({
    super.key,
    required this.modoCompleto,
    required this.dicaAtual,
    required this.progressoEstudo,
    required this.interesses,
    required this.sequenciaDias,
    required this.mostrarResumoTecnico,
    required this.onModoChanged,
    required this.onInteresseToggle,
    required this.onNovaDica,
    required this.onProgressoChanged,
    required this.onSessaoConcluida,
    required this.onResetProgresso,
    required this.onToggleResumoTecnico,
  });

  final bool modoCompleto;
  final String dicaAtual;
  final double progressoEstudo;
  final Set<String> interesses;
  final int sequenciaDias;
  final bool mostrarResumoTecnico;
  final ValueChanged<bool> onModoChanged;
  final ValueChanged<String> onInteresseToggle;
  final VoidCallback onNovaDica;
  final ValueChanged<double> onProgressoChanged;
  final VoidCallback onSessaoConcluida;
  final VoidCallback onResetProgresso;
  final VoidCallback onToggleResumoTecnico;

  @override
  Widget build(BuildContext context) {
    const opcoesInteresse = ['Autoconhecimento', 'Amor', 'Carreira', 'Espiritualidade'];

    return ListView(
      key: const ValueKey<String>('inicio_page'),
      padding: const EdgeInsets.all(16),
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: const LinearGradient(colors: [Color(0xFF312E81), Color(0xFF7E22CE)]),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Guia prático do Mapa Astral', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Text('Explore de forma parcial ou completa e monte sua leitura personalizada.'),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: FilledButton.icon(
                onPressed: onSessaoConcluida,
                icon: const Icon(Icons.check_circle_outline),
                label: const Text('Concluir sessão'),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: OutlinedButton.icon(
                onPressed: onResetProgresso,
                icon: const Icon(Icons.restart_alt),
                label: const Text('Resetar'),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text('Sequência de estudos: $sequenciaDias dias'),
        const SizedBox(height: 8),
        SwitchListTile(
          value: modoCompleto,
          onChanged: onModoChanged,
          title: const Text('Modo completo'),
          subtitle: Text(modoCompleto ? '12 casas + planetas extras ativados.' : 'Modo parcial com fundamentos essenciais.'),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: FilledButton.tonal(
                onPressed: onToggleResumoTecnico,
                child: Text(mostrarResumoTecnico ? 'Ocultar resumo técnico' : 'Mostrar resumo técnico'),
              ),
            ),
          ],
        ),
        if (mostrarResumoTecnico)
          const Padding(
            padding: EdgeInsets.only(top: 8),
            child: Card(
              child: ListTile(
                title: Text('Fluxo interno do app'),
                subtitle: Text('Estado centralizado no HomeShell e distribuído por callbacks para as páginas.'),
              ),
            ),
          ),
        const SizedBox(height: 8),
        const Text('Escolha seus interesses de estudo:'),
        Wrap(
          spacing: 8,
          children: opcoesInteresse
              .map(
                (interesse) => FilterChip(
                  selected: interesses.contains(interesse),
                  label: Text(interesse),
                  onSelected: (_) => onInteresseToggle(interesse),
                ),
              )
              .toList(),
        ),
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Progresso de estudo'),
                Slider(
                  value: progressoEstudo,
                  min: 0,
                  max: 100,
                  divisions: 20,
                  label: '${progressoEstudo.round()}%',
                  onChanged: onProgressoChanged,
                ),
                Text('Você completou ${progressoEstudo.round()}% do seu plano.'),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        Card(
          child: ListTile(
            title: const Text('Dica rápida do dia'),
            subtitle: Text(dicaAtual),
            trailing: FilledButton(
              onPressed: onNovaDica,
              child: const Text('Nova dica'),
            ),
          ),
        ),
      ],
    );
  }
}

class SignosInterativoPage extends StatelessWidget {
  const SignosInterativoPage({
    super.key,
    required this.signos,
    required this.elementoFiltro,
    required this.signoDestaque,
    required this.signosFavoritos,
    required this.onFiltroChanged,
    required this.onSortearSigno,
    required this.onFavoritarSigno,
  });

  final List<Signo> signos;
  final String elementoFiltro;
  final String signoDestaque;
  final Set<String> signosFavoritos;
  final ValueChanged<String> onFiltroChanged;
  final VoidCallback onSortearSigno;
  final ValueChanged<String> onFavoritarSigno;

  @override
  Widget build(BuildContext context) {
    const filtros = ['Todos', 'Fogo', 'Terra', 'Ar', 'Água'];

    final signosFiltrados = elementoFiltro == 'Todos'
        ? signos
        : signos.where((signo) => signo.elemento == elementoFiltro).toList();

    return Column(
      key: const ValueKey<String>('signos_page'),
      children: [
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Expanded(child: Text('Signo destaque de hoje: $signoDestaque')),
              FilledButton.icon(
                onPressed: onSortearSigno,
                icon: const Icon(Icons.casino_outlined),
                label: const Text('Sortear'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: filtros
              .map(
                (filtro) => ChoiceChip(
                  label: Text(filtro),
                  selected: elementoFiltro == filtro,
                  onSelected: (_) => onFiltroChanged(filtro),
                ),
              )
              .toList(),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: ListView.builder(
            itemCount: signosFiltrados.length,
            itemBuilder: (context, index) {
              final signo = signosFiltrados[index];
              final favorito = signosFavoritos.contains(signo.nome);
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  leading: const Icon(Icons.stars),
                  title: Text(signo.nome),
                  subtitle: Text('${signo.traco}\nElemento: ${signo.elemento}'),
                  isThreeLine: true,
                  trailing: IconButton(
                    tooltip: favorito ? 'Remover dos favoritos' : 'Salvar favorito',
                    onPressed: () => onFavoritarSigno(signo.nome),
                    icon: Icon(favorito ? Icons.favorite : Icons.favorite_border),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class CasasInterativoPage extends StatelessWidget {
  const CasasInterativoPage({
    super.key,
    required this.casas,
    required this.casasEstudadas,
    required this.onToggleEstudada,
    required this.onMarcarTodas,
    required this.onLimparMarcacoes,
  });

  final List<CasaAstral> casas;
  final Set<int> casasEstudadas;
  final ValueChanged<int> onToggleEstudada;
  final VoidCallback onMarcarTodas;
  final VoidCallback onLimparMarcacoes;

  @override
  Widget build(BuildContext context) {
    return ListView(
      key: const ValueKey<String>('casas_page'),
      padding: const EdgeInsets.all(16),
      children: [
        Text('Casas disponíveis: ${casas.length}'),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: FilledButton(
                onPressed: onMarcarTodas,
                child: const Text('Marcar todas'),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: OutlinedButton(
                onPressed: onLimparMarcacoes,
                child: const Text('Limpar seleção'),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ...casas.map(
          (casa) => Card(
            child: ExpansionTile(
              title: Text('Casa ${casa.numero} • ${casa.tema}'),
              subtitle: Text(casa.resumo),
              children: [
                CheckboxListTile(
                  value: casasEstudadas.contains(casa.numero),
                  title: const Text('Marcar como estudada'),
                  subtitle: const Text('Use para acompanhar sua evolução.'),
                  onChanged: (_) => onToggleEstudada(casa.numero),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class LeituraInterativaPage extends StatelessWidget {
  const LeituraInterativaPage({
    super.key,
    required this.modoCompleto,
    required this.signos,
    required this.signoSolar,
    required this.signoLunar,
    required this.ascendente,
    required this.interesses,
    required this.acertosQuiz,
    required this.respostaSelecionada,
    required this.feedbackQuiz,
    required this.onSignoSolarChanged,
    required this.onSignoLunarChanged,
    required this.onAscendenteChanged,
    required this.onSelecionarRespostaQuiz,
    required this.onValidarQuiz,
    required this.onResetQuiz,
  });

  final bool modoCompleto;
  final List<String> signos;
  final String signoSolar;
  final String signoLunar;
  final String ascendente;
  final Set<String> interesses;
  final int acertosQuiz;
  final int? respostaSelecionada;
  final String feedbackQuiz;
  final ValueChanged<String> onSignoSolarChanged;
  final ValueChanged<String> onSignoLunarChanged;
  final ValueChanged<String> onAscendenteChanged;
  final ValueChanged<int?> onSelecionarRespostaQuiz;
  final VoidCallback onValidarQuiz;
  final VoidCallback onResetQuiz;

  @override
  Widget build(BuildContext context) {
    final focoInteresses = interesses.isEmpty ? 'exploração geral' : interesses.join(', ');

    final resumo = [
      'Sol em $signoSolar: identidade e propósito.',
      'Lua em $signoLunar: campo emocional e necessidades afetivas.',
      'Ascendente em $ascendente: estilo de ação e primeira impressão.',
      'Foco atual de estudo: $focoInteresses.',
      if (modoCompleto) 'Modo completo: inclua leitura de Mercúrio, Vênus, Marte, Júpiter e Saturno.',
    ];

    return ListView(
      key: const ValueKey<String>('leitura_page'),
      padding: const EdgeInsets.all(16),
      children: [
        const Text('Monte sua leitura guiada', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        _SignoDropdown(
          label: 'Signo solar',
          value: signoSolar,
          items: signos,
          onChanged: onSignoSolarChanged,
        ),
        _SignoDropdown(
          label: 'Signo lunar',
          value: signoLunar,
          items: signos,
          onChanged: onSignoLunarChanged,
        ),
        _SignoDropdown(
          label: 'Ascendente',
          value: ascendente,
          items: signos,
          onChanged: onAscendenteChanged,
        ),
        const SizedBox(height: 8),
        ...resumo.map(
          (item) => Card(
            child: ListTile(
              leading: const Icon(Icons.check_circle_outline),
              title: Text(item),
            ),
          ),
        ),
        const SizedBox(height: 12),
        const Text('Quiz rápido', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
        const SizedBox(height: 4),
        const Text('Qual ponto do mapa fala mais sobre sua forma de agir e primeira impressão?'),
        RadioListTile<int>(
          value: 0,
          groupValue: respostaSelecionada,
          onChanged: onSelecionarRespostaQuiz,
          title: const Text('Sol'),
        ),
        RadioListTile<int>(
          value: 1,
          groupValue: respostaSelecionada,
          onChanged: onSelecionarRespostaQuiz,
          title: const Text('Ascendente'),
        ),
        RadioListTile<int>(
          value: 2,
          groupValue: respostaSelecionada,
          onChanged: onSelecionarRespostaQuiz,
          title: const Text('Casa 2'),
        ),
        Row(
          children: [
            Expanded(
              child: FilledButton(
                onPressed: onValidarQuiz,
                child: const Text('Validar resposta'),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: OutlinedButton(
                onPressed: onResetQuiz,
                child: const Text('Resetar quiz'),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Card(
          child: ListTile(
            title: Text('Pontuação acumulada: $acertosQuiz acertos'),
            subtitle: Text(feedbackQuiz),
          ),
        ),
      ],
    );
  }
}

class _SignoDropdown extends StatelessWidget {
  const _SignoDropdown({
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  final String label;
  final String value;
  final List<String> items;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: DropdownButtonFormField<String>(
        value: value,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        items: items
            .map(
              (item) => DropdownMenuItem<String>(
                value: item,
                child: Text(item),
              ),
            )
            .toList(),
        onChanged: (novoValor) {
          if (novoValor != null) {
            onChanged(novoValor);
          }
        },
      ),
    );
  }
}
