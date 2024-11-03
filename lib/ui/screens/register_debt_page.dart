import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:brasil_fields/brasil_fields.dart';
import '../../di/injector.dart';
import '../../domain/model/debt.dart';
import '../../domain/model/debt_type.dart';
import '../../domain/model/debtor.dart';
import '../../domain/repository/debt_repository.dart';
import 'package:intl/intl.dart'; // for date format
import '../components/field_entry.dart';

class RegisterDebtPage extends StatefulWidget {
  Debtor debtor;
  Debt? debt;
  DebtRepository debtRepository =
      Injector.instance.get<DebtRepository>(nominal: Injector.nominalDefault);

  RegisterDebtPage(this.debtor, {this.debt, super.key});

  @override
  State<RegisterDebtPage> createState() => _RegisterDebtPageState();
}

class _RegisterDebtPageState extends State<RegisterDebtPage> {
  TextEditingController descriptionController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController valueController = TextEditingController();
  final GlobalKey<FormState> _newDebtFormKey = GlobalKey();

  DebtType _currentTypeDebt = DebtType.values.first;

  @override
  Widget build(BuildContext context) {
    var debt = widget.debt;
    if (debt != null) {
      descriptionController.text = debt.description;
      dateController.text = debt.datePayment;
      valueController.text = debt.value.toString();
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Novo lançamento'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _newDebtFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              FieldEntry(
                  "Descrição", descriptionController, validatorDescription),
              InkWell(
                onTap: () {
                  _selectDate();
                },
                child: IgnorePointer(
                  child:
                      FieldEntry("Data", dateController, validatorDate),
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
                formatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  RealInputFormatter(moeda: true)
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  child: const Text('SALVAR'),
                  onPressed: () {
                    if (_newDebtFormKey.currentState!.validate()) {
                      _saveDebtAndGoBack(context, debt);
                    }
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
        ),
      ),
    );
  }

  String? validatorDescription(String? description) {
    if (description == null || description.isEmpty) {
      return "A descrição não pode estar em branco!";
    }
    return null;
  }

  String? validatorDate(String? description) {
    if (description == null || description.isEmpty) {
      return "A data não pode estar em branco!";
    }
    return null;
  }

  String? validatorValue(String? value) {
    if (value == null || value.isEmpty) {
      return "O valor não pode estar vazio!";
    }
    if (UtilBrasilFields.converterMoedaParaDouble(value) == 0) {
      return "O valor não pode ser zero!";
    }
    return null;
  }

  Future _selectDate() async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));
    setState(
        () => dateController.text = DateFormat('dd-MM-yyyy').format(picked!));
  }

  _saveDebtAndGoBack(BuildContext context, Debt? debt) {
    if (debt != null) {
      debt.description = descriptionController.text;
      debt.datePayment = dateController.text;
      debt.typePayment = _currentTypeDebt.getTypeCode();
      debt.value =
          UtilBrasilFields.converterMoedaParaDouble(valueController.text);

      var id = widget.debtRepository.updateDebt(debt);
      id.then((value) => debugPrint(value.toString()));
    } else {
      debt = Debt(
          id: null,
          datePayment: dateController.text,
          typePayment: _currentTypeDebt.getTypeCode(),
          description: descriptionController.text,
          value:
              UtilBrasilFields.converterMoedaParaDouble(valueController.text),
          debtor: widget.debtor.email);

      var id = widget.debtRepository.insertDebt(debt);
      id.then((value) => debugPrint(value.toString()));
    }
    Navigator.pop(context, debt);
  }
}
