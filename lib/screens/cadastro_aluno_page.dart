import 'dart:convert';

import 'package:flutter/material.dart';

import '../components/menu_drawer.dart';

// Cadastro de aluno
// É praticamente o mesmo padrão do formulario_page.dart da aula,
// só acrescentando o campo "Curso".
class CadastroAlunoPage extends StatefulWidget {
  const CadastroAlunoPage({
    super.key,
    required this.modoEscuro,
    required this.aoAlterarTema,
  });

  final bool modoEscuro;
  final ValueChanged<bool> aoAlterarTema;

  @override
  State<CadastroAlunoPage> createState() => _CadastroAlunoPageState();
}

class _CadastroAlunoPageState extends State<CadastroAlunoPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _idadeController = TextEditingController();
  final TextEditingController _cursoController = TextEditingController();

  String _jsonOutput = '';

  void _salvar() {
    if (_formKey.currentState?.validate() ?? false) {
      final Map<String, dynamic> dados = {
        'nome': _nomeController.text,
        'email': _emailController.text,
        'idade': _idadeController.text,
        'curso': _cursoController.text,
      };
      setState(() {
        _jsonOutput = const JsonEncoder.withIndent('  ').convert(dados);
      });
    }
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _emailController.dispose();
    _idadeController.dispose();
    _cursoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text('Cadastro de Aluno'),
      ),
      drawer: MenuDrawer(
        modoEscuro: widget.modoEscuro,
        aoAlterarTema: widget.aoAlterarTema,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nomeController,
                decoration: const InputDecoration(labelText: 'Nome'),
                validator: (value) =>
                (value == null || value.isEmpty) ? 'Informe o nome' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'E-mail'),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Informe o e-mail';
                  if (!value.contains('@')) return 'E-mail inválido';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _idadeController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Idade'),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Informe a idade';
                  if (int.tryParse(value) == null) return 'Idade inválida';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _cursoController,
                decoration: const InputDecoration(labelText: 'Curso'),
                validator: (value) =>
                (value == null || value.isEmpty) ? 'Informe o curso' : null,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: _salvar,
                  child: const Text('Salvar'),
                ),
              ),
              const SizedBox(height: 20),
              if (_jsonOutput.isNotEmpty)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    _jsonOutput,
                    style: const TextStyle(fontFamily: 'monospace'),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
