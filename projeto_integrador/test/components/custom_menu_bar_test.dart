import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:projeto_integrador/components/custom_menu_bar.dart';

void main() {
  testWidgets('CustomMenuBar exibe os rótulos corretos e lida com a seleção', (WidgetTester tester) async {
    // Variável para verificar qual página foi selecionada
    int indicePaginaSelecionada = 0;

    // Função para capturar a seleção da página
    void aoSelecionarPagina(int indice) {
      indicePaginaSelecionada = indice;
    }

    // Monta o widget CustomMenuBar
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CustomMenuBar(
            currentPageIndex: indicePaginaSelecionada,
            onPageSelected: aoSelecionarPagina,
          ),
        ),
      ),
    );

    // Verifica se todos os itens do menu são exibidos
    expect(find.text('Inventário'), findsOneWidget);
    expect(find.text('Usuários'), findsOneWidget);
    expect(find.text('Emprestantes'), findsOneWidget);
    expect(find.text('Avisos'), findsOneWidget);

    // Simula a seleção da segunda página (Usuários)
    await tester.tap(find.text('Usuários'));
    await tester.pumpAndSettle(); // Aguarda a animação de transição

    // Verifica se a página selecionada foi atualizada corretamente
    expect(indicePaginaSelecionada, 1);

    // Simula a seleção da terceira página (Emprestantes)
    await tester.tap(find.text('Emprestantes'));
    await tester.pumpAndSettle(); // Aguarda a animação de transição

    // Verifica se a página selecionada foi atualizada corretamente
    expect(indicePaginaSelecionada, 2);
  });
}
