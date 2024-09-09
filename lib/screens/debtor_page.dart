import 'package:flutter/material.dart';
import 'package:my_debtors/model/Debtor.dart';

import '../model/Invoice.dart';

class DebtorPage extends StatefulWidget {
  final Debtor debtor;

  const DebtorPage({super.key, required this.debtor});

  @override
  State<DebtorPage> createState() => _DebtorPageState();
}

class _DebtorPageState extends State<DebtorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.debtor.name)),
      body: Placeholder(),
    );
  }

  _buildDebtors() {
    // var invoices = widget.debtor.invoices;
    // if (invoices != null) {
      return ListView.builder(
        padding: const EdgeInsets.all(16),
        // itemCount: widget.debtor.invoices?.length,
        itemBuilder: (context, index) {
          // return _buildDebtorRow(widget.debtor.invoices?[index] as Invoice);
        },
      );
    // } else {
    //   return const Center(child: Text("Nao foram encontradas transacoes"));
    // }
  }

  _buildDebtorRow(Invoice invoice) {
    return ListTile(
      title: Text(
        invoice.description,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text("R\$ ${invoice.value} - ${invoice.datePayment}"),
      onTap: () {},
    );
  }
}
