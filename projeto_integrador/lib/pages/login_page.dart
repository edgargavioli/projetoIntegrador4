import 'package:flutter/material.dart';
import 'package:projeto_integrador/components/custom_button.dart';
import 'package:projeto_integrador/components/custom_textfield.dart';
import 'package:projeto_integrador/models/token.dart';
import 'package:projeto_integrador/pages/user_registration_page.dart';
import 'package:projeto_integrador/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatelessWidget {


  final TextEditingController _usernameControler = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginPage({super.key});

  void login(BuildContext context) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String username = _usernameControler.text;
      String password = _passwordController.text;
    
      Token token = await AuthService.login(username, password);
      await prefs.setString('token', token.toString());
      
      Navigator.pushNamed(context, '/home');
    } on FormatException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.message),
        backgroundColor: Theme.of(context).colorScheme.error,
      ));
    }
  }

  Future<void> _navigateToUserRegistrationPage(BuildContext context) async {
    final bool? result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const UserRegistrationPage(),
      ),
    );

    if (result == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Usuário cadastrado com sucesso!'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 125, 0, 0),
            child: Column(
              children: [
                Image.asset("assets/images/logo.png"),
                const Text(
                  "BIOPARK",
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                ),
                Text(
                  "INVENTÁRIO",
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.error,
                  ),
                ),
                const SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Column(
                    children: [
                      CustomTextfield(
                        controller: _usernameControler,
                        label: "E-mail",
                        obscureText: false,
                      ),
                      const SizedBox(height: 15),
                      CustomTextfield(
                        controller: _passwordController,
                        label: "Senha",
                        obscureText: true,
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Mantenha-me conectado",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                          Checkbox(
                            value: true,
                            onChanged: null,
                            fillColor: MaterialStateProperty.all(
                              Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      SizedBox(
                        width: double.infinity,
                        child: CustomButton(
                          onPressed: () {
                            login(context);
                          },
                          label: "Entrar",
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "Esqueci a senha",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.error,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Não possui uma conta? ",
                            style: TextStyle(fontSize: 15),
                          ),
                          TextButton(
                            onPressed: () {
                              _navigateToUserRegistrationPage(context);
                            },
                            child: Text(
                              "Crie uma",
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.error,
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
