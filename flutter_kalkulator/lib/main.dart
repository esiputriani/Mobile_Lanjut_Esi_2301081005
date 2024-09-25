import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  TextEditingController angka1Controller = TextEditingController();
  TextEditingController angka2Controller = TextEditingController();
  String hasil = "";
  String operator = "";

  void _hitung() {
    double num1 = double.parse(angka1Controller.text);
    double num2 = double.parse(angka2Controller.text);
    double result = 0;

    switch (operator) {
      case '+':
        result = num1 + num2;
        break;
      case '-':
        result = num1 - num2;
        break;
      case '*':
        result = num1 * num2;
        break;
      case '/':
        if (num2 != 0) {
          result = num1 / num2;
        } else {
          hasil = "Error: Division by Zero!";
          setState(() {});
          return;
        }
        break;
      default:
        hasil = "Pilih operator terlebih dahulu!";
        setState(() {});
        return;
    }

    setState(() {
      hasil = result.toString();
    });
  }

  void _setOperator(String selectedOperator) {
    setState(() {
      operator = selectedOperator;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kalkulator Sederhana'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: angka1Controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Masukkan Angka 1'),
            ),
            TextField(
              controller: angka2Controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Masukkan Angka 2'),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () => _setOperator('+'),
                  child: Text('+'),
                ),
                ElevatedButton(
                  onPressed: () => _setOperator('-'),
                  child: Text('-'),
                ),
                ElevatedButton(
                  onPressed: () => _setOperator('*'),
                  child: Text('*'),
                ),
                ElevatedButton(
                  onPressed: () => _setOperator('/'),
                  child: Text('/'),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _hitung,
              child: Text('Hasil'),
            ),
            SizedBox(height: 20),
            Text(
              'Hasil: $hasil',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
