import 'package:flutter/material.dart';

import '../components/menu_drawer.dart';
import 'calculadora_page.dart';
import 'cursos_page.dart';

// Tela inicial (item 2 do enunciado):
// mensagem de boas-vindas, identificação visual, drawer e 2+ cards.
class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
    required this.modoEscuro,
    required this.aoAlterarTema,
  });

  final bool modoEscuro;
  final ValueChanged<bool> aoAlterarTema;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text('Student Hub'),
      ),
      drawer: MenuDrawer(modoEscuro: modoEscuro, aoAlterarTema: aoAlterarTema),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Bem-vindo(a) de volta!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'O que você quer fazer hoje?',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                children: [
                  _buildCard(
                    context,
                    icone: Icons.calculate,
                    titulo: 'Calculadora',
                    cor: Colors.deepPurple,
                    destino: CalculadoraPage(
                      modoEscuro: modoEscuro,
                      aoAlterarTema: aoAlterarTema,
                    ),
                  ),
                  _buildCard(
                    context,
                    icone: Icons.grid_view,
                    titulo: 'Cursos',
                    cor: Colors.teal,
                    destino: CursosPage(
                      modoEscuro: modoEscuro,
                      aoAlterarTema: aoAlterarTema,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(
      BuildContext context, {
        required IconData icone,
        required String titulo,
        required Color cor,
        required Widget destino,
      }) {
    return Card(
      elevation: 3,
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destino),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icone, size: 40, color: cor),
              const SizedBox(height: 12),
              Text(titulo, style: const TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }
}
