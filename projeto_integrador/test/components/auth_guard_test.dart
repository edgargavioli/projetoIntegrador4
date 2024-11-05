import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:projeto_integrador/pages/login_page.dart';
import 'package:projeto_integrador/services/auth_service.dart';
import 'package:projeto_integrador/components/auth_guard.dart';

// Implementação simples do AuthService
class DummyAuthService {
  static Future<bool> isAuthenticated() async {
    return false; // Simula o estado não autenticado
  }
}

// Implementação que simula estado autenticado
class AuthServiceAuthenticated {
  static Future<bool> isAuthenticated() async {
    return true; // Simula o estado autenticado
  }
}

void main() {
  testWidgets('AuthGuard shows LoginPage when not authenticated', (WidgetTester tester) async {
    // Altera a função isAuthenticated para a versão dummy
    AuthService.isAuthenticated = DummyAuthService.isAuthenticated;

    await tester.pumpWidget(
      MaterialApp(
        home: AuthGuard(Container()), // Passa uma página simples como teste
      ),
    );

    // Verifica se o LoginPage é exibido
    expect(find.byType(LoginPage), findsOneWidget);
  });

  testWidgets('AuthGuard shows protected page when authenticated', (WidgetTester tester) async {
    // Altera a função isAuthenticated para a versão autenticada
    AuthService.isAuthenticated = AuthServiceAuthenticated.isAuthenticated;

    await tester.pumpWidget(
      MaterialApp(
        home: AuthGuard(Container()), // Passa uma página simples como teste
      ),
    );

    // Verifica se a página protegida é exibida
    expect(find.byType(Container), findsOneWidget); // Verifica se o container está presente
    expect(find.byType(LoginPage), findsNothing); // Verifica que a página de login não está presente
  });

  testWidgets('AuthGuard shows loading indicator while waiting', (WidgetTester tester) async {
    // Simula uma espera na função de autenticação com um atraso
    AuthService.isAuthenticated = () async {
      await Future.delayed(Duration(seconds: 2)); // Simula um atraso
      return false; // Simula não autenticado
    };

    await tester.pumpWidget(
      MaterialApp(
        home: AuthGuard(Container()),
      ),
    );

    // Verifica se o indicador de carregamento é exibido
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    // Aguarda o atraso
    await tester.pumpAndSettle();
    // Verifica se a página de login é exibida após o atraso
    expect(find.byType(LoginPage), findsOneWidget);
  });
}
