import 'package:flutter/material.dart';
import 'pessoa.dart';
import 'calculadora_imc.dart';

void main() {
  runApp(CalculadoraIMCApp());
}

class CalculadoraIMCApp extends StatefulWidget {
  @override
  _CalculadoraIMCAppState createState() => _CalculadoraIMCAppState();
}

class _CalculadoraIMCAppState extends State<CalculadoraIMCApp> {
  TextEditingController nomeController = TextEditingController();
  TextEditingController pesoController = TextEditingController();
  TextEditingController alturaController = TextEditingController();
  String resultado = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Calculadora de IMC'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: nomeController,
                decoration: InputDecoration(labelText: 'Nome'),
              ),
              TextField(
                controller: pesoController,
                decoration: InputDecoration(labelText: 'Peso (kg)'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: alturaController,
                decoration: InputDecoration(labelText: 'Altura (m)'),
                keyboardType: TextInputType.number,
              ),
              ElevatedButton(
                onPressed: () {
                  String nome = nomeController.text;
                  double peso = double.parse(pesoController.text);
                  double altura = double.parse(alturaController.text);

                  Pessoa pessoa = Pessoa(nome, peso, altura);
                  CalculadoraIMC calculadora = CalculadoraIMC(pessoa);

                  double imc = calculadora.calcular();
                  String classificacao = calculadora.classificar();

                  setState(() {
                    resultado =
                        '$nome, seu IMC é $imc e você está classificado como $classificacao';
                  });
                },
                child: Text('Calcular'),
              ),
              SizedBox(height: 20),
              Text(
                resultado,
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
