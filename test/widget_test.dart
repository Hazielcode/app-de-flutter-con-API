import 'package:flutter_test/flutter_test.dart';

import 'package:crudcito/main.dart';

void main() {
  testWidgets('GoogleStore login screen test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const GoogleStoreApp());

    // Verify that our app shows Google Developers
    expect(find.text('Google Developers'), findsOneWidget);
    expect(find.text('Portal Corporativo de Ingeniería'), findsOneWidget);
  });
}
