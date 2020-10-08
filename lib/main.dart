import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(Calculator());
}

class Calculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'basic_calculator',
      theme: ThemeData(brightness: Brightness.dark, primarySwatch: Colors.grey),
      home: BasicCalculator(),
    );
  }
}

class BasicCalculator extends StatefulWidget {
  @override
  _BasicCalculatorState createState() => _BasicCalculatorState();
}

class _BasicCalculatorState extends State<BasicCalculator> {
  String output = '0';
  String equation = "0";
  String result = "0";
  String expression = "";
  double equationFontSize = 38.0;
  double resultFontSize = 48.0;

  bPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        equation = "0";
        result = "0";
        equationFontSize = 38.0;
        resultFontSize = 48.0;
      } else if (buttonText == "⌫") {
        equationFontSize = 48.0;
        resultFontSize = 38.0;
        equation = equation.substring(0, equation.length - 1);
        if (equation == "") {
          equation = "0";
        }
      } else if (buttonText == "=") {
        equationFontSize = 38.0;
        resultFontSize = 48.0;

        expression = equation;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');

        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          result = "Error";
        }
      } else {
        equationFontSize = 48.0;
        resultFontSize = 38.0;
        if (equation == "0") {
          equation = buttonText;
        } else {
          equation = equation + buttonText;
        }
      }
    });
  }

  Widget bButton(String bText) {
    return Expanded(
      child: OutlineButton(
          padding: EdgeInsets.all(22.0),
          child: Text(
            bText,
            style: TextStyle(
                color: Colors.blueGrey,
                fontSize: 20.0,
                fontWeight: FontWeight.bold),
          ),
          // color: bColor,
          // textColor: Colors.blue,
          onPressed: () => bPressed(bText)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Basic Calculator'),
        leading: Icon(Icons.calculate),
      ),
      body: Container(
        child: Column(
          children: [
            // Container(
            //     alignment: Alignment.centerRight,
            //     padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 12.0),
            //     child: Text(
            //       output,
            //       style: TextStyle(fontSize: 48.0, fontWeight: FontWeight.bold),
            //     )),
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
                result,
                style: TextStyle(fontSize: resultFontSize),
              ),
            ),
            Expanded(child: Divider()),
            Column(children: [
              Row(
                children: [
                  bButton('7'),
                  bButton('8'),
                  bButton('9'),
                  bButton('/')
                ],
              ),

              Row(children: [
                bButton('4'),
                bButton('5'),
                bButton('6'),
                bButton('×')
              ]),
              Row(children: [
                bButton('1'),
                bButton('2'),
                bButton('3'),
                bButton('-')
              ]),
              Row(children: [
                bButton('.'),
                bButton('0'),
                bButton('00'),
                bButton('+')
              ]),
              Row(children: [
                bButton('C'),
                bButton('='),
                bButton('⌫'),
              ]),
              //   Row(children: [bButton(), bButton(), bButton(), bButton()]),
            ]),
          ],
        ),
      ),
    );
  }
}
