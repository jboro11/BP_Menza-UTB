// zakladni test - jen ze se appka spusti

import 'package:flutter_test/flutter_test.dart';
import 'package:menza_foto/main.dart';

void main() {
  testWidgets('App se spusti', (WidgetTester tester) async {
    await tester.pumpWidget(const MenzaFotoApp());
    expect(find.text('Zadejte PIN'), findsOneWidget);
  });
}
