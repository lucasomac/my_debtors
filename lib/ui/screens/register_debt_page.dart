import 'package:flutter/material.dart';

import '../../di/injector.dart';
import '../../domain/model/debt.dart';
import '../../domain/model/debtor.dart';
import '../../domain/repository/debt_repository.dart';

class RegisterDebtPage extends StatefulWidget {
  Debtor debtor;
  Debt? debt;
  DebtRepository debtRepository = Injector.instance.get<DebtRepository>();

  RegisterDebtPage(this.debtor, {this.debt, super.key});

  @override
  State<RegisterDebtPage> createState() => _RegisterDebtPageState();
}

class _RegisterDebtPageState extends State<RegisterDebtPage> {
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
    var debt = widget.debt;
    if (debt != null) {
      descriptionController.text = debt.description;
      dateController.text = debt.datePayment;
      typeController.text = debt.typePayment;
      valueController.text = debt.value.toString();
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Novo lançamento'),
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
            child:
                Text("No campo abaixo digitar C para crédito e D para débito"),
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
            child: const Text('SALVAR'),
            onPressed: () {
              _saveDebtAndGoBack(context, debt);
            },
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

  _saveDebtAndGoBack(BuildContext context, Debt? debt) {
    if (debt != null) {
      debt.description = descriptionController.text;
      debt.datePayment = dateController.text;
      debt.typePayment = typeController.text;
      debt.value = double.parse(valueController.text);

      var id = widget.debtRepository.updateDebt(debt);
      id.then((value) => debugPrint(value.toString()));
    } else {
      debt = Debt(null,
          datePayment: dateController.text,
          typePayment: typeController.text,
          description: descriptionController.text,
          value: double.parse(valueController.text),
          debtor: widget.debtor.id!);

      var id = widget.debtRepository.insertDebt(debt);
      id.then((value) => debugPrint(value.toString()));
    }
    Navigator.pop(context, debt);
  }
}
