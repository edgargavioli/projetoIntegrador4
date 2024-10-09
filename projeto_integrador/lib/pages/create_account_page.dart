import 'package:flutter/material.dart';
import 'package:projeto_integrador/components/custom_button.dart';
import 'package:projeto_integrador/components/custom_textfield.dart';

class CreateAccountPage extends StatelessWidget {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _sobrenomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _cadastroController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final TextEditingController _confirmarSenhaController = TextEditingController();

  CreateAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
          child: Column(
            children: [
              Image.asset("assets/images/logo.png", scale: 2,),
              const Text(
                "BIOPARK",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold
                ),
              ),
              Text(
                "INVENTÁRIO",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.error
                )
              ),

              const SizedBox(height: 40,),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Column(
                  children: [
                    CustomTextfield(controller: _nomeController, label: "Nome", obscureText: false,),
                    
                    const SizedBox(height: 15,),
                    
                    CustomTextfield(controller: _sobrenomeController, label: "Sobrenome", obscureText: false,),
                    
                    const SizedBox(height: 15,),
                    
                    CustomTextfield(controller: _emailController, label: "E-mail", obscureText: false,),
                    
                    const SizedBox(height: 15,),
                    
                    CustomTextfield(controller: _cadastroController, label: "Número de cadastro", obscureText: false,),
                                
                    const SizedBox(height: 15,),
                    
                    CustomTextfield(controller: _senhaController, label: "Senha", obscureText: true,),
                    
                    const SizedBox(height: 15,),
                    
                    CustomTextfield(controller: _confirmarSenhaController, label: "Confirmar Senha", obscureText: true,),

                    const SizedBox(height: 15,),

                    SizedBox(
                      width: double.infinity,
                      child: CustomButton(onPressed: () {}, label: "Cadastrar",)
                    ),

                    const SizedBox(height: 15,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Já possui uma conta?",
                          style: TextStyle(
                            fontSize: 15
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                          "Entrar",
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