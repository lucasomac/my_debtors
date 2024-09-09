import 'package:flutter/material.dart';
import 'package:my_debtors/model/Debtor.dart';

class RegisterInvoicePage extends StatefulWidget {
  Debtor debtor;

  RegisterInvoicePage(this.debtor, {super.key});

  @override
  State<RegisterInvoicePage> createState() => _RegisterInvoicePageState();
}

class _RegisterInvoicePageState extends State<RegisterInvoicePage> {
  TextStyle estilo = const TextStyle(fontSize: 25.0);
  TextEditingController descriptionController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController valueController = TextEditingController();

//
// Função que gera um objeto InputDecoration:

//
  InputDecoration decorate(String t) {
    return InputDecoration(
      hintStyle: const TextStyle(fontSize: 25.0),
      hintText: t,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(6.0)),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculador de Média: Tela de Digitação'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: descriptionController,
              decoration: decorate("Descricao"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              keyboardType: TextInputType.datetime,
              controller: dateController,
              decoration: decorate("Data"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: typeController,
              decoration: decorate("Tipo"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: valueController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: decorate("Valor"),
            ),
          ),
          ElevatedButton(
            child: const Text('CALCULA'),
            onPressed: () {},
          ),
          ElevatedButton(
            child: const Text('CANCELA'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
