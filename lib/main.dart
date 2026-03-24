import 'package:flutter/material.dart';

void main() {
  runApp(const MapaAstralApp());
}

class MapaAstralApp extends StatelessWidget {
  const MapaAstralApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Guia do Mapa Astral',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF5B21B6),
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: const Color(0xFF0F172A),
      ),
      home: const HomeShell(),
    );
  }
}

class Signo {
  const Signo({required this.nome, required this.elemento, required this.resumo});

  final String nome;
  final String elemento;
  final String resumo;
}

class CasaAstral {
  const CasaAstral({
    required this.numero,
    required this.tema,
    required this.explicacao,
  });

  final int numero;
  final String tema;
  final String explicacao;
}

class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _paginaAtual = 0;
  bool _modoCompleto = false;

  final List<Signo> _signos = const [
    Signo(nome: 'Áries', elemento: 'Fogo', resumo: 'Iniciativa, coragem e impulso para agir.'),
    Signo(nome: 'Touro', elemento: 'Terra', resumo: 'Estabilidade, paciência e foco no concreto.'),
    Signo(nome: 'Gêmeos', elemento: 'Ar', resumo: 'Comunicação, curiosidade e adaptabilidade.'),
    Signo(nome: 'Câncer', elemento: 'Água', resumo: 'Sensibilidade, cuidado e memória afetiva.'),
    Signo(nome: 'Leão', elemento: 'Fogo', resumo: 'Expressão, criatividade e presença pessoal.'),
    Signo(nome: 'Virgem', elemento: 'Terra', resumo: 'Organização, análise e busca de aprimoramento.'),
    Signo(nome: 'Libra', elemento: 'Ar', resumo: 'Diplomacia, parceria e senso estético.'),
    Signo(nome: 'Escorpião', elemento: 'Água', resumo: 'Intensidade, profundidade e transformação.'),
    Signo(nome: 'Sagitário', elemento: 'Fogo', resumo: 'Expansão, aprendizado e visão de futuro.'),
    Signo(nome: 'Capricórnio', elemento: 'Terra', resumo: 'Disciplina, estratégia e responsabilidade.'),
    Signo(nome: 'Aquário', elemento: 'Ar', resumo: 'Originalidade, coletivo e inovação.'),
    Signo(nome: 'Peixes', elemento: 'Água', resumo: 'Imaginação, empatia e espiritualidade.'),
  ];

  final List<CasaAstral> _casas = const [
    CasaAstral(numero: 1, tema: 'Identidade', explicacao: 'Como você inicia ciclos e se apresenta ao mundo.'),
    CasaAstral(numero: 2, tema: 'Valores', explicacao: 'Relação com dinheiro, autoestima e recursos pessoais.'),
    CasaAstral(numero: 3, tema: 'Comunicação', explicacao: 'Aprendizado, linguagem e trocas do cotidiano.'),
    CasaAstral(numero: 4, tema: 'Raízes', explicacao: 'Família, origem e base emocional.'),
    CasaAstral(numero: 5, tema: 'Criatividade', explicacao: 'Prazer, romances e expressão criativa.'),
    CasaAstral(numero: 6, tema: 'Rotina', explicacao: 'Trabalho diário, saúde e organização da vida.'),
    CasaAstral(numero: 7, tema: 'Relacionamentos', explicacao: 'Parcerias, contratos e vínculos importantes.'),
    CasaAstral(numero: 8, tema: 'Transformação', explicacao: 'Crises, desapego e recursos compartilhados.'),
    CasaAstral(numero: 9, tema: 'Expansão', explicacao: 'Filosofia de vida, viagens e estudos superiores.'),
    CasaAstral(numero: 10, tema: 'Carreira', explicacao: 'Imagem pública, ambição e realização profissional.'),
    CasaAstral(numero: 11, tema: 'Coletivo', explicacao: 'Amizades, grupos e visão de futuro em comunidade.'),
    CasaAstral(numero: 12, tema: 'Inconsciente', explicacao: 'Mundo interno, espiritualidade e encerramentos.'),
  ];

  @override
  Widget build(BuildContext context) {
    final paginas = <Widget>[
      IntroducaoPage(
        modoCompleto: _modoCompleto,
        onModoChanged: (valor) => setState(() => _modoCompleto = valor),
      ),
      SignosPage(signos: _signos),
      CasasPage(casas: _casas, modoCompleto: _modoCompleto),
      LeituraPage(modoCompleto: _modoCompleto),
    ];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Guia do Mapa Astral'),
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 220),
        child: paginas[_paginaAtual],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _paginaAtual,
        onDestinationSelected: (index) => setState(() => _paginaAtual = index),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.school_outlined),
            selectedIcon: Icon(Icons.school),
            label: 'Introdução',
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
            icon: Icon(Icons.menu_book_outlined),
            selectedIcon: Icon(Icons.menu_book),
            label: 'Leitura',
          ),
        ],
      ),
    );
  }
}

class IntroducaoPage extends StatelessWidget {
  const IntroducaoPage({
    super.key,
    required this.modoCompleto,
    required this.onModoChanged,
  });

  final bool modoCompleto;
  final ValueChanged<bool> onModoChanged;

  @override
  Widget build(BuildContext context) {
    return ListView(
      key: const ValueKey<String>('introducao_page'),
      padding: const EdgeInsets.all(16),
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: const LinearGradient(
              colors: [Color(0xFF312E81), Color(0xFF7C3AED)],
            ),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Aprenda seu Mapa Astral',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Veja os pilares da astrologia natal: signos, casas e uma leitura guiada.',
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        SwitchListTile(
          title: const Text('Modo completo de estudo'),
          subtitle: Text(
            modoCompleto
                ? 'Exibindo conteúdo detalhado (Sol, Lua, Ascendente e planetas).'
                : 'Exibindo conteúdo parcial (fundamentos essenciais).',
          ),
          value: modoCompleto,
          onChanged: onModoChanged,
        ),
        const SizedBox(height: 8),
        const Card(
          child: ListTile(
            leading: Icon(Icons.info_outline),
            title: Text('O que é mapa astral?'),
            subtitle: Text(
              'É uma representação simbólica do céu no momento do nascimento, usada para autoconhecimento.',
            ),
          ),
        ),
      ],
    );
  }
}

class SignosPage extends StatelessWidget {
  const SignosPage({super.key, required this.signos});

  final List<Signo> signos;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      key: const ValueKey<String>('signos_page'),
      itemCount: signos.length,
      itemBuilder: (context, index) {
        final signo = signos[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ListTile(
            title: Text(signo.nome),
            subtitle: Text('${signo.resumo}\nElemento: ${signo.elemento}'),
            isThreeLine: true,
            leading: const Icon(Icons.stars_rounded),
          ),
        );
      },
    );
  }
}

class CasasPage extends StatelessWidget {
  const CasasPage({
    super.key,
    required this.casas,
    required this.modoCompleto,
  });

  final List<CasaAstral> casas;
  final bool modoCompleto;

  @override
  Widget build(BuildContext context) {
    final casasExibidas = modoCompleto ? casas : casas.take(6).toList();

    return ListView(
      key: const ValueKey<String>('casas_page'),
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          modoCompleto
              ? 'Modo completo: 12 casas astrais'
              : 'Modo parcial: foco nas 6 primeiras casas',
        ),
        const SizedBox(height: 12),
        ...casasExibidas.map(
          (casa) => Card(
            child: ListTile(
              title: Text('Casa ${casa.numero} • ${casa.tema}'),
              subtitle: Text(casa.explicacao),
            ),
          ),
        ),
      ],
    );
  }
}

class LeituraPage extends StatelessWidget {
  const LeituraPage({super.key, required this.modoCompleto});

  final bool modoCompleto;

  @override
  Widget build(BuildContext context) {
    final blocosBasicos = const [
      'Sol: representa identidade central e propósito.',
      'Lua: descreve emoções e necessidades afetivas.',
      'Ascendente: mostra estilo de ação e primeira impressão.',
    ];

    final blocosExtras = const [
      'Mercúrio: comunicação e pensamento.',
      'Vênus: afetos, vínculos e valores relacionais.',
      'Marte: energia, impulso e forma de agir.',
      'Júpiter e Saturno: expansão e responsabilidade.',
    ];

    final blocos = modoCompleto ? [...blocosBasicos, ...blocosExtras] : blocosBasicos;

    return ListView(
      key: const ValueKey<String>('leitura_page'),
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          'Roteiro de leitura',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        ...blocos.map(
          (texto) => Card(
            child: ListTile(
              leading: const Icon(Icons.brightness_1_outlined),
              title: Text(texto),
            ),
          ),
        ),
      ],
    );
  }
}
