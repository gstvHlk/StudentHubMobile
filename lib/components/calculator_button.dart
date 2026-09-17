import 'package:flutter/material.dart';

// Componente reutilizável exigido pela atividade (item 4).
// Evita repetir o mesmo ElevatedButton.styleFrom em cada botão da calculadora.
class CalculatorButton extends StatelessWidget {
  const CalculatorButton({
    super.key,
    required this.texto,
    required this.onPressed,
    this.cor,
    this.corTexto,
  });

  final String texto;
  final VoidCallback onPressed;
  final Color? cor;
  final Color? corTexto;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: cor ?? Colors.grey[200],
        foregroundColor: corTexto ?? Colors.black,
        side: const BorderSide(color: Colors.black12, width: 1),
        textStyle: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        padding: const EdgeInsets.all(18),
      ),
      onPressed: onPressed,
      child: Text(texto),
    );
  }
}
