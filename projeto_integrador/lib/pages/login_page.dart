import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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
                    TextField(
                      cursorColor: Color(0xFF8F8F8F),
                      decoration: InputDecoration(
                        label: Text("E-mail"),
                        labelStyle: TextStyle(color: Color(0xFF8F8F8F)),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF8F8F8F)),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF8F8F8F)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF8F8F8F)),
                        ),
                        focusColor: Color(0xFF8F8F8F)
                      ),
                    ),
              
                    const SizedBox(height: 15,),
          
                    const TextField(
                      cursorColor: Color(0xFF8F8F8F),
                      decoration: InputDecoration(
                        label: Text("Senha"),
                        labelStyle: TextStyle(color: Color(0xFF8F8F8F)),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF8F8F8F))
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF8F8F8F)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF8F8F8F)),
                        ),
                        focusColor: Color(0xFF8F8F8F)
                      )
                    ),
                    
                    SizedBox(height: 5,),

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

                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: null,
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all(Theme.of(context).colorScheme.secondary),
                          shape: WidgetStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0), // Define o border radius de 8px
                            ),
                          )
                        ),
                        child: Text(
                          "Entrar",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.surface,
                            fontWeight: FontWeight.bold
                          ),
                        )
                      ),
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
                        Text(
                          "Não possui uma conta? ",
                          style: TextStyle(
                            fontSize: 15
                          ),
                        ),
                        Text(
                          "Crie uma",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.error,
                            fontSize: 15,
                            fontWeight: FontWeight.w600
                          ),
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