import 'package:flutter_test/flutter_test.dart';
import 'package:roteiro_estelar/main.dart';

void main() {
  testWidgets('renderiza shell com navigation bar', (tester) async {
    await tester.pumpWidget(const RoteiroEstelarApp());

    expect(find.text('Roteiro Estelar'), findsOneWidget);
    expect(find.text('Início'), findsOneWidget);
    expect(find.text('Destinos'), findsOneWidget);
  });
}
