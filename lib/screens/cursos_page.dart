import 'package:flutter/material.dart';

import '../components/menu_drawer.dart';

// Tela de cursos (itens 6 e 7 do enunciado).
// Estrutura idêntica ao galeria_page.dart da aula: GridView.builder +
// Card + showModalBottomSheet. Troquei "lugares" por "cursos" e
// acrescentei o campo "duracao".
class CursosPage extends StatefulWidget {
  const CursosPage({
    super.key,
    required this.modoEscuro,
    required this.aoAlterarTema,
  });

  final bool modoEscuro;
  final ValueChanged<bool> aoAlterarTema;

  @override
  State<CursosPage> createState() => _CursosPageState();
}

class _CursosPageState extends State<CursosPage> {
  // Troque os caminhos das imagens pelos arquivos que você colocar
  // em assets/images/ (lembre de declarar no pubspec.yaml).
  final List<Map<String, String>> _cursos = [
    {
      'nome': 'Análise e Desenvolvimento de Sistemas',
      'imagem': 'assets/images/imagesads.jpg',
      'descricao':
      'Formação voltada para desenvolvimento de software, banco de dados e arquitetura de sistemas.',
      'duracao': '2 anos e meio',
    },
    {
      'nome': 'Engenharia de Software',
      'imagem': 'assets/images/engenhariadesoftware.png',
      'descricao':
      'Curso focado em processos de desenvolvimento, qualidade e gestão de projetos de software.',
      'duracao': '4 anos',
    },
    {
      'nome': 'Ciência da Computação',
      'imagem': 'assets/images/cc.png',
      'descricao':
      'Base teórica sólida em algoritmos, estruturas de dados e fundamentos da computação.',
      'duracao': '4 anos',
    },
    {
      'nome': 'Redes de Computadores',
      'imagem': 'assets/images/redes.png',
      'descricao':
      'Curso voltado para infraestrutura, segurança e administração de redes.',
      'duracao': '2 anos',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text('Cursos'),
      ),
      drawer: MenuDrawer(
        modoEscuro: widget.modoEscuro,
        aoAlterarTema: widget.aoAlterarTema,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          itemCount: _cursos.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 0.8,
          ),
          itemBuilder: (context, index) => _buildCardCurso(_cursos[index]),
        ),
      ),
    );
  }

  Widget _buildCardCurso(Map<String, String> curso) {
    return InkWell(
      onTap: () => _abrirDetalhesDoCurso(curso),
      child: Card(
        elevation: 3,
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Image.asset(
                curso['imagem'] ?? '',
                fit: BoxFit.cover,
                // errorBuilder evita que o app quebre enquanto as
                // imagens reais ainda não foram adicionadas em assets/.
                errorBuilder: (context, error, stackTrace) => Container(
                  color: Colors.deepPurple[50],
                  child: const Icon(
                    Icons.school,
                    size: 40,
                    color: Colors.deepPurple,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                curso['nome'] ?? '',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _abrirDetalhesDoCurso(Map<String, String> curso) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: SizedBox(
                  height: 180,
                  width: double.infinity,
                  child: Image.asset(
                    curso['imagem'] ?? '',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: Colors.deepPurple[50],
                      child: const Icon(
                        Icons.school,
                        size: 60,
                        color: Colors.deepPurple,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                curso['nome'] ?? '',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.timer, size: 16),
                  const SizedBox(width: 6),
                  Text(curso['duracao'] ?? ''),
                ],
              ),
              const SizedBox(height: 12),
              Text(curso['descricao'] ?? ''),
            ],
          ),
        );
      },
    );
  }
}