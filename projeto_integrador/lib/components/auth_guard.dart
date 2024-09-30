import 'package:flutter/material.dart';
import 'package:projeto_integrador/pages/login_page.dart';
import 'package:projeto_integrador/services/auth_service.dart';

class AuthGuard extends StatelessWidget {
  final Widget page;
  AuthGuard(this.page);

  @override
  Widget build(BuildContext context) {
    // Verifica se o usuário está autenticado
    if (AuthService.isAuthenticated()) {
      return page;  // Se estiver autenticado, mostra a página protegida
    } else {
      // Se não estiver autenticado, redireciona para a tela de login
      return LoginPage();
    }
  }
}