import 'package:flutter/material.dart';

void main() {
  runApp(const AvaliacaoIMC());
}

class AvaliacaoIMC extends StatelessWidget {
  const AvaliacaoIMC({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora de IMC',
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: const TelaIMC(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class TelaIMC extends StatefulWidget {
  const TelaIMC({super.key});

  @override
  State<TelaIMC> createState() => _TelaIMCState();
}

class _TelaIMCState extends State<TelaIMC> {
  final TextEditingController pesoController = TextEditingController();
  final TextEditingController alturaController = TextEditingController();

  void calcularIMC() {
    final double? peso = double.tryParse(pesoController.text);
    final double? altura = double.tryParse(alturaController.text);

    if (peso == null || altura == null || altura == 0) {
      _mostrarDialogo("Erro", "Por favor, insira valores válidos.");
      return;
    }

    final imc = peso / (altura * altura);
    String classificacao;

    if (imc < 18.5) {
      classificacao = "Abaixo do peso";
    } else if (imc < 25) {
      classificacao = "Peso normal";
    } else if (imc < 30) {
      classificacao = "Sobrepeso";
    } else if (imc < 35) {
      classificacao = "Obesidade Grau I";
    } else if (imc < 40) {
      classificacao = "Obesidade Grau II";
    } else {
      classificacao = "Obesidade Grau III";
    }

    _mostrarDialogo("Resultado do IMC", "Seu IMC é ${imc.toStringAsFixed(2)}\n$classificacao");
  }

  void _mostrarDialogo(String titulo, String mensagem) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(titulo),
          content: Text(mensagem),
          actions: [
            TextButton(
              child: const Text("OK"),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tela de Login"),
        backgroundColor: Colors.brown,
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.topRight,
              child: Text(
                "DEMO",
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
          )
        ],
      ),
      backgroundColor: const Color(0xFFF9F0FF),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(height: 30),
            const Text("Peso:", style: TextStyle(fontSize: 18, color: Colors.blueGrey)),
            TextField(
              controller: pesoController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Digite seu peso"),
            ),
            const SizedBox(height: 30),
            const Text("Altura:", style: TextStyle(fontSize: 18, color: Colors.blueGrey)),
            TextField(
              controller: alturaController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Digite sua altura", suffixText: "m"),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: calcularIMC,
              child: const Text("Calcular"),
            ),
          ],
        ),
      ),
    );
  }
}
