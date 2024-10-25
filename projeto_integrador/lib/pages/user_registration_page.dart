import 'package:flutter/material.dart';
import 'package:projeto_integrador/components/custom_app_bar.dart';
import 'package:projeto_integrador/components/custom_textfield.dart';
import 'package:projeto_integrador/components/custom_select_field.dart';
import 'package:projeto_integrador/models/user.dart';
import 'package:projeto_integrador/services/user_service.dart';

class UserRegistrationPage extends StatefulWidget {
  const UserRegistrationPage({super.key});

  @override
  State<UserRegistrationPage> createState() => _UserRegistrationPageState();
}

class _UserRegistrationPageState extends State<UserRegistrationPage> {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController sobrenomeController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();
  final TextEditingController confirmarSenhaController =
      TextEditingController();

  String? selectedTipoUsuario;

  final List<DropdownMenuItem<String>> tiposUsuario = const [
    DropdownMenuItem(value: 'Administrador', child: Text('Administrador')),
    DropdownMenuItem(value: 'Colaborador', child: Text('Colaborador')),
    DropdownMenuItem(value: 'Aluno', child: Text('Aluno')),
  ];

  bool _isEmailValid(String email) {
    final emailRegEx = RegExp(
      r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
    );
    return emailRegEx.hasMatch(email);
  }

  void _cadastrarUsuario() async {
    if (nomeController.text.isEmpty ||
        sobrenomeController.text.isEmpty ||
        emailController.text.isEmpty ||
        senhaController.text.isEmpty ||
        confirmarSenhaController.text.isEmpty ||
        selectedTipoUsuario == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, preencha todos os campos!'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (!_isEmailValid(emailController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, insira um email válido!'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (senhaController.text != confirmarSenhaController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('As senhas não coincidem!'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    User newUser = User(
      id: null,
      nome: nomeController.text,
      sobrenome: sobrenomeController.text,
      email: emailController.text,
      senha: senhaController.text,
      tipo_usuario: selectedTipoUsuario!,
    );

    bool success = await UserService.registerUser(newUser);

    if (success) {
      Navigator.pop(context, true);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Erro ao cadastrar usuário!'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 40),
                child: Center(
                  child: Text(
                    "Cadastro de Usuário",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 36,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const Divider(
                thickness: 1,
                color: Color(0xFFCAC4D0),
              ),
              const SizedBox(height: 16),
              CustomTextfield(
                controller: nomeController,
                label: 'Nome',
                obscureText: false,
              ),
              const SizedBox(height: 16),
              CustomTextfield(
                controller: sobrenomeController,
                label: 'Sobrenome',
                obscureText: false,
              ),
              const SizedBox(height: 16),
              CustomTextfield(
                controller: emailController,
                label: 'Email',
                obscureText: false,
              ),
              const SizedBox(height: 16),
              CustomTextfield(
                controller: senhaController,
                label: 'Senha',
                obscureText: true,
              ),
              const SizedBox(height: 16),
              CustomTextfield(
                controller: confirmarSenhaController,
                label: 'Confirmar Senha',
                obscureText: true,
              ),
              const SizedBox(height: 16),
              CustomSelectField(
                label: 'Tipo de Usuário',
                items: tiposUsuario,
                selectedValue: selectedTipoUsuario,
                onChanged: (value) {
                  setState(() {
                    selectedTipoUsuario = value;
                  });
                },
              ),
              const SizedBox(height: 32),
              Align(
                alignment: Alignment.bottomRight,
                child: FloatingActionButton(
                  onPressed: _cadastrarUsuario,
                  backgroundColor: Colors.green,
                  child: const Icon(Icons.check),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
