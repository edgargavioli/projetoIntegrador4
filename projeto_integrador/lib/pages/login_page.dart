import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:projeto_integrador/components/custom_button.dart';
import 'package:projeto_integrador/components/custom_textfield.dart';

class LoginPage extends StatelessWidget {

  final TextEditingController _usernameControler = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginPage({super.key});

  void login() async {
    try {
      String username = _usernameControler.text;
      String password = _passwordController.text;

      final response = await post(
      Uri.parse("http://10.0.2.2:8080/login"), // substituir pela URL do servidor
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'username': username, 'password': password}),
    );

    if (response.statusCode == 200) {
      print('Success: ${response.body}');
    } else {
      print('Failed to login. Status code: ${response.statusCode}');
    }

    } catch (e) {
      print(e);
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
            // mainAxisAlignment: MainAxisAlignment.center,
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
                padding: EdgeInsets.symmetric(horizontal: 50),
                child: Column(
                  children: [
                    CustomTextfield(controller: _usernameControler, label: "E-mail"),
              
                    const SizedBox(height: 15,),
          
                    CustomTextfield(controller: _passwordController, label: "Senha"),
                    
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
                      child: CustomButton(onPressed: login, label: "Entrar",)
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