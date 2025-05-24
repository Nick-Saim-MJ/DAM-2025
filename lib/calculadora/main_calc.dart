import 'package:flutter/material.dart';
import 'package:flutter_comp/calculadora/CustomAppBar.dart';
import 'dart:math';
import 'package:flutter_comp/calculadora/theme/AppTheme.dart';
import 'package:flutter_comp/calculadora/CalcButton.dart';


void main() => runApp(CalcApp());

class CalcApp extends StatefulWidget {
  const CalcApp({super.key});

  @override
  CalcAppState createState() => CalcAppState();
}

class CalcAppState extends State<CalcApp> {
  String valorAnt = '';
  String operador = '';
  TextEditingController _controller = TextEditingController();

  void numClick(String text) {
    setState(() => _controller.text += text);
    print(_controller.text);
  }

  void clear(String text) {
    setState(() {
      _controller.text = '';
      valorAnt = '';
      operador = '';
    });
  }

  void opeClick(String text) {
    setState(() {
      valorAnt = _controller.text;
      operador = text;
      _controller.text = '';
    });
  }

  void accion() {
    setState(() {
      print("");
    });
  }

  void resultOperacion(String text) {
    setState(() {
      // Added checks for empty values before parsing
      if (valorAnt.isEmpty || _controller.text.isEmpty) {
        _controller.text = "Error"; // Indicate an error for incomplete operation
        valorAnt = '';
        operador = '';
        return;
      }

      double num1 = double.parse(valorAnt);
      double num2 = double.parse(_controller.text);
      double result = 0.0;

      switch (operador) {
        case "/":
          if (num2 != 0) {
            result = num1 / num2;
          } else {
            _controller.text = "Error: Div por 0";
            return;
          }
          break;
        case "*":
          result = num1 * num2;
          break;
        case "+":
          result = num1 + num2;
          break;
        case "-":
          result = num1 - num2;
          break;
        case "%":
          result = num1 % num2;
          break;
      // Other operations for resultOperacion are added here
        case "^": // Handle power to any number (x^y)
          result = pow(num1, num2).toDouble();
          break;
      }
      _controller.text = _formatResult(result);
      valorAnt = '';
      operador = '';
    });
  }

  // --- NEW FUNCTIONS START HERE ---

  void calculateSqrt(String text) {
    setState(() {
      if (_controller.text.isNotEmpty) {
        double number = double.parse(_controller.text);
        if (number >= 0) {
          _controller.text = _formatResult(sqrt(number));
        } else {
          _controller.text = "Error: Raíz Neg";
        }
      }
    });
  }

  void calculatePi(String text) {
    setState(() {
      _controller.text = _formatResult(pi); // `pi` is from dart:math
    });
  }

  void calculatePowerOf2(String text) {
    setState(() {
      if (_controller.text.isNotEmpty) {
        double number = double.parse(_controller.text);
        _controller.text = _formatResult(pow(number, 2).toDouble()); // `pow` from dart:math
      }
    });
  }

  // Helper function to format results (removes .0 if it's an integer)
  String _formatResult(double result) {
    if (result == result.toInt()) {
      return result.toInt().toString();
    }
    return result.toString();
  }

  // --- NEW FUNCTIONS END HERE ---


  @override
  Widget build(BuildContext context) {
    List<List<String>> labelList = [
      ["AC", "C", "%", "/"],
      ["7", "8", "9", "*"],
      ["4", "5", "6", "-"],
      ["1", "2", "3", "+"],
      ["PI", "sqrt", "x^2", "="],
      [".", "0", "00", "^"]
    ];

    List<List<Function>> funx = [
      [clear, clear, opeClick, opeClick],
      [numClick, numClick, numClick, opeClick],
      [numClick, numClick, numClick, opeClick],
      [numClick, numClick, numClick, opeClick],
      [calculatePi, calculateSqrt, calculatePowerOf2, resultOperacion],
      [numClick, numClick, numClick, opeClick]
    ];

    AppTheme.colorX = Colors.blue;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      themeMode: AppTheme.useLightMode ? ThemeMode.light : ThemeMode.dark,
      theme: AppTheme.themeData,
      home: Scaffold(
        appBar: CustomAppBar(accionx: accion), // Removed 'as Function' because it's unnecessary
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20), // Added const
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Card(
                margin: const EdgeInsets.fromLTRB(20, 0, 20, 0), // Added const
                child: TextField(
                  textAlign: TextAlign.end,
                  controller: _controller,
                  readOnly: true, // Typically for calculator display
                  style: const TextStyle(fontSize: 40), // Make text larger for display
                  keyboardType: TextInputType.none, // Hide keyboard
                ),
              ),
              const SizedBox(height: 20), // Added const
              ...List.generate(
                labelList.length,
                    (index) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ...List.generate(
                      labelList[index].length,
                          (indexx) => CalcButton(
                        text: labelList[index][indexx],
                        callback: funx[index][indexx], // No need for 'as Function'
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}