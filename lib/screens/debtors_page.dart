import 'package:flutter/material.dart';
import 'package:my_debtors/model/Invoice.dart';
import 'package:my_debtors/screens/register_debtor_page.dart';

import '../model/Debtor.dart';
import 'debtor_page.dart';

class DebtorsPage extends StatefulWidget {
  const DebtorsPage({super.key});

  @override
  State<DebtorsPage> createState() => _DebtorsPageState();
}

class _DebtorsPageState extends State<DebtorsPage> {
  final _debtors = [
    Debtor(name: "Lucas"),
    Debtor(name: "Mateus"),
    Debtor(name: "Ariane")
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Debtors')),
        body: _buildDebtors(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _goToRegister(context);
          },
          child: Icon(Icons.add),
        ));
  }

  _goToRegister(BuildContext context) async {
    var result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return RegisterDebtorPage();
        },
      ),
    );
    if (result is Debtor) {
      setState(() {
        _debtors.add(result);
      });
    }
  }

  _buildDebtors() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _debtors.length,
      itemBuilder: (context, index) {
        return _buildDebtorRow(_debtors[index]);
      },
    );
  }

  _buildDebtorRow(Debtor debtor) {
    return ListTile(
      title: Text(
        debtor.name,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      // subtitle:
      //     Text("Creditos: ${countByType(debtor.invoices?.cast<Invoice>(), "C")}"
      //         " | "
      //         "Debitos: ${countByType(debtor.invoices?.cast<Invoice>(), "D")}"),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return DebtorPage(
            debtor: debtor,
          );
        }));
      },
    );
  }
}

int countByType(List<Invoice>? invoices, String type) {
  return invoices != null
      ? invoices.where((invoice) => invoice.typePayment == type).length
      : 0;
}

snackshow(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(text),
    duration: Duration(seconds: 2),
    width: 180,
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  ));
}
