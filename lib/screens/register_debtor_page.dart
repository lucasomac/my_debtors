import 'package:flutter/material.dart';
import 'package:my_debtors/model/Debtor.dart';

class RegisterDebtorPage extends StatefulWidget {
  const RegisterDebtorPage({super.key});

  @override
  State<RegisterDebtorPage> createState() => _RegisterDebtorPageState();
}

class _RegisterDebtorPageState extends State<RegisterDebtorPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Debtor"),
        actions: [
          IconButton(
              onPressed: () {
                _saveDebtorAndGoBack(context);
              },
              icon: const Icon(Icons.save))
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: nameController,
              decoration: InputDecoration(
                hintStyle: const TextStyle(fontSize: 25.0),
                hintText: "Name",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6.0)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: cityController,
              decoration: InputDecoration(
                hintStyle: const TextStyle(fontSize: 25.0),
                hintText: "City",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6.0)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _saveDebtorAndGoBack(BuildContext context) {
    var debtorToSave =
        Debtor(null, name: nameController.text, city: cityController.text);
    Navigator.pop(context, debtorToSave);
  }
}
