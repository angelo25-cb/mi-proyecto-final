// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:smart_break/main.dart';
import 'package:smart_break/dao/mock_dao_factory.dart';

void main() {
  testWidgets('Welcome screen loads correctly', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      Provider(
        create: (_) => MockDAOFactory(),
        child: const SmartBreakApp(),
      ),
    );

    // Verify that the welcome screen loads
    expect(find.text('Smart Break'), findsOneWidget);
    expect(find.text('Encuentra espacios tranquilos para estudiar'), findsOneWidget);
  });
}
