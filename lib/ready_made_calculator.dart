import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:string_validator/string_validator.dart';

class ReadyMadeCalculator extends StatefulWidget {
  const ReadyMadeCalculator({Key? key}) : super(key: key);

  @override
  State<ReadyMadeCalculator> createState() => _ReadyMadeCalculatorState();
}

class _ReadyMadeCalculatorState extends State<ReadyMadeCalculator> {
  String input = "";
  String output = "";

  final List<String> calButtonsList = [
    'AC',
    '+/-',
    '%',
    'DEL',
    '7',
    '8',
    '9',
    '/',
    '4',
    '5',
    '6',
    'x',
    '1',
    '2',
    '3',
    '-',
    '0',
    '.',
    '=',
    '+',
  ];

  @override
  Widget build(BuildContext context) {
    var style = const TextStyle(
        fontSize: 28,
        fontFamily: 'Dosis',
        color: Color(0xffffffff),
        fontWeight: FontWeight.normal);

    return Column(
      children: <Widget>[
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Align(
                alignment: Alignment.topRight,
                child: Text(
                  input,
                  style: style.copyWith(
                      color: const Color(0xff000000), fontSize: 20),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Text(
                  output,
                  style: style.copyWith(
                      color: const Color(0xff000000),
                      fontSize: 48,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 2,
          child: GridView.builder(
              itemCount: calButtonsList.length,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4),
              itemBuilder: (BuildContext context, int index) {
                // Clear Button

                if (index == 0) {
                  return CalButton(
                      onTapped: () {
                        setState(() {
                          input = '';
                          output = '0';
                        });
                      },
                      value: calButtonsList[index],
                      color: const Color(0xff0099CC),
                      btnTextStyle: style);
                }

                // +/- button
                else if (index == 1) {
                  return CalButton(
                    value: calButtonsList[index],
                    color: const Color(0xff0099CC),
                    btnTextStyle: style,
                    onTapped: () {
                      setState(() {
                        if (contains(input, "-")) {
                          String data = input.replaceAll("-", "+");
                          output = data;
                        } else if (input.startsWith("+", 0)) {
                          String data = input.replaceFirst("+", "-", 0);
                          output = data;
                        } else if (input.isEmpty) {
                        } else {}
                      });
                    },
                  );
                }
                // % Button
                else if (index == 2) {
                  return CalButton(
                    onTapped: () {
                      setState(() {
                        input += calButtonsList[index];
                      });
                    },
                    value: calButtonsList[index],
                    color: const Color(0xff0099CC),
                    btnTextStyle: style,
                  );
                }
                // Delete Button
                else if (index == 3) {
                  return CalButton(
                    onTapped: () {
                      setState(() {
                        input = input.substring(0, input.length - 1);
                      });
                    },
                    value: calButtonsList[index],
                    color: const Color(0xffEE2C2C),
                    btnTextStyle: style,
                  );
                }
                // Equal_to Button
                else if (index == 18) {
                  return CalButton(
                    onTapped: () {
                      setState(() {
                        equalsTo();
                      });
                    },
                    value: calButtonsList[index],
                    color: const Color(0xff104E8B),
                    btnTextStyle: style,
                  );
                }

                //  other buttons
                else {
                  return CalButton(
                    onTapped: () {
                      setState(() {
                        input += calButtonsList[index];
                      });
                    },
                    value: calButtonsList[index],
                    color: isOperator(calButtonsList[index])
                        ? const Color(0xff104E8B)
                        : Colors.grey[200],
                    btnTextStyle: style.copyWith(
                      color: isOperator(calButtonsList[index])
                          ? const Color(0xffffffff)
                          : const Color(0xff000000),
                    ),
                  );
                }
              }),
        ),
      ],
    );
  }

  displayBtn(String value, int index, Color color) {
    TextStyle style = const TextStyle(fontSize: 16);

    return CalButton(
      onTapped: () {
        setState(() {
          input += calButtonsList[index];
        });
      },
      value: value,
      color: color,
      btnTextStyle: style,
    );
  }

  bool isOperator(String x) {
    if (x == '/' || x == 'x' || x == '-' || x == '+' || x == '=') {
      return true;
    }
    return false;
  }

  equalsTo() {
    try {
      Parser p = Parser();
      Expression exp = p.parse(input.replaceAll('x', '*'));
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);
      output = eval.toString();
    } catch (e) {
      output = "Error";
    }
  }
}

// Buttons
class CalButton extends StatelessWidget {
  final Color? color;
  final String? value;
  final TextStyle? btnTextStyle;
  final VoidCallback? onTapped;

  const CalButton(
      {Key? key,
      required this.color,
      required this.value,
      required this.btnTextStyle,
      this.onTapped})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTapped!,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 3),
        child: Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(60)),
            color: color,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Center(
            child: Text(
              value!,
              textAlign: TextAlign.center,
              style: btnTextStyle,
            ),
          ),
        ),
      ),
    );
  }
}

// Unit Test
class Validate {
  static addNo(int v1, int v2) {
    return v1 + v2;
  }
}
