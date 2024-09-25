import 'package:flutter/material.dart';

import '../../di/injector.dart';
import '../../domain/model/debt.dart';
import '../../domain/model/debt_type.dart';
import '../../domain/model/debtor.dart';
import '../../domain/repository/debt_repository.dart';
import '../componets/field_entry.dart';

class RegisterDebtPage extends StatefulWidget {
  Debtor debtor;
  Debt? debt;
  DebtRepository debtRepository = Injector.instance.get<DebtRepository>();

  RegisterDebtPage(this.debtor, {this.debt, super.key});

  @override
  State<RegisterDebtPage> createState() => _RegisterDebtPageState();
}

class _RegisterDebtPageState extends State<RegisterDebtPage> {
  TextEditingController descriptionController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController valueController = TextEditingController();
  final GlobalKey<FormState> _newDebtorFormKey = GlobalKey();

  DebtType _currentTypeDebt = DebtType.values.first;

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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          FieldEntry("Descrição", descriptionController, validatorDescription),
          InkWell(
            onTap: () {
              _selectDate();
            },
            child: IgnorePointer(
              child: FieldEntry("Data", dateController, validatorDescription),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: DropdownButtonFormField<DebtType>(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0)),
              ),
              items: DebtType.values
                  .map(
                    (debtType) => DropdownMenuItem(
                      value: debtType,
                      child: Text(debtType.getName()),
                    ),
                  )
                  .toList(),
              onChanged: (debtType) {
                setState(() {
                  _currentTypeDebt = debtType!;
                });
              },
              value: _currentTypeDebt,
            ),
          ),
          FieldEntry(
            "Valor",
            valueController,
            validatorValue,
            inputType: const TextInputType.numberWithOptions(decimal: true),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              child: const Text('SALVAR'),
              onPressed: () {
                _saveDebtAndGoBack(context, debt);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              child: const Text('CANCELA'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }

  String? validatorDescription(String? description) {
    if (description == null || description.isEmpty) {
      return "O nome não pode estar em branco!";
    }
    return null;
  }

  String? validatorValue(String? value) {
    if (value == null || value.isEmpty) {
      return "O valor não pode estar vazio!";
    }
    return null;
  }

  Future _selectDate() async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));
    setState(() => dateController.text = picked.toString());
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
