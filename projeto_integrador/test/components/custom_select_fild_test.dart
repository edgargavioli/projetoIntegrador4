import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:projeto_integrador/components/custom_select_field.dart'; // Substitua pelo seu caminho correto

void main() {
  testWidgets('CustomSelectField updates selected value', (WidgetTester tester) async {
    // Cria uma variável para armazenar o valor selecionado
    String? selectedValue;

    // Lista de itens para o Dropdown
    final items = <DropdownMenuItem<String>>[
      DropdownMenuItem<String>(
        value: 'Option 1',
        child: Text('Option 1'),
      ),
      DropdownMenuItem<String>(
        value: 'Option 2',
        child: Text('Option 2'),
      ),
      DropdownMenuItem<String>(
        value: 'Option 3',
        child: Text('Option 3'),
      ),
    ];

    // Adiciona o widget CustomSelectField ao teste
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CustomSelectField(
            label: 'Select Option',
            items: items,
            selectedValue: selectedValue,
            onChanged: (String? newValue) {
              selectedValue = newValue;
            },
          ),
        ),
      ),
    );

    // Verifica se o label está presente
    expect(find.text('Select Option'), findsOneWidget);

    // Simula a abertura do dropdown
    await tester.tap(find.byType(DropdownButtonFormField<String>));
    await tester.pumpAndSettle(); // Aguarda o dropdown ser aberto

    // Verifica se as opções do dropdown estão presentes
    expect(find.text('Option 1'), findsOneWidget);
    expect(find.text('Option 2'), findsOneWidget);
    expect(find.text('Option 3'), findsOneWidget);

    // Simula a seleção de uma opção
    await tester.tap(find.text('Option 2').last);
    await tester.pumpAndSettle(); // Aguarda o fechamento do dropdown

    // Verifica se o valor selecionado foi atualizado corretamente
    expect(selectedValue, 'Option 2'); // O valor da seleção deve ser 'Option 2'

    // Verifica se o valor selecionado aparece no campo
    expect(find.text('Option 2'), findsOneWidget);
  });
}
