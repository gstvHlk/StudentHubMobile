import 'package:flutter/material.dart';

import '../screens/home_page.dart';
import '../screens/calculadora_page.dart';
import '../screens/cadastro_aluno_page.dart';
import '../screens/cursos_page.dart';
import '../screens/login_page.dart';

// Diferente do MenuDrawer da aula (que não navegava de verdade),
// este usa Navigator.pushReplacement para trocar de tela e
// Navigator.pushAndRemoveUntil no "Sair" para voltar ao Login
// limpando o histórico de navegação (item 8 do enunciado).
class MenuDrawer extends StatelessWidget {
  const MenuDrawer({
    super.key,
    required this.modoEscuro,
    required this.aoAlterarTema,
  });

  final bool modoEscuro;
  final ValueChanged<bool> aoAlterarTema;

  void _navegar(BuildContext context, Widget tela) {
    Navigator.pop(context); // fecha o drawer antes de navegar
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => tela),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.deepPurple),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(Icons.school, color: Colors.white, size: 40),
                SizedBox(height: 8),
                Text(
                  'Student Hub',
                  style: TextStyle(color: Colors.white, fontSize: 22),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Início'),
            onTap: () => _navegar(
              context,
              HomePage(modoEscuro: modoEscuro, aoAlterarTema: aoAlterarTema),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.calculate),
            title: const Text('Calculadora'),
            onTap: () => _navegar(
              context,
              CalculadoraPage(
                modoEscuro: modoEscuro,
                aoAlterarTema: aoAlterarTema,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person_add),
            title: const Text('Cadastrar Aluno'),
            onTap: () => _navegar(
              context,
              CadastroAlunoPage(
                modoEscuro: modoEscuro,
                aoAlterarTema: aoAlterarTema,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.grid_view),
            title: const Text('Cursos'),
            onTap: () => _navegar(
              context,
              CursosPage(modoEscuro: modoEscuro, aoAlterarTema: aoAlterarTema),
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Sair'),
            onTap: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
                    (route) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}
