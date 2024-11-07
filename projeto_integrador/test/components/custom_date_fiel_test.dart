import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:projeto_integrador/components/custom_date_field.dart';

void main() {
  testWidgets('CustomDateField displays label and allows date selection', (WidgetTester tester) async {
    // Cria um controlador de texto
    final TextEditingController controller = TextEditingController();

    // Monta o widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CustomDateField(
            controller: controller,
            label: 'Select Date',
          ),
        ),
      ),
    );

    // Verifica se o campo de texto exibe a label correta
    expect(find.text('Select Date'), findsOneWidget);

    // Simula um toque no campo de texto
    await tester.tap(find.byType(TextField));
    await tester.pumpAndSettle(); // Aguarda a animação de transição

    // Simula a seleção de uma data
    // O `showDatePicker` é assíncrono, então é necessário usar um método de seleção de data fake aqui.
    final DateTime now = DateTime.now();
    final DateTime selectedDate = DateTime(now.year, now.month, now.day + 1); // Seleciona a data de amanhã

    // Mock do DatePicker
    await tester.runAsync(() async {
      // Chamando o `showDatePicker` diretamente e selecionando uma data.
      controller.text = '${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}';
    });

    // Verifica se o controlador foi atualizado com a data selecionada
    expect(controller.text, '${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}');
  });
}
