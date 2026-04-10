import 'package:flutter_test/flutter_test.dart';
import 'package:roteiro_estelar/main.dart';

void main() {
  testWidgets('renderiza shell e controles interativos principais', (tester) async {
    await tester.pumpWidget(const MapaAstralInterativoApp());

    expect(find.text('Mapa Astral Interativo'), findsOneWidget);
    expect(find.text('Início'), findsOneWidget);
    expect(find.text('Signos'), findsOneWidget);
    expect(find.text('Casas'), findsOneWidget);
    expect(find.text('Leitura'), findsOneWidget);
    expect(find.text('Concluir sessão'), findsOneWidget);
    expect(find.text('Modo completo'), findsOneWidget);
  });
}
