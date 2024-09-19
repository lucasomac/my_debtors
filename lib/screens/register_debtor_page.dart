import 'package:flutter/material.dart';
import 'package:my_debtors/model/Debtor.dart';

import '../util/db_helper.dart';

class RegisterDebtorPage extends StatefulWidget {
  DbHelper helper = DbHelper();
  Debtor? debtor;

  RegisterDebtorPage({this.debtor, super.key});

  @override
  State<RegisterDebtorPage> createState() => _RegisterDebtorPageState();
}

class _RegisterDebtorPageState extends State<RegisterDebtorPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var debtor = widget.debtor;
    if (debtor != null) {
      nameController.text = debtor.name;
      cityController.text = debtor.city;
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Debtor"),
        actions: [
          IconButton(
              onPressed: () {
                _saveDebtorAndGoBack(context, debtor);
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

  _saveDebtorAndGoBack(BuildContext context, Debtor? debtor) {
    if (debtor != null) {
      debtor.name = nameController.text;
      debtor.city = cityController.text;
      var id = widget.helper.updateDebtor(debtor);
      id.then((value) => debugPrint(value.toString()));
    } else {
      debtor =
          Debtor(null, name: nameController.text, city: cityController.text);
      var id = widget.helper.insertDebtor(debtor);
      id.then((value) => debugPrint(value.toString()));
    }
    debugPrint("Aqui e o ${debtor.name} de ${debtor.city}");
    Navigator.pop(context, debtor);
  }
}
