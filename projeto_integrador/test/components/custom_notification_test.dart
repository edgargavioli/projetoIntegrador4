import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:projeto_integrador/components/custom_notification.dart';

void main() {
  testWidgets('CustomNotification exibe o título e a mensagem', (WidgetTester tester) async {
    // Definindo os valores de título e mensagem
    const titulo = 'Atenção!';
    const mensagem = 'Esta é uma mensagem de notificação.';

    // Monta o widget CustomNotification
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CustomNotification(
            title: titulo,
            message: mensagem,
          ),
        ),
      ),
    );

    // Verifica se o título e a mensagem são exibidos corretamente
    expect(find.text(titulo), findsOneWidget);
    expect(find.text(mensagem), findsOneWidget);

    // Verifica se o ícone de erro está presente
    expect(find.byIcon(Icons.error_outline), findsOneWidget);
  });

  testWidgets('CustomNotification tem o estilo correto no Card', (WidgetTester tester) async {
    // Monta o widget CustomNotification
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CustomNotification(
            title: 'Título de Teste',
            message: 'Mensagem de Teste',
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
