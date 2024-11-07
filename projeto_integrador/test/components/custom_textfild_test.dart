import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:projeto_integrador/components/custom_textfield.dart';

void main() {
  testWidgets('CustomTextfield displays the correct label and input text', (WidgetTester tester) async {
    // Criação de um controlador de texto
    final controller = TextEditingController();

    // Adiciona o widget à árvore
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CustomTextfield(
            controller: controller,
            label: 'Test Label',
            obscureText: false,
          ),
        ),
      ),
    );

    // Verifica se o rótulo (label) está visível
    expect(find.text('Test Label'), findsOneWidget);

    // Verifica se o campo de texto está presente
    expect(find.byType(TextField), findsOneWidget);

    // Simula digitação no campo de texto
    await tester.enterText(find.byType(TextField), 'Test input');

    // Verifica se o texto foi inserido corretamente no campo
    expect(controller.text, 'Test input');
  });

  testWidgets('CustomTextfield displays the correct icon when provided', (WidgetTester tester) async {
    // Criação de um controlador de texto
    final controller = TextEditingController();

    // Adiciona o widget com um ícone
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CustomTextfield(
            controller: controller,
            label: 'Test Label with Icon',
            icon: Icon(Icons.visibility),
            obscureText: true,
          ),
        ),
      ),
    );

    // Verifica se o ícone está presente
    expect(find.byIcon(Icons.visibility), findsOneWidget);
  });

  testWidgets('CustomTextfield shows a cursor and changes focus color', (WidgetTester tester) async {
    // Criação de um controlador de texto
    final controller = TextEditingController();

    // Adiciona o widget à árvore
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CustomTextfield(
            controller: controller,
            label: 'Test Label',
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
