import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:projeto_integrador/components/custom_button.dart';

void main() {
  testWidgets('CustomButton exibe o texto e responde ao pressionamento', (WidgetTester tester) async {
    // Variável para verificar se a função onPressed foi chamada
    bool foiPressionado = false;

    // Cria o CustomButton com um onPressed que altera a variável
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CustomButton(
            onPressed: () {
              foiPressionado = true; // Altera o estado quando pressionado
            },
            label: 'Clique Aqui',
          ),
        ),
      ),
    );

    // Verifica se o botão exibe o texto correto
    expect(find.text('Clique Aqui'), findsOneWidget);

    // Pressiona o botão
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump(); // Aguarda a conclusão da animação

    // Verifica se a função onPressed foi chamada
    expect(foiPressionado, true);
  });

  testWidgets('CustomButton possui o estilo correto', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CustomButton(
            onPressed: () {},
            label: 'Botão Estilizado',
          ),
        ),
      ),
    );

    // Verifica se o botão é um ElevatedButton
    expect(find.byType(ElevatedButton), findsOneWidget);

    // Verifica se o texto do botão está estilizado corretamente
    final localizadorTexto = find.text('Botão Estilizado');
    final widgetTexto = tester.widget<Text>(localizadorTexto);

    // Obtém o contexto para verificar a cor do texto
    final BuildContext contexto = tester.element(localizadorTexto);

    // Verifica a cor do texto
    expect(widgetTexto.style?.color, Theme.of(contexto).colorScheme.surface);
    // Verifica se a fonte é bold
    expect(widgetTexto.style?.fontWeight, FontWeight.bold);
  });
}
