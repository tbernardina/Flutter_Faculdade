import 'package:flutter_test/flutter_test.dart';
import 'package:roteiro_estelar/main.dart';

void main() {
  testWidgets('renderiza shell do guia do mapa astral', (tester) async {
    await tester.pumpWidget(const MapaAstralApp());

    expect(find.text('Guia do Mapa Astral'), findsOneWidget);
    expect(find.text('Introdução'), findsOneWidget);
    expect(find.text('Signos'), findsOneWidget);
    expect(find.text('Casas'), findsOneWidget);
    expect(find.text('Leitura'), findsOneWidget);
  });
}
