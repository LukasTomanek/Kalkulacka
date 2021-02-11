import 'package:flutter/material.dart';
import 'package:kalkulacka/buttons.dart';
import 'package:math_expressions/math_expressions.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var userQuestion = "";
  var userAnswer = "";

  final myTextStyle = TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold);

  final List<String> buttons = [
    "C",
    "DEL",
    "%",
    "/",
    "9",
    "8",
    "7",
    "x",
    "6",
    "5",
    "4",
    "-",
    "3",
    "2",
    "1",
    "+",
    "0",
    ".",
    "ANS",
    "=",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: Text( "Kalkulačka"),backgroundColor: Colors.black,),
      backgroundColor: Colors.white70,
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(
                    height: 70,
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      userQuestion,
                      style: TextStyle(fontSize: 40, color: Colors.black),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    alignment: Alignment.centerRight,
                    child: Text(
                      userAnswer,
                      style: TextStyle(fontSize: 40, color: Colors.black),
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              alignment: Alignment.topCenter,
              color: Colors.black,
              child: GridView.builder(
                  itemCount: buttons.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4),
                  itemBuilder: (BuildContext context, int index) {
                    if (index == 0) {
                      return MyButton(
                        buttonTapped: () {
                          setState(() {
                            userQuestion = "";
                          });
                        },
                        buttonText: buttons[index],
                        color: Colors.lightGreen[400],
                        textColor: Colors.black,
                      );
                    } else if (index == 1) {
                      return MyButton(
                        buttonTapped: () {
                          setState(() {
                            userQuestion = userQuestion.substring(
                                0, userQuestion.length - 1);
                          });
                        },
                        buttonText: buttons[index],
                        color: Colors.red[400],
                        textColor: Colors.black,
                      );
                    } else if (index == buttons.length - 1) {
                      return MyButton(
                        buttonTapped: () {
                          setState(() {
                            equalPressed();
                          });
                        },
                        buttonText: buttons[index],
                        color: Colors.white70,
                        textColor: Colors.black,
                      );
                    } else {
                      return MyButton(
                        buttonTapped: () {
                          setState(() {
                            userQuestion += buttons[index];
                          });
                        },
                        buttonText: buttons[index],
                        color: isOperator(buttons[index])
                            ? Colors.white70
                            : Colors.white10,
                        textColor: isOperator(buttons[index])
                            ? Colors.black
                            : Colors.white,
                      );
                    }
                  }),
            ),
          ),
        ],
      ),
    );
  }

  bool isOperator(String x) {
    if (x == "%" || x == "/" || x == "x" || x == "-" || x == "+" || x == "=") {
      return true;
    }
    return false;
  }

  void equalPressed() {
    String finalQuestion = userQuestion;
    finalQuestion = finalQuestion.replaceAll("x", "*");

    Parser p = Parser();
    Expression exp = p.parse(finalQuestion);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);

    userAnswer = eval.toString();
  }
}
