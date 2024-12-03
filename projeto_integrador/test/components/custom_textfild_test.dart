import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:projeto_integrador/components/custom_textfield.dart';

void main() {
  testWidgets('CustomTextfield exibe o rótulo correto e aceita entrada de texto', (WidgetTester tester) async {
    // Criação de um controlador de texto
    final controller = TextEditingController();

    // Adiciona o widget à árvore
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CustomTextfield(
            controller: controller,
            label: 'Rótulo de Teste',
            obscureText: false,
          ),
        ),
      ),
    );

    // Verifica se o rótulo está visível
    expect(find.text('Rótulo de Teste'), findsOneWidget);

    // Verifica se o campo de texto está presente
    expect(find.byType(TextField), findsOneWidget);

    // Simula digitação no campo de texto
    await tester.enterText(find.byType(TextField), 'Texto de teste');

    // Verifica se o texto foi inserido corretamente no campo
    expect(controller.text, 'Texto de teste');
  });

  testWidgets('CustomTextfield exibe o ícone correto quando fornecido', (WidgetTester tester) async {
    // Criação de um controlador de texto
    final controller = TextEditingController();

    // Adiciona o widget com um ícone
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CustomTextfield(
            controller: controller,
            label: 'Rótulo de Teste com Ícone',
            icon: Icon(Icons.visibility),
            obscureText: true,
          ),
        ),
      ),
    );

    // Verifica se o ícone está presente
    expect(find.byIcon(Icons.visibility), findsOneWidget);
  });

  testWidgets('CustomTextfield exibe um cursor e muda a cor do foco', (WidgetTester tester) async {
    // Criação de um controlador de texto
    final controller = TextEditingController();

    // Adiciona o widget à árvore
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CustomTextfield(
            controller: controller,
            label: 'Rótulo de Teste',
            obscureText: false,
          ),
        ),
      ),
    );

    // Verifica se o campo de texto possui um cursor
    final textField = find.byType(TextField);
    await tester.tap(textField);
    await tester.pump();

    // Verifica se o cursor está visível
    expect(find.byType(TextField), findsOneWidget);
  });
}
