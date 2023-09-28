import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'pessoa.dart';
import 'calculadora_imc.dart';

void main() {
  runApp(const CalculadoraIMCApp());
}
class CalculadoraIMCApp extends StatefulWidget {
  const CalculadoraIMCApp({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CalculadoraIMCAppState createState() => _CalculadoraIMCAppState();
}

class _CalculadoraIMCAppState extends State<CalculadoraIMCApp> {
  TextEditingController nomeController = TextEditingController();
  TextEditingController pesoController = TextEditingController();
  TextEditingController alturaController = TextEditingController();
  String resultado = '';
  List<Pessoa> listaDePessoas = [];

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Calculadora de IMC'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  controller: nomeController,
                  decoration: const InputDecoration(labelText: 'Nome'),
                  onFieldSubmitted: (_) => _calcularIMC(),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor, insira um nome';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: pesoController,
                  decoration: const InputDecoration(labelText: 'Peso (kg)'),
                  keyboardType: TextInputType.number,
                  onFieldSubmitted: (_) => _calcularIMC(),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor, insira o peso';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: alturaController,
                  decoration: const InputDecoration(labelText: 'Altura (cm)'),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  onFieldSubmitted: (_) => _calcularIMC(),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor, insira a altura';
                    }
                    return null;
                  },
                ),
                ElevatedButton(
                  onPressed: _calcularIMC,
                  child: const Text('Calcular'),
                ),
                const SizedBox(height: 20),
                Text(
                  resultado,
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    itemCount: listaDePessoas.length,
                    itemBuilder: (context, index) {
                      Pessoa pessoa = listaDePessoas[index];
                      double imc = pessoa.peso / (pessoa.altura * pessoa.altura);
                      String classificacao = CalculadoraIMC(pessoa).classificar();
                      return ListTile(
                        title: Text('${pessoa.nome}: $imc'),
                        subtitle: Text(classificacao),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _calcularIMC() {
    if (_formKey.currentState!.validate()) {
      String nome = nomeController.text;
      double peso = double.parse(pesoController.text);
      double alturaEmCM = double.parse(alturaController.text);
      double alturaEmMetros = alturaEmCM / 100.0;

      CalculadoraIMC calculadora = CalculadoraIMC(Pessoa(nome, peso, alturaEmMetros));
      double imc = calculadora.calcular();
      imc = double.parse(imc.toStringAsFixed(1));
      String classificacao = calculadora.classificar();
      setState(() {
        resultado = '$nome, seu IMC é $imc e você está classificado como $classificacao';
        listaDePessoas.insert(0, Pessoa(nome, peso, alturaEmMetros));
        nomeController.clear();
        pesoController.clear();
        alturaController.clear();
      });
    }
  }
}
