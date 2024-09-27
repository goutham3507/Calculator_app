import 'package:flutter/material.dart';

void main() => runApp(CalculatorApp());

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.green,
        hintColor: Colors.grey,
        scaffoldBackgroundColor: const Color.fromARGB(255, 171, 165, 165),
        textTheme: TextTheme(
          bodyMedium: TextStyle(color: const Color.fromARGB(255, 189, 0, 0)),
        ),
      ),
      home: CalculatorHome(),
    );
  }
}

class CalculatorHome extends StatefulWidget {
  @override
  _CalculatorHomeState createState() => _CalculatorHomeState();
}

class _CalculatorHomeState extends State<CalculatorHome> {
  String _output = "0";
  String _operand = "";
  double _num1 = 0;
  double _num2 = 0;

  void _buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "CLEAR") {
        _output = "0";
        _operand = "";
        _num1 = 0;
        _num2 = 0;
      } else if (buttonText == "+" ||
          buttonText == "-" ||
          buttonText == "*" ||
          buttonText == "/") {
        _num1 = double.parse(_output);
        _operand = buttonText;
        _output = "0";
      } else if (buttonText == ".") {
        if (!_output.contains(".")) {
          _output = _output + buttonText;
        }
      } else if (buttonText == "=") {
        _num2 = double.parse(_output);

        if (_operand == "+") {
          _output = (_num1 + _num2).toString();
        } else if (_operand == "-") {
          _output = (_num1 - _num2).toString();
        } else if (_operand == "*") {
          _output = (_num1 * _num2).toString();
        } else if (_operand == "/") {
          _output = _num2 != 0 ? (_num1 / _num2).toString() : "Error";
        }

        _operand = "";
      } else {
        if (_output == "0") {
          _output = buttonText;
        } else {
          _output = _output + buttonText;
        }
      }
    });
  }

 Widget _buildButton(String buttonText) {
  return Expanded(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white, backgroundColor: buttonText == "CLEAR"
              ? Colors.redAccent
              : Theme.of(context).colorScheme.secondary, // Text color set to white
          padding: EdgeInsets.all(20.0),
        ),
        child: Text(
          buttonText,
          style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
        ),
        onPressed: () => _buttonPressed(buttonText),
      ),
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculator"),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
              child: Text(
                _output,
                style: const TextStyle(
                  fontSize: 48.0,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 12, 1, 1),
                ),
              ),
            ),
          ),
          Column(
            children: [
              Row(
                children: <Widget>[
                  _buildButton("7"),
                  _buildButton("8"),
                  _buildButton("9"),
                  _buildButton("/"),
                ],
              ),
              Row(
                children: <Widget>[
                  _buildButton("4"),
                  _buildButton("5"),
                  _buildButton("6"),
                  _buildButton("*"),
                ],
              ),
              Row(
                children: <Widget>[
                  _buildButton("1"),
                  _buildButton("2"),
                  _buildButton("3"),
                  _buildButton("-"),
                ],
              ),
              Row(
                children: <Widget>[
                  _buildButton("."),
                  _buildButton("0"),
                  _buildButton("00"),
                  _buildButton("+"),
                ],
              ),
              Row(
                children: <Widget>[
                  _buildButton("CLEAR"),
                  _buildButton("="),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
