import 'package:flutter/material.dart';

import '../../di/injector.dart';
import '../../domain/model/debtor.dart';
import '../../domain/repository/debtor_repository.dart';
import '../componets/field_entry.dart';

class RegisterDebtorPage extends StatefulWidget {
  DebtorRepository repository = Injector.instance.get<DebtorRepository>();
  Debtor? debtor;

  RegisterDebtorPage({this.debtor, super.key});

  @override
  State<RegisterDebtorPage> createState() => _RegisterDebtorPageState();
}

class _RegisterDebtorPageState extends State<RegisterDebtorPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController cellphoneController = TextEditingController();

  final GlobalKey<FormState> _newDebtorFormKey = GlobalKey();

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
                if (_newDebtorFormKey.currentState!.validate()) {
                  _saveDebtorAndGoBack(context, debtor);
                }
              },
              icon: const Icon(Icons.save))
        ],
      ),
      body: Form(
        key: _newDebtorFormKey,
        child: Column(
          children: [
            FieldEntry("Nome", nameController, validatorName),
            FieldEntry("Cidade", cityController, validatorCity),
            FieldEntry("E-mail", emailController, validatorEmail),
            FieldEntry("Telefone", cellphoneController, validatorCellphone),
          ],
        ),
      ),
    );
  }

  String? validatorName(String? name) {
    if (name == null || name.isEmpty) {
      return "O nome não pode estar em branco!";
    }
    if (name.contains(RegExp(r'<code>0-9</ code>'))) {
      return "O nome não pode conter dígitos!";
    }
    return null;
  }

  String? validatorCity(String? city) {
    if (city == null || city.isEmpty) {
      return "A cidade não pode estar em branco!";
    }
    return null;
  }

  String? validatorEmail(String? email) {
    if (email == null || email.isEmpty) {
      return "O e-mail não pode estar em branco!";
    }
    final emailRegex =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (!emailRegex.hasMatch(email)) {
      return "Por favor, insira um e-mail válido!";
    }
    return null;
  }

  String? validatorCellphone(String? cellphone) {
    if (cellphone == null || cellphone.isEmpty) {
      return "A número de telefone não pode estar em branco!";
    }
    return null;
  }

  _saveDebtorAndGoBack(BuildContext context, Debtor? debtor) {
    if (debtor != null) {
      debtor.name = nameController.text;
      debtor.city = cityController.text;
      var id = widget.repository.updateDebtor(debtor);
      id.then((value) => debugPrint(value.toString()));
    } else {
      debtor = Debtor(null,
          name: nameController.text,
          city: cityController.text,
          email: emailController.text,
          cellphone: cellphoneController.text);
      var id = widget.repository.insertDebtor(debtor);
      id.then((value) => debugPrint(value.toString()));
    }
    debugPrint("Aqui e o ${debtor.name} de ${debtor.city}");
    Navigator.pop(context, debtor);
  }
}
