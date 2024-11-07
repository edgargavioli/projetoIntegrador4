import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:projeto_integrador/components/custom_notification.dart';

void main() {
  testWidgets('CustomNotification displays title and message', (WidgetTester tester) async {
    // Definindo os valores de título e mensagem
    const title = 'Attention!';
    const message = 'This is a notification message.';

    // Monta o widget CustomNotification
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CustomNotification(
            title: title,
            message: message,
          ),
        ),
      ),
    );

    // Verifica se o título e a mensagem são exibidos corretamente
    expect(find.text(title), findsOneWidget);
    expect(find.text(message), findsOneWidget);

    // Verifica se o ícone de erro está presente
    expect(find.byIcon(Icons.error_outline), findsOneWidget);
  });

  testWidgets('CustomNotification has correct card styling', (WidgetTester tester) async {
    // Monta o widget CustomNotification
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CustomNotification(
            title: 'Test Title',
            message: 'Test Message',
          ),
        ),
      ),
    );

    // Verifica se o Card está presente
    expect(find.byType(Card), findsOneWidget);

    // Verifica se o Card tem a cor correta
    final cardWidget = tester.widget<Card>(find.byType(Card));
    expect(cardWidget.color, Colors.amber.shade600);

    // Verifica se o Card tem bordas arredondadas
    expect(cardWidget.shape, isA<RoundedRectangleBorder>());
  });
}
