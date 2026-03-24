import 'package:flutter/material.dart';

void main() {
  runApp(const RoteiroEstelarApp());
}

class RoteiroEstelarApp extends StatelessWidget {
  const RoteiroEstelarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Roteiro Estelar',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6750A4),
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: const Color(0xFF101828),
      ),
      home: const HomeShell(),
    );
  }
}

class Destino {
  const Destino({
    required this.nome,
    required this.descricao,
    required this.distancia,
    required this.preco,
  });

  final String nome;
  final String descricao;
  final String distancia;
  final double preco;
}

class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _paginaAtual = 0;

  final List<Destino> _destinos = const [
    Destino(
      nome: 'Lua Tranquillitatis',
      descricao: 'Passeio curto para ver o nascer da Terra no horizonte lunar.',
      distancia: '384.400 km',
      preco: 29999,
    ),
    Destino(
      nome: 'Anéis de Saturno',
      descricao: 'Cruzeiro panorâmico com observação das partículas de gelo.',
      distancia: '1,2 bilhão km',
      preco: 189999,
    ),
    Destino(
      nome: 'Base Aurora em Marte',
      descricao: 'Expedição de 7 dias para dunas, crateras e laboratório científico.',
      distancia: '225 milhões km',
      preco: 99999,
    ),
  ];

  final Set<String> _favoritos = <String>{};

  @override
  Widget build(BuildContext context) {
    final paginas = <Widget>[
      InicioPage(destinos: _destinos),
      DestinosPage(
        destinos: _destinos,
        favoritos: _favoritos,
        onFavoritar: _alternarFavorito,
      ),
      FavoritosPage(
        destinos: _destinos,
        favoritos: _favoritos,
      ),
      const PerfilPage(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Roteiro Estelar'),
        centerTitle: true,
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        child: paginas[_paginaAtual],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _paginaAtual,
        onDestinationSelected: (index) {
          setState(() => _paginaAtual = index);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Início',
          ),
          NavigationDestination(
            icon: Icon(Icons.public_outlined),
            selectedIcon: Icon(Icons.public),
            label: 'Destinos',
          ),
          NavigationDestination(
            icon: Icon(Icons.favorite_border),
            selectedIcon: Icon(Icons.favorite),
            label: 'Favoritos',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }

  void _alternarFavorito(String nomeDestino) {
    setState(() {
      if (_favoritos.contains(nomeDestino)) {
        _favoritos.remove(nomeDestino);
      } else {
        _favoritos.add(nomeDestino);
      }
    });
  }
}

class InicioPage extends StatelessWidget {
  const InicioPage({super.key, required this.destinos});

  final List<Destino> destinos;

  @override
  Widget build(BuildContext context) {
    return ListView(
      key: const ValueKey<String>('inicio_page'),
      padding: const EdgeInsets.all(16),
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF4338CA), Color(0xFF7C3AED)],
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Planeje sua próxima viagem espacial',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Selecione destinos, salve favoritos e acompanhe seu perfil de viajante.',
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Text('Destinos disponíveis: ${destinos.length}'),
        const SizedBox(height: 12),
        ...destinos.take(2).map(
          (destino) => Card(
            child: ListTile(
              title: Text(destino.nome),
              subtitle: Text(destino.descricao),
              trailing: Text('R\$ ${destino.preco.toStringAsFixed(0)}'),
            ),
          ),
        ),
      ],
    );
  }
}

class DestinosPage extends StatelessWidget {
  const DestinosPage({
    super.key,
    required this.destinos,
    required this.favoritos,
    required this.onFavoritar,
  });

  final List<Destino> destinos;
  final Set<String> favoritos;
  final ValueChanged<String> onFavoritar;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      key: const ValueKey<String>('destinos_page'),
      itemCount: destinos.length,
      itemBuilder: (context, index) {
        final destino = destinos[index];
        final isFavorito = favoritos.contains(destino.nome);

        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ListTile(
            title: Text(destino.nome),
            subtitle: Text(
              '${destino.descricao}\nDistância: ${destino.distancia}',
            ),
            isThreeLine: true,
            trailing: IconButton(
              tooltip: isFavorito ? 'Remover favorito' : 'Salvar favorito',
              onPressed: () => onFavoritar(destino.nome),
              icon: Icon(isFavorito ? Icons.favorite : Icons.favorite_border),
            ),
          ),
        );
      },
    );
  }
}

class FavoritosPage extends StatelessWidget {
  const FavoritosPage({
    super.key,
    required this.destinos,
    required this.favoritos,
  });

  final List<Destino> destinos;
  final Set<String> favoritos;

  @override
  Widget build(BuildContext context) {
    final destinosFavoritos = destinos
        .where((destino) => favoritos.contains(destino.nome))
        .toList();

    if (destinosFavoritos.isEmpty) {
      return const Center(
        key: ValueKey<String>('favoritos_vazio'),
        child: Text('Você ainda não favoritou nenhum destino.'),
      );
    }

    return ListView(
      key: const ValueKey<String>('favoritos_page'),
      padding: const EdgeInsets.all(16),
      children: destinosFavoritos
          .map(
            (destino) => Card(
              child: ListTile(
                leading: const Icon(Icons.favorite),
                title: Text(destino.nome),
                subtitle: Text('Pacote a partir de R\$ ${destino.preco.toStringAsFixed(0)}'),
              ),
            ),
          )
          .toList(),
    );
  }
}

class PerfilPage extends StatelessWidget {
  const PerfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      key: const ValueKey<String>('perfil_page'),
      padding: const EdgeInsets.all(16),
      children: const [
        CircleAvatar(
          radius: 36,
          child: Icon(Icons.person, size: 40),
        ),
        SizedBox(height: 16),
        Center(
          child: Text(
            'Comandante Aurora',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
        ),
        SizedBox(height: 8),
        Center(
          child: Text('Nível de explorador: Interplanetário'),
        ),
        SizedBox(height: 24),
        Card(
          child: ListTile(
            leading: Icon(Icons.rocket_launch_outlined),
            title: Text('Viagens concluídas'),
            trailing: Text('12'),
          ),
        ),
        Card(
          child: ListTile(
            leading: Icon(Icons.star_outline),
            title: Text('Pontuação galáctica'),
            trailing: Text('8.940'),
          ),
        ),
      ],
    );
  }
}
