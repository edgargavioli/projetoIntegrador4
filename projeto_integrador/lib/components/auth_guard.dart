import 'package:flutter/material.dart';
import 'package:projeto_integrador/pages/login_page.dart';
import 'package:projeto_integrador/services/auth_service.dart';

class AuthGuard extends StatelessWidget {
  final Widget page;
  const AuthGuard(this.page, {super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: AuthService.isAuthenticated(), // Chama a função assíncrona
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Exibe um indicador de carregamento enquanto aguarda a resposta
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData && snapshot.data == true) {
          // Usuário autenticado, mostra a página protegida
          return page;
        } else {
          // Usuário não autenticado, redireciona para a página de login
          return LoginPage();
        }
      },
    );
  }
}
