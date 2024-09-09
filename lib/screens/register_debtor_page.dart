import 'package:flutter/material.dart';

class RegisterDebtorPage extends StatefulWidget {
  const RegisterDebtorPage({super.key});

  @override
  State<RegisterDebtorPage> createState() => _RegisterDebtorPageState();
}

class _RegisterDebtorPageState extends State<RegisterDebtorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Debtor"),
      ),
    );
  }
}
