import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:projeto_integrador/components/custom_button.dart';

void main() {
  testWidgets('CustomButton displays label and responds to press', (WidgetTester tester) async {
    // Variável para verificar se a função onPressed foi chamada
    bool wasPressed = false;

    // Cria o CustomButton com um onPressed que altera a variável
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CustomButton(
            onPressed: () {
              wasPressed = true; // Altera o estado quando pressionado
            },
            label: 'Click Me',
          ),
        ),
      ),
    );

    // Verifica se o botão exibe o texto correto
    expect(find.text('Click Me'), findsOneWidget);

    // Pressiona o botão
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump(); // Aguarda a conclusão da animação

    // Verifica se a função onPressed foi chamada
    expect(wasPressed, true);
  });

  testWidgets('CustomButton has correct style', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CustomButton(
            onPressed: () {},
            label: 'Styled Button',
          ),
        ),
      ),
    );

    // Verifica se o botão é um ElevatedButton
    expect(find.byType(ElevatedButton), findsOneWidget);

    // Verifica se o texto do botão está estilizado corretamente
    final textFinder = find.text('Styled Button');
    final textWidget = tester.widget<Text>(textFinder);

    // Obtém o contexto para verificar a cor do texto
    final BuildContext context = tester.element(textFinder);

    // Verifica a cor do texto
    expect(textWidget.style?.color, Theme.of(context).colorScheme.surface);
    // Verifica se a fonte é bold
    expect(textWidget.style?.fontWeight, FontWeight.bold);
  });
}
