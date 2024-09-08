import 'package:flutter/material.dart';
import 'package:my_debtors/model/Invoice.dart';

import '../model/Debtor.dart';

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
    );
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
      subtitle:
          Text("Creditos: ${countByType(debtor.invoices?.cast<Invoice>(), "C")}"
              " | "
              "Debitos: ${countByType(debtor.invoices?.cast<Invoice>(), "D")}"),
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(debtor.name),
          duration: Duration(seconds: 2),
          width: 180,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ));
      },
    );
  }
}

int countByType(List<Invoice>? invoices, String type) {
  return invoices != null
      ? invoices.where((invoice) => invoice.typePayment == type).length
      : 0;
}
