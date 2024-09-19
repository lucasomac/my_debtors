import 'package:flutter/material.dart';
import 'package:my_debtors/di/injector.dart';
import 'package:my_debtors/screens/debtors_page.dart';

void main() async {
  Injector.setUpDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Debtors',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: DebtorsPage(),
    );
  }
}
