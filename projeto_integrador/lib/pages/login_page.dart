import 'package:flutter/material.dart';
import 'package:projeto_integrador/components/custom_button.dart';
import 'package:projeto_integrador/components/custom_textfield.dart';
import 'package:projeto_integrador/services/auth_service.dart';

class LoginPage extends StatelessWidget {

  final TextEditingController _usernameControler = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginPage({super.key});

  void login(BuildContext context) async {
    try {
      String username = _usernameControler.text;
      String password = _passwordController.text;
    
      await AuthService.login(username, password);
      
      Navigator.pushNamed(context, '/home');
    
    } on FormatException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message),
          backgroundColor: Theme.of(context).colorScheme.error,
        )
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 125, 0, 0),
          child: Column(
            children: [
              Image.asset("assets/images/logo.png"),
              const Text(
                "BIOPARK",
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold
                ),
              ),
              Text(
                "INVENTÁRIO",
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.error
                )
              ),
          
              const SizedBox(height: 40,),
          
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Column(
                  children: [
                    CustomTextfield(controller: _usernameControler, label: "E-mail", obscureText: false,),
              
                    const SizedBox(height: 15,),
          
                    CustomTextfield(controller: _passwordController, label: "Senha", obscureText: true,),
                    
                    const SizedBox(height: 5,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Mantenha-me conectado",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary
                          ),
                        ),
                        Checkbox(
                          value: true,
                          onChanged: null,
                          fillColor: WidgetStateProperty.all(Theme.of(context).colorScheme.secondary),
                        )
                      ],
                    ),

                    const SizedBox(height: 5,),

                    SizedBox(
                      width: double.infinity,
                      child: CustomButton(onPressed: () {login(context);} , label: "Entrar",)
                    ),

                    const SizedBox(height: 5,),

                    Text(
                      "Esqueci a senha",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                        fontSize: 15,
                        fontWeight: FontWeight.w600
                      ),
                    ),

                    const SizedBox(height: 5,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Não possui uma conta? ",
                          style: TextStyle(
                            fontSize: 15
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/createAccount');
                          },
                          child: Text(
                          "Crie uma",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.error,
                            fontSize: 15,
                            fontWeight: FontWeight.w600
                          ),
                          )
                          
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}