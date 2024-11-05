import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:projeto_integrador/components/custom_textfield.dart';

void main() {
  testWidgets('CustomTextField displays label and captures input', (WidgetTester tester) async {
    // Definindo um TextEditingController para capturar a entrada
    final controller = TextEditingController();

    // Definindo o rótulo e o ícone de teste
    const label = 'Enter text';
    const icon = Icon(Icons.text_fields);

    // Monta o widget CustomTextField
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CustomTextfield(
            controller: controller,
            label: label,
            icon: icon,
            obscureText: false, // Mudar para true para testar a ocultação de texto
          ),
        ),
      ),
    );

    // Verifica se o rótulo está exibido corretamente
    expect(find.text(label), findsOneWidget);

    // Insere texto no campo
    await tester.enterText(find.byType(TextField), 'Test Input');
    expect(controller.text, 'Test Input'); // Verifica se o controlador contém o texto inserido
  });

  testWidgets('CustomTextField obscures text when obscureText is true', (WidgetTester tester) async {
    final controller = TextEditingController();
    const label = 'Enter password';

    // Monta o widget CustomTextField com obscureText=true
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CustomTextfield(
            controller: controller,
            label: label,
            icon: Icon(Icons.lock),
            obscureText: true,
          ),
        ),
      ),
    );

    // Insere texto no campo
    await tester.enterText(find.byType(TextField), 'SecretPassword');

    // Verifica se o texto inserido não é visível
    final textFieldFinder = find.byType(TextField);
    expect(tester.widget<TextField>(textFieldFinder).obscureText, isTrue);
  });

  testWidgets('CustomTextField displays suffix icon', (WidgetTester tester) async {
    final controller = TextEditingController();
    const label = 'Enter text';
    const icon = Icon(Icons.text_fields);

    // Monta o widget CustomTextField
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CustomTextfield(
            controller: controller,
            label: label,
            icon: icon,
            obscureText: false,
          ),
        ),
      ),
    );

    // Verifica se o ícone está presente
    expect(find.byIcon(Icons.text_fields), findsOneWidget);
  });
}
