import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:projeto_integrador/components/custom_app_bar.dart';

void main() {
  // Teste para verificar se o AppBar é exibido corretamente
  testWidgets('CustomAppBar exibe o logo e o botão de logout', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          appBar: const CustomAppBar(),
        ),
      ),
    );

    // Verifica se o logo é exibido
    expect(find.byType(Image), findsOneWidget);
    // Verifica se o botão de logout é exibido
    expect(find.byIcon(Icons.logout), findsOneWidget);
  });

  // Teste para verificar o comportamento do botão de logout
  testWidgets('Botão de logout do CustomAppBar navega para a página de login', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          appBar: const CustomAppBar(),
        ),
        routes: {
          '/login': (context) => Scaffold(body: Text('Página de Login')),
        },
      ),
    );

    // Pressiona o botão de logout
    await tester.tap(find.byIcon(Icons.logout));
    await tester.pumpAndSettle(); // Aguarda a animação de navegação

    // Verifica se a página de login é exibida
    expect(find.text('Página de Login'), findsOneWidget);
  });

  // Teste para verificar que o botão de voltar não é exibido na rota home
  testWidgets('CustomAppBar não exibe o botão de voltar na rota inicial', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        initialRoute: '/home',
        routes: {
          '/home': (context) => Scaffold(appBar: const CustomAppBar()),
          '/login': (context) => Scaffold(body: Text('Página de Login')),
        },
      ),
    );

    // Verifica se o botão de voltar não é exibido
    expect(find.byIcon(Icons.arrow_back), findsNothing);
  });
}
