import 'package:flutter/material.dart';
import 'package:projeto_integrador/components/custom_app_bar.dart';
import 'package:projeto_integrador/components/custom_textfield.dart';
import 'package:projeto_integrador/models/emprestante.dart';
import 'package:projeto_integrador/services/emprestante_service.dart';

class EmprestanteEditPage extends StatefulWidget {
  final Emprestante emprestante;

  const EmprestanteEditPage({super.key, required this.emprestante});

  @override
  EmprestanteEditPageState createState() => EmprestanteEditPageState();
}

class EmprestanteEditPageState extends State<EmprestanteEditPage> {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController numIdentificacaoController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    nomeController.text = widget.emprestante.nome;
    numIdentificacaoController.text = widget.emprestante.num_identificacao;
  }

  Future<void> _editEmprestante() async {
    if (nomeController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, insira um nome.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (numIdentificacaoController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, insira um número de identificação.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final updatedEmprestante = Emprestante(
      id_emprestante: widget.emprestante.id_emprestante,
      nome: nomeController.text,
      num_identificacao: numIdentificacaoController.text,
    );

    try {
      await EmprestanteService.updateEmprestante(updatedEmprestante);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Emprestante atualizado com sucesso!'),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pop(context, true);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Falha ao atualizar emprestante: $e'),
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
                    "Editar Emprestante",
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
              Form(
                key: _formKey,
                child: Column(
                  children: [
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
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.bottomRight,
                child: FloatingActionButton(
                  onPressed: _editEmprestante,
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
