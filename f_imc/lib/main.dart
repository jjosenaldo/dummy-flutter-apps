import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController weightController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final String Function(String) notEmptyValidator =
      (enteredText) => enteredText?.isEmpty ?? true
          ? 'Campo obrigatório.'
          : num.tryParse(enteredText) == null
              ? 'Insira um valor válido.'
              : num.parse(enteredText) < 0
                  ? 'O valor deve ser positivo.'
                  : null;
  static final formKey = GlobalKey<FormState>();
  String _imcResult;

  void _clearForm() {
    setState(() {
      _imcResult = '';
      heightController.clear();
      weightController.clear();
    });

    formKey.currentState.reset();
  }

  Widget _padding() => SizedBox(
        height: 10,
      );

  void _onButtonPressed() {
    if (formKey.currentState.validate()) {
      final weight = num.parse(weightController.text);
      final height = num.parse(heightController.text);
      final imc = weight / pow(height * 0.01, 2);
      final interpretation = imc < 17
          ? 'muito abaixo do peso'
          : imc < 18.5
              ? 'abaixo do peso'
              : imc < 25
                  ? 'peso normal'
                  : imc < 30
                      ? 'acima do peso'
                      : imc < 35
                          ? 'obesidade'
                          : imc < 40
                              ? 'obesidade severa'
                              : 'obesidade mórbida';
      setState(() {
        _imcResult = '${imc.toStringAsPrecision(4)} ($interpretation)';
      });
    }
  }

  @override
  void dispose() {
    weightController.dispose();
    heightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora de IMC'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _clearForm,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Icon(Icons.person, size: 100, color: Colors.yellow),
                _padding(),
                TextFormField(
                  controller: weightController,
                  validator: notEmptyValidator,
                  decoration: InputDecoration(
                      hintText: 'Peso (kg)',
                      hintStyle: TextStyle(color: Colors.red)),
                  keyboardType: TextInputType.number,
                ),
                _padding(),
                TextFormField(
                  controller: heightController,
                  validator: notEmptyValidator,
                  decoration: InputDecoration(
                      hintText: 'Altura (cm)',
                      hintStyle: TextStyle(color: Colors.red)),
                  keyboardType: TextInputType.number,
                ),
                _padding(),
                RaisedButton(
                  child: Text('Calcular'),
                  onPressed: _onButtonPressed,
                  color: Colors.red,
                  textColor: Colors.white,
                ),
                Visibility(
                  visible: _imcResult?.isNotEmpty ?? false,
                  child: Center(child: Text(_imcResult ?? '')),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
