import 'package:flutter_test/flutter_test.dart';
import 'package:abcd_app/main.dart';

void main() {
  testWidgets('App starts and shows Home Screen', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const ABCDApp());

    // Verify that the app title is shown
    expect(find.text('ABCD App'), findsOneWidget);
    
    // Verify that the menu buttons are shown
    expect(find.text('Alphabets'), findsOneWidget);
    expect(find.text('Shapes'), findsOneWidget);
  });
}
