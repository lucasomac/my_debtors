import 'package:flutter/material.dart';

import '../model/Debtor.dart';
import '../model/Invoice.dart';
import '../mocks/invoices_list.dart';

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
      body: _buildDebtors(),
    );
  }

  _buildDebtors() {
    var filteredList = invoices
        .where((invoice) => invoice.debtor == widget.debtor.id)
        .toList();
    if (filteredList.isNotEmpty) {
      return ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: filteredList.length,
        itemBuilder: (context, index) {
          return _buildDebtorRow(filteredList[index]);
        },
      );
    } else {
      return const Center(child: Text("Nao foram encontradas transacoes"));
    }
  }

  _buildDebtorRow(Invoice invoice) {
    return Card(
      elevation: 8,
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        tileColor:
            invoice.typePayment == "C" ? Colors.redAccent : Colors.greenAccent,
        title: Text(
          invoice.description,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text("R\$ ${invoice.value} - ${invoice.datePayment}"),
        onTap: () {},
      ),
    );
  }
}
