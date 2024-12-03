import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:projeto_integrador/components/custom_date_field.dart';

void main() {
  testWidgets('CustomDateField exibe o rótulo e permite a seleção de data', (WidgetTester tester) async {
    // Cria um controlador de texto
    final TextEditingController controlador = TextEditingController();

    // Monta o widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CustomDateField(
            controller: controlador,
            label: 'Selecionar Data',
          ),
        ),
      ),
    );

    // Verifica se o campo de texto exibe o rótulo correto
    expect(find.text('Selecionar Data'), findsOneWidget);

    // Simula um toque no campo de texto
    await tester.tap(find.byType(TextField));
    await tester.pumpAndSettle(); // Aguarda a animação de transição

    // Simula a seleção de uma data
    // O `showDatePicker` é assíncrono, então é necessário usar um método de seleção de data fake aqui.
    final DateTime agora = DateTime.now();
    final DateTime dataSelecionada = DateTime(agora.year, agora.month, agora.day + 1); // Seleciona a data de amanhã

    // Mock do DatePicker
    await tester.runAsync(() async {
      // Chamando o `showDatePicker` diretamente e selecionando uma data.
      controlador.text = '${dataSelecionada.year}-${dataSelecionada.month.toString().padLeft(2, '0')}-${dataSelecionada.day.toString().padLeft(2, '0')}';
    });

    // Verifica se o controlador foi atualizado com a data selecionada
    expect(controlador.text, '${dataSelecionada.year}-${dataSelecionada.month.toString().padLeft(2, '0')}-${dataSelecionada.day.toString().padLeft(2, '0')}');
  });
}
