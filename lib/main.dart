import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: Calculator(),
  ));
}

class Calculator extends StatelessWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text("Calculator"),
      ),
      body: Calc(),
    );
  }
}

class Calc extends StatefulWidget {
  const Calc({Key? key}) : super(key: key);

  @override
  State<Calc> createState() => _CalcState();
}

class _CalcState extends State<Calc> {
  String output = "0";
  String result = "0";
  String operations = "";
  double num1 = 0.0;
  double num2 = 0.0;
  void buttonpressed(String buttontext) {
    if (buttontext == "C") {
      output = "0";
      result = "0";
      num1 = 0;
      num2 = 0;
    } else if (buttontext == "+" ||
        buttontext == "-" ||
        buttontext == "*" ||
        buttontext == "/") {
      num1 = double.tryParse(output) ?? 0.0;
      operations = buttontext;
      output = "0";
    } else if (buttontext == "=") {
      num2 = double.tryParse(output) ?? 0.0;
      switch (operations) {
        case '+':
          result = (num1 + num2).toString();
          break;
        case '-':
          result = (num1 - num2).toString();
          break;
        case '*':
          result = (num1 * num2).toString();
          break;
        case '/':
          result = (num1 / num2).toString();
          break;
      }
      output = result;
      operations = "";
      num1 = 0;
      num2 = 0;
    } else if (output == "0" && buttontext != ".") {
      output = buttontext;
    } else {
      output += buttontext;
    }

    setState(() {
      output = output;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 20,
            ),
            child: Text(output),
          ),
          const Expanded(
            child: Divider(),
          ),
          ...createbuttons(),
        ],
      ),
    );
  }

  List<Widget> createbuttons() {
    List<List<String>> buttons = [
      ["7", "8", "9", "/"],
      ["4", "5", "6", "*"],
      ["1", "2", "3", "-"],
      ["C", "=", "+"],
    ];
    return buttons.map((List<String> row) {
      return Row(
        children: row.map((String buttontext) {
          return buildbutton(buttontext);
        }).toList(),
      );
    }).toList();
  }

  Widget buildbutton(String buttontext) {
    return Expanded(
      child: OutlinedButton(
        onPressed: () => buttonpressed(buttontext),
        child: Text(
          buttontext,
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
