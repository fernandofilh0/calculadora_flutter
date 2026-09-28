import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculadora',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CalculadoraPage(),
    );
  }
}

class CalculadoraPage extends StatefulWidget {
  const CalculadoraPage({super.key});

  @override
  State<CalculadoraPage> createState() => _CalculadoraPageState();
}

class _CalculadoraPageState extends State<CalculadoraPage> {
  final TextEditingController numero1Controller = TextEditingController();
  final TextEditingController numero2Controller = TextEditingController();

  String resultado = '0';

  void calcular(String operacao) {
    double? numero1 = double.tryParse(numero1Controller.text);
    double? numero2 = double.tryParse(numero2Controller.text);

    if (numero1 == null || numero2 == null) {
      setState(() {
        resultado = 'Digite dois números válidos';
      });
      return;
    }

    double valorResultado;

    switch (operacao) {
      case '+':
        valorResultado = numero1 + numero2;
        break;

      case '-':
        valorResultado = numero1 - numero2;
        break;

      case '×':
        valorResultado = numero1 * numero2;
        break;

      case '÷':
        if (numero2 == 0) {
          setState(() {
            resultado = 'Não é possível dividir por zero';
          });
          return;
        }
        valorResultado = numero1 / numero2;
        break;

      default:
        return;
    }

    setState(() {
      resultado = valorResultado.toString();
    });
  }

  void limpar() {
    numero1Controller.clear();
    numero2Controller.clear();

    setState(() {
      resultado = '0';
    });
  }

  @override
  void dispose() {
    numero1Controller.dispose();
    numero2Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora'),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            const Text(
              'Calculadora',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 30),

            TextField(
              controller: numero1Controller,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(
                labelText: 'Primeiro número',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: numero2Controller,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(
                labelText: 'Segundo número',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 25),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [

                ElevatedButton(
                  onPressed: () {
                    calcular('+');
                  },
                  child: const Text(
                    '+',
                    style: TextStyle(fontSize: 24),
                  ),
                ),

                ElevatedButton(
                  onPressed: () {
                    calcular('-');
                  },
                  child: const Text(
                    '-',
                    style: TextStyle(fontSize: 24),
                  ),
                ),

                ElevatedButton(
                  onPressed: () {
                    calcular('×');
                  },
                  child: const Text(
                    '×',
                    style: TextStyle(fontSize: 24),
                  ),
                ),

                ElevatedButton(
                  onPressed: () {
                    calcular('÷');
                  },
                  child: const Text(
                    '÷',
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            const Text(
              'Resultado:',
              style: TextStyle(
                fontSize: 20,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              resultado,
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 25),

            ElevatedButton(
              onPressed: limpar,
              child: const Text('Limpar'),
            ),
          ],
        ),
      ),
    );
  }
}