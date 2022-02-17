// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(Calculator());
}

class Calculator extends StatelessWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Calculator",
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: mainCalculator(),
    );
  }
}

class mainCalculator extends StatelessWidget {
  const mainCalculator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.purple),
      title: "Calculator",
      home: calculator(),
    );
  }
}

class calculator extends StatefulWidget {
  const calculator({Key? key}) : super(key: key);

  @override
  _calculatorState createState() => _calculatorState();
}

class _calculatorState extends State<calculator> {
  String equation = "0";
  String results = "0";
  String expression = "";
  double equationFontSize = 38.0;
  double resultFontSize = 48.0;
  buttonPress(String btnText) {
    setState(() {
      if (btnText == "C") {
        equation = "0";
        results = "0";
      } else if (btnText == "Del") {
        equation = equation.substring(0, equation.length - 1);
        if (equation == "") {
          equation = "0";
        }
      } else if (btnText == "=") {
        expression = equation;
        expression = expression.replaceAll("×", "*");
        expression = expression.replaceAll("÷", "/");
        Parser p = new Parser();
        Expression exp = p.parse(expression);
        ContextModel cm = ContextModel();
        results = '${exp.evaluate(EvaluationType.REAL, cm)}';
      } else {
        if (equation == "0") {
          equation = btnText;
        } else {
          equation = equation + btnText;
        }
      }
    });
  }

  Widget buildButton(
      String btnText, double btnHeight, Color btnColor, Color txtColor) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * btnHeight,
      color: btnColor,
      child: FlatButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
              side: BorderSide(
                  color: Colors.white, width: 1, style: BorderStyle.solid)),
          padding: EdgeInsets.all(16.0),
          onPressed: () => buttonPress(btnText),
          child: Text(
            btnText,
            style: TextStyle(
                fontSize: 30, fontWeight: FontWeight.normal, color: txtColor),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Calculator")),
        body: Column(children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(
              equation,
              style: TextStyle(fontSize: equationFontSize),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
            child: Text(
              results,
              style: TextStyle(fontSize: resultFontSize),
            ),
          ),
          Expanded(child: Divider()),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * .75,
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        buildButton("C", 1, Colors.red, Colors.black),
                        buildButton("Del", 1, Colors.grey, Colors.black),
                        buildButton("÷", 1, Colors.blueAccent, Colors.white),
                        // buildButton("+", 1, Colors.orange, Colors.white)
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton("1", 1, Colors.grey, Colors.black),
                        buildButton("2", 1, Colors.grey, Colors.black),
                        buildButton("3", 1, Colors.grey, Colors.black),
                        // buildButton("+", 1, Colors.orange, Colors.white)
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton("4", 1, Colors.grey, Colors.black),
                        buildButton("5", 1, Colors.grey, Colors.black),
                        buildButton("6", 1, Colors.grey, Colors.black),
                        // buildButton("-", 1, Colors.orange, Colors.white)
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton("7", 1, Colors.grey, Colors.black),
                        buildButton("8", 1, Colors.grey, Colors.black),
                        buildButton("9", 1, Colors.grey, Colors.black),
                        // buildButton("*", 1, Colors.orange, Colors.white)
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton(".", 1, Colors.grey, Colors.black),
                        buildButton("0", 1, Colors.grey, Colors.black),
                        buildButton("00", 1, Colors.grey, Colors.black),
                        // buildButton("=", 2, Colors.orange, Colors.white)
                      ],
                    )
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * .25,
                child: Table(
                  children: [
                    TableRow(children: [
                      buildButton("×", 1, Colors.blueAccent, Colors.white)
                    ]),
                    TableRow(children: [
                      buildButton("-", 1, Colors.blueAccent, Colors.white)
                    ]),
                    TableRow(children: [
                      buildButton("+", 1, Colors.blueAccent, Colors.white)
                    ]),
                    TableRow(children: [
                      buildButton("=", 2, Colors.blueAccent, Colors.white)
                    ])
                  ],
                ),
              )
            ],
          )
        ]));
  }
}
