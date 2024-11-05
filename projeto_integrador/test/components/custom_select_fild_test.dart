import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:projeto_integrador/components/custom_select_field.dart';

void main() {
  testWidgets('CustomSelectField displays label and dropdown items', (WidgetTester tester) async {
    // Definindo os valores de teste
    const label = 'Select an option';
    const items = [
      DropdownMenuItem<String>(value: 'option1', child: Text('Option 1')),
      DropdownMenuItem<String>(value: 'option2', child: Text('Option 2')),
    ];

    // Monta o widget CustomSelectField
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CustomSelectField(
            label: label,
            items: items,
          ),
        ),
      ),
    );

    // Verifica se o rótulo está exibido corretamente
    expect(find.text(label), findsOneWidget);

    // Abre o dropdown
    await tester.tap(find.byType(DropdownButtonFormField<String>));
    await tester.pumpAndSettle(); // Aguarda a animação

    // Verifica se as opções do dropdown estão presentes
    expect(find.text('Option 1'), findsOneWidget);
    expect(find.text('Option 2'), findsOneWidget);
  });

  testWidgets('CustomSelectField can select an option', (WidgetTester tester) async {
    // Definindo os valores de teste
    const label = 'Select an option';
    const items = [
      DropdownMenuItem<String>(value: 'option1', child: Text('Option 1')),
      DropdownMenuItem<String>(value: 'option2', child: Text('Option 2')),
    ];
    String? selectedValue;

    // Monta o widget CustomSelectField
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CustomSelectField(
            label: label,
            items: items,
            selectedValue: selectedValue,
            onChanged: (value) {
              selectedValue = value; // Atualiza o valor selecionado
            },
          ),
        ),
      ),
    );

    // Abre o dropdown
    await tester.tap(find.byType(DropdownButtonFormField<String>));
    await tester.pumpAndSettle(); // Aguarda a animação

    // Seleciona a opção 'Option 1'
    await tester.tap(find.text('Option 1').last);
    await tester.pumpAndSettle(); // Aguarda a animação

    // Verifica se o valor selecionado foi atualizado
    expect(selectedValue, 'option1');
  });
}
