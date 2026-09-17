import 'package:flutter/material.dart';

import '../components/calculator_button.dart';
import '../components/menu_drawer.dart';

// Calculadora (itens 3 e 4 do enunciado).
// Usa um visor único (como calculadora de verdade) em vez dos dois
// contadores separados do myhomepage.dart da aula.
class CalculadoraPage extends StatefulWidget {
  const CalculadoraPage({
    super.key,
    required this.modoEscuro,
    required this.aoAlterarTema,
  });

  final bool modoEscuro;
  final ValueChanged<bool> aoAlterarTema;

  @override
  State<CalculadoraPage> createState() => _CalculadoraPageState();
}

class _CalculadoraPageState extends State<CalculadoraPage> {
  String _visor = '0';
  double? _valorAnterior;
  String? _operador;
  bool _limparAoDigitar = false;

  void _digitarNumero(String numero) {
    setState(() {
      if (_visor == '0' || _limparAoDigitar) {
        _visor = numero;
        _limparAoDigitar = false;
      } else {
        _visor += numero;
      }
    });
  }

  void _selecionarOperador(String operador) {
    setState(() {
      _valorAnterior = double.tryParse(_visor);
      _operador = operador;
      _limparAoDigitar = true;
    });
  }

  void _calcularResultado() {
    if (_valorAnterior == null || _operador == null) return;

    final double atual = double.tryParse(_visor) ?? 0;
    double resultado = 0;

    switch (_operador) {
      case '+':
        resultado = _valorAnterior! + atual;
        break;
      case '-':
        resultado = _valorAnterior! - atual;
        break;
      case '×':
        resultado = _valorAnterior! * atual;
        break;
      case '÷':
      // Tratamento de divisão por zero exigido no item 3 --
      // mostra uma mensagem no visor em vez de travar o app.
        if (atual == 0) {
          setState(() {
            _visor = 'Não é possível dividir por zero';
            _valorAnterior = null;
            _operador = null;
            _limparAoDigitar = true;
          });
          return;
        }
        resultado = _valorAnterior! / atual;
        break;
    }

    setState(() {
      _visor = _formatarResultado(resultado);
      _valorAnterior = null;
      _operador = null;
      _limparAoDigitar = true;
    });
  }

  String _formatarResultado(double valor) {
    if (valor == valor.roundToDouble()) {
      return valor.toInt().toString();
    }
    return valor.toString();
  }

  void _limpar() {
    setState(() {
      _visor = '0';
      _valorAnterior = null;
      _operador = null;
      _limparAoDigitar = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text('Calculadora'),
      ),
      drawer: MenuDrawer(
        modoEscuro: widget.modoEscuro,
        aoAlterarTema: widget.aoAlterarTema,
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            alignment: Alignment.centerRight,
            child: Text(
              _visor,
              style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
              textAlign: TextAlign.right,
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  _buildLinha(['7', '8', '9', '÷']),
                  _buildLinha(['4', '5', '6', '×']),
                  _buildLinha(['1', '2', '3', '-']),
                  _buildLinha(['C', '0', '=', '+']),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLinha(List<String> botoes) {
    return Expanded(
      child: Row(children: botoes.map(_buildBotao).toList()),
    );
  }

  Widget _buildBotao(String texto) {
    final bool ehOperador = ['÷', '×', '-', '+', '='].contains(texto);
    final bool ehLimpar = texto == 'C';

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4),
        // Aqui é onde o componente reutilizável (item 4) entra em ação:
        // o mesmo CalculatorButton serve pra número, operador e limpar,
        // só mudando a cor conforme o tipo de botão.
        child: CalculatorButton(
          texto: texto,
          cor: ehLimpar
              ? Colors.red[100]
              : ehOperador
              ? Colors.deepPurple[100]
              : Colors.grey[200],
          onPressed: () {
            if (ehLimpar) {
              _limpar();
            } else if (texto == '=') {
              _calcularResultado();
            } else if (ehOperador) {
              _selecionarOperador(texto);
            } else {
              _digitarNumero(texto);
            }
          },
        ),
      ),
    );
  }
}
