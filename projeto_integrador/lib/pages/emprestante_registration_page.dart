import 'package:flutter/material.dart';
import 'package:projeto_integrador/components/custom_app_bar.dart';
import 'package:projeto_integrador/components/custom_textfield.dart';
import 'package:projeto_integrador/models/emprestante.dart';
import 'package:projeto_integrador/services/emprestante_service.dart';

class EmprestanteRegistrationPage extends StatefulWidget {
  const EmprestanteRegistrationPage({super.key});

  @override
  State<EmprestanteRegistrationPage> createState() =>
      _EmprestanteRegistrationPageState();
}

class _EmprestanteRegistrationPageState
    extends State<EmprestanteRegistrationPage> {
  final TextEditingController numIdentificacaoController =
      TextEditingController();
  final TextEditingController nomeController = TextEditingController();

  Future<void> cadastrarEmprestante() async {
    try {
      Emprestante emprestante = Emprestante(
        id_emprestante: 0,
        num_identificacao: numIdentificacaoController.text,
        nome: nomeController.text,
        status_emprestante: 'Ativo',
      );

      await EmprestanteService.createEmprestante(emprestante.toJson());

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Emprestante cadastrado com sucesso!'),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pop(context, true);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erro ao cadastrar o emprestante')),
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
                    "Novo Emprestante",
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
                controller: numIdentificacaoController,
                label: 'Número de Identificação',
                obscureText: false,
              ),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.bottomRight,
                child: FloatingActionButton(
                  onPressed: () {
                    cadastrarEmprestante();
                  },
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
