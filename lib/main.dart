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
  String _elementoFiltro = 'Todos';
  String _signoDestaque = 'Áries';
  String _dicaAtual = 'Toque em "Nova dica" para receber um insight.';
  String _signoSolar = 'Áries';
  String _signoLunar = 'Câncer';
  String _ascendente = 'Libra';
  int? _respostaQuiz;
  String _feedbackQuiz = 'Escolha uma opção e clique em validar.';

  final Set<String> _interesses = <String>{'Autoconhecimento'};
  final Set<String> _signosFavoritos = <String>{};
  final Set<int> _casasEstudadas = <int>{};

  final List<String> _dicas = const [
    'Comece pelo trio base: Sol, Lua e Ascendente.',
    'Observe repetição de elementos no mapa.',
    'Casas mostram áreas da vida, signos mostram estilo.',
    'No modo completo, aprofunde-se nas 12 casas.',
  ];

  final List<Signo> _signos = const [
    Signo(nome: 'Áries', elemento: 'Fogo', traco: 'Iniciativa e ação.'),
    Signo(nome: 'Touro', elemento: 'Terra', traco: 'Constância e segurança.'),
    Signo(nome: 'Gêmeos', elemento: 'Ar', traco: 'Curiosidade e comunicação.'),
    Signo(nome: 'Câncer', elemento: 'Água', traco: 'Acolhimento e emoção.'),
    Signo(nome: 'Leão', elemento: 'Fogo', traco: 'Expressão e criatividade.'),
    Signo(nome: 'Virgem', elemento: 'Terra', traco: 'Análise e organização.'),
    Signo(nome: 'Libra', elemento: 'Ar', traco: 'Diplomacia e equilíbrio.'),
    Signo(nome: 'Escorpião', elemento: 'Água', traco: 'Intensidade e profundidade.'),
    Signo(nome: 'Sagitário', elemento: 'Fogo', traco: 'Expansão e propósito.'),
    Signo(nome: 'Capricórnio', elemento: 'Terra', traco: 'Disciplina e estrutura.'),
    Signo(nome: 'Aquário', elemento: 'Ar', traco: 'Originalidade e visão coletiva.'),
    Signo(nome: 'Peixes', elemento: 'Água', traco: 'Empatia e imaginação.'),
  ];

  final List<CasaAstral> _casas = const [
    CasaAstral(numero: 1, tema: 'Identidade', resumo: 'Como você se apresenta.'),
    CasaAstral(numero: 2, tema: 'Valores', resumo: 'Recursos, autoestima e segurança.'),
    CasaAstral(numero: 3, tema: 'Comunicação', resumo: 'Aprendizagem e trocas.'),
    CasaAstral(numero: 4, tema: 'Raízes', resumo: 'Lar, família e base emocional.'),
    CasaAstral(numero: 5, tema: 'Criatividade', resumo: 'Prazer e expressão pessoal.'),
    CasaAstral(numero: 6, tema: 'Rotina', resumo: 'Trabalho diário e saúde.'),
    CasaAstral(numero: 7, tema: 'Parcerias', resumo: 'Relações e acordos.'),
    CasaAstral(numero: 8, tema: 'Transformação', resumo: 'Crises e renascimentos.'),
    CasaAstral(numero: 9, tema: 'Expansão', resumo: 'Filosofia e visão de mundo.'),
    CasaAstral(numero: 10, tema: 'Carreira', resumo: 'Objetivos e reputação.'),
    CasaAstral(numero: 11, tema: 'Comunidade', resumo: 'Amizades e projetos coletivos.'),
    CasaAstral(numero: 12, tema: 'Inconsciente', resumo: 'Interioridade e encerramentos.'),
  ];

  @override
  Widget build(BuildContext context) {
    final casasVisiveis = _modoCompleto ? _casas : _casas.take(6).toList();

    final paginas = <Widget>[
      InicioPage(
        modoCompleto: _modoCompleto,
        dicaAtual: _dicaAtual,
        interesses: _interesses,
        onModoChanged: (value) => setState(() => _modoCompleto = value),
        onInteresseToggle: _alternarInteresse,
        onNovaDica: _gerarNovaDica,
      ),
      SignosPage(
        signos: _signos,
        elementoFiltro: _elementoFiltro,
        signoDestaque: _signoDestaque,
        signosFavoritos: _signosFavoritos,
        onFiltroChanged: (filtro) => setState(() => _elementoFiltro = filtro),
        onSortearSigno: _sortearSignoDestaque,
        onFavoritarSigno: _alternarFavoritoSigno,
      ),
      CasasPage(
        casas: casasVisiveis,
        casasEstudadas: _casasEstudadas,
        onToggleEstudada: _alternarCasaEstudada,
        onMarcarTodas: () => _marcarTodasCasas(casasVisiveis),
      ),
      LeituraPage(
        modoCompleto: _modoCompleto,
        signos: _signos.map((e) => e.nome).toList(),
        signoSolar: _signoSolar,
        signoLunar: _signoLunar,
        ascendente: _ascendente,
        respostaQuiz: _respostaQuiz,
        feedbackQuiz: _feedbackQuiz,
        interesses: _interesses,
        onSignoSolarChanged: (value) => setState(() => _signoSolar = value),
        onSignoLunarChanged: (value) => setState(() => _signoLunar = value),
        onAscendenteChanged: (value) => setState(() => _ascendente = value),
        onSelecionarResposta: (value) => setState(() => _respostaQuiz = value),
        onValidarQuiz: _validarQuiz,
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

  void _validarQuiz() {
    setState(() {
      if (_respostaQuiz == null) {
        _feedbackQuiz = 'Selecione uma opção antes de validar.';
      } else if (_respostaQuiz == 1) {
        _feedbackQuiz = 'Correto! Ascendente fala da forma de agir e da primeira impressão.';
      } else {
        _feedbackQuiz = 'Quase! A correta é Ascendente.';
      }
    });
  }
}

class InicioPage extends StatelessWidget {
  const InicioPage({
    super.key,
    required this.modoCompleto,
    required this.dicaAtual,
    required this.interesses,
    required this.onModoChanged,
    required this.onInteresseToggle,
    required this.onNovaDica,
  });

  final bool modoCompleto;
  final String dicaAtual;
  final Set<String> interesses;
  final ValueChanged<bool> onModoChanged;
  final ValueChanged<String> onInteresseToggle;
  final VoidCallback onNovaDica;

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
              Text('Versão simplificada com 4 botões principais.'),
            ],
          ),
        ),
        const SizedBox(height: 12),
        SwitchListTile(
          value: modoCompleto,
          onChanged: onModoChanged,
          title: const Text('Modo completo'),
          subtitle: Text(modoCompleto ? 'Exibe 12 casas astrais.' : 'Exibe 6 casas principais.'),
        ),
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
        const SizedBox(height: 12),
        FilledButton.icon(
          onPressed: onNovaDica,
          icon: const Icon(Icons.lightbulb_outline),
          label: const Text('Nova dica'),
        ),
        const SizedBox(height: 8),
        Card(
          child: ListTile(
            title: const Text('Dica atual'),
            subtitle: Text(dicaAtual),
          ),
        ),
      ],
    );
  }
}

class SignosPage extends StatelessWidget {
  const SignosPage({
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
              Expanded(child: Text('Destaque: $signoDestaque')),
              FilledButton(
                onPressed: onSortearSigno,
                child: const Text('Sortear signo'),
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
                  title: Text(signo.nome),
                  subtitle: Text('${signo.traco}\nElemento: ${signo.elemento}'),
                  isThreeLine: true,
                  trailing: IconButton(
                    tooltip: favorito ? 'Remover favorito' : 'Favoritar signo',
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

class CasasPage extends StatelessWidget {
  const CasasPage({
    super.key,
    required this.casas,
    required this.casasEstudadas,
    required this.onToggleEstudada,
    required this.onMarcarTodas,
  });

  final List<CasaAstral> casas;
  final Set<int> casasEstudadas;
  final ValueChanged<int> onToggleEstudada;
  final VoidCallback onMarcarTodas;

  @override
  Widget build(BuildContext context) {
    return ListView(
      key: const ValueKey<String>('casas_page'),
      padding: const EdgeInsets.all(16),
      children: [
        FilledButton(
          onPressed: onMarcarTodas,
          child: const Text('Marcar todas as casas visíveis'),
        ),
        const SizedBox(height: 8),
        ...casas.map(
          (casa) => Card(
            child: CheckboxListTile(
              value: casasEstudadas.contains(casa.numero),
              onChanged: (_) => onToggleEstudada(casa.numero),
              title: Text('Casa ${casa.numero} • ${casa.tema}'),
              subtitle: Text(casa.resumo),
            ),
          ),
        ),
      ],
    );
  }
}

class LeituraPage extends StatelessWidget {
  const LeituraPage({
    super.key,
    required this.modoCompleto,
    required this.signos,
    required this.signoSolar,
    required this.signoLunar,
    required this.ascendente,
    required this.respostaQuiz,
    required this.feedbackQuiz,
    required this.interesses,
    required this.onSignoSolarChanged,
    required this.onSignoLunarChanged,
    required this.onAscendenteChanged,
    required this.onSelecionarResposta,
    required this.onValidarQuiz,
  });

  final bool modoCompleto;
  final List<String> signos;
  final String signoSolar;
  final String signoLunar;
  final String ascendente;
  final int? respostaQuiz;
  final String feedbackQuiz;
  final Set<String> interesses;
  final ValueChanged<String> onSignoSolarChanged;
  final ValueChanged<String> onSignoLunarChanged;
  final ValueChanged<String> onAscendenteChanged;
  final ValueChanged<int?> onSelecionarResposta;
  final VoidCallback onValidarQuiz;

  @override
  Widget build(BuildContext context) {
    final focoInteresses = interesses.isEmpty ? 'geral' : interesses.join(', ');

    return ListView(
      key: const ValueKey<String>('leitura_page'),
      padding: const EdgeInsets.all(16),
      children: [
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
        Card(
          child: ListTile(
            title: const Text('Resumo'),
            subtitle: Text(
              'Sol em $signoSolar, Lua em $signoLunar e Ascendente em $ascendente.\n'
              'Foco: $focoInteresses.\n'
              '${modoCompleto ? 'Modo completo ativo.' : 'Modo parcial ativo.'}',
            ),
          ),
        ),
        const SizedBox(height: 8),
        const Text('Quiz rápido: qual ponto representa a primeira impressão?'),
        RadioListTile<int>(
          value: 0,
          groupValue: respostaQuiz,
          onChanged: onSelecionarResposta,
          title: const Text('Sol'),
        ),
        RadioListTile<int>(
          value: 1,
          groupValue: respostaQuiz,
          onChanged: onSelecionarResposta,
          title: const Text('Ascendente'),
        ),
        RadioListTile<int>(
          value: 2,
          groupValue: respostaQuiz,
          onChanged: onSelecionarResposta,
          title: const Text('Casa 2'),
        ),
        FilledButton(
          onPressed: onValidarQuiz,
          child: const Text('Validar resposta'),
        ),
        const SizedBox(height: 8),
        Card(
          child: ListTile(
            title: const Text('Feedback do quiz'),
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
            .map((item) => DropdownMenuItem<String>(value: item, child: Text(item)))
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
