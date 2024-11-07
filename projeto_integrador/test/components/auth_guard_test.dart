import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:projeto_integrador/components/auth_guard.dart';
import 'package:projeto_integrador/pages/login_page.dart';
import 'package:projeto_integrador/services/auth_service.dart';

// Criando um Mock para o AuthService
class MockAuthService extends Mock implements AuthService {}

void main() {
  // Criando o mock do AuthService
  final mockAuthService = MockAuthService();

  setUp(() {
    // Reseta os mocks antes de cada teste para garantir que não haja interações anteriores
    reset(mockAuthService);
  });

  testWidgets('AuthGuard displays loading indicator while checking authentication', (WidgetTester tester) async {
    // Simula que o AuthService está verificando a autenticação
    when(mockAuthService.isAuthenticated()).thenAnswer((_) async => false);

    // Adiciona o AuthGuard com a página de login
    await tester.pumpWidget(
      newMethod(mockAuthService),
    );

    // Verifica se o indicador de carregamento está visível
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    // Aguarda o Future ser resolvido
    await tester.pumpAndSettle(); // Espera o Future ser resolvido
  });

  testWidgets('AuthGuard displays the login page if not authenticated', (WidgetTester tester) async {
    // Simula que o AuthService retornará que o usuário não está autenticado
    when(mockAuthService.isAuthenticated()).thenAnswer((_) async => false);

    // Adiciona o AuthGuard com a página de login
    await tester.pumpWidget(
      MaterialApp(
        home: AuthGuard(authService: mockAuthService, child: LoginPage()),
      ),
    );

    // Aguarda o Future ser resolvido
    await tester.pumpAndSettle(); // Espera o Future ser resolvido

    // Verifica se a página de login é exibida
    expect(find.byType(LoginPage), findsOneWidget);
  });

  testWidgets('AuthGuard displays the protected page if authenticated', (WidgetTester tester) async {
    // Simula que o AuthService retornará que o usuário está autenticado
    when(mockAuthService.isAuthenticated()).thenAnswer((_) async => true);

    // Página protegida simulada
    final protectedPage = Scaffold(
      appBar: AppBar(title: Text('Protected Page')),
      body: Center(child: Text('This is a protected page')),
    );

    // Adiciona o AuthGuard com a página protegida
    await tester.pumpWidget(
      MaterialApp(
        home: AuthGuard(authService: mockAuthService, child: protectedPage),
      ),
    );

    // Aguarda o Future ser resolvido
    await tester.pumpAndSettle(); // Espera o Future ser resolvido

    // Verifica se a página protegida é exibida
    expect(find.text('This is a protected page'), findsOneWidget);
  });
}

MaterialApp newMethod(MockAuthService mockAuthService) {
  return MaterialApp(
      home: AuthGuard(authService: mockAuthService, child: LoginPage()),
    );
}
