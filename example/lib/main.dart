import 'package:flutter/material.dart';
import 'package:ready_made_calculator/ready_made_calculator.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: ReadyMadeCalculator(),
      ),
    );
  }
}
