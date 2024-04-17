// ignore_for_file: camel_case_types, prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_this, use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String output = "0";

  String _output = "0";
  double num1 = 0.0;
  double num2 = 0.0;
  String operand = "";

  buttonPressed(String buttonText) {
    if (buttonText == "CLEAR") {
      _output = "0";
      num1 = 0.0;
      num2 = 0.0;
      operand = "";
    } else if (buttonText == "+" ||
        buttonText == "-" ||
        buttonText == "/" ||
        buttonText == "X") {
      num1 = double.parse(output);

      operand = buttonText;

      _output = "0";
    } else if (buttonText == ".") {
      if (_output.contains(".")) {
        print("ERROR: '.' already exists");
        return;
      } else {
        _output = _output + buttonText;
      }
    } else if (buttonText == "=") {
      num2 = double.parse(output);

      if (operand == "+") {
        _output = (num1 + num2).toString();
      }
      if (operand == "-") {
        _output = (num1 - num2).toString();
      }
      if (operand == "X") {
        _output = (num1 * num2).toString();
      }
      if (operand == "/") {
        _output = (num1 / num2).toString();
      }

      num1 = 0.0;
      num2 = 0.0;
      operand = "";
    } else {
      _output = _output + buttonText;
    }

    print(_output);

    setState(() {
      output = double.parse(_output).toStringAsFixed(2);
    });
  }

  Widget buildButton(String buttonText) {
    return Expanded(
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.orange),
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(24.0)),
          overlayColor: MaterialStateProperty.all<Color>(Colors.blue),
        ),
        child: Text(
          buttonText,
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        onPressed: () => buttonPressed(buttonText),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor:
            Color.fromARGB(255, 61, 156, 7), // Changed AppBar color
      ),
      body: Padding(
        // Changed Container to Padding
        padding: EdgeInsets.all(10.0), // Added padding to the whole body
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Changed alignment
          children: <Widget>[
            Expanded(
              child: Text(
                output,
                textAlign: TextAlign.right, // Changed alignment
                style: TextStyle(
                  fontSize: 48.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey, // Changed text color
                ),
              ),
            ),
            Divider(),
            Column(
              children: [
                buildButtonRow(["7", "8", "9", "/"]),
                buildButtonRow(["4", "5", "6", "X"]),
                buildButtonRow(["1", "2", "3", "-"]),
                buildButtonRow([".", "0", "00", "+"]),
                buildButtonRow(["CLEAR", "="]),
              ],
            ),
          ],
        ),
      ),
    );
  }

// Helper function to build a row of buttons
  Widget buildButtonRow(List<String> buttonLabels) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Changed alignment
      children: buttonLabels.map((label) => buildButton(label)).toList(),
    );
  }
}
