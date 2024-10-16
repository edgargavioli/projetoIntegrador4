import 'package:flutter/material.dart';
import 'package:projeto_integrador/pages/login_page.dart';
import 'package:projeto_integrador/services/auth_service.dart';

class AuthGuard extends StatelessWidget {
  final Widget page;
  AuthGuard(this.page);

  @override
  Widget build(BuildContext context) {
    // Usamos FutureBuilder para lidar com a verificação de autenticação assíncrona
    return FutureBuilder<bool>(
      future: AuthService.isAuthenticated(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Exibe um indicador de carregamento enquanto verifica a autenticação
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasData && snapshot.data == true) {
          // Se autenticado, mostra a página protegida
          return page;
        } else {
          // Se não autenticado, redireciona para a tela de login
          return LoginPage();
        }
      },
    );
  }
}
