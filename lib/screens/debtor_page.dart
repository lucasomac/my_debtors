import 'package:flutter/material.dart';

import '../model/Debtor.dart';
import '../model/Invoice.dart';
import '../util/db_helper.dart';

class DebtorPage extends StatefulWidget {
  final Debtor debtor;
  DbHelper helper = DbHelper();

  DebtorPage({super.key, required this.debtor});

  @override
  State<DebtorPage> createState() => _DebtorPageState();
}

class _DebtorPageState extends State<DebtorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.debtor.name)),
      body: _getDebtorsFromDatabase(),
    );
  }

  _getDebtorsFromDatabase() {
    return FutureBuilder<List>(
        future: widget.helper.getAllInvoicesByDebtor(widget.debtor.id!),
        builder: (context, future) {
          if (future.hasData) {
            var list = future.data!.toList().map((element) {
              return Invoice.fromJson(element);
            });
            return _buildInvoices(list.toList());
          } else {
            return Container(
              child: const Center(
                  child: Text("There are no invoices registered!")),
            );
          }
        });
  }

  _buildInvoices(List<Invoice> invoices) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: invoices.length,
      itemBuilder: (context, index) {
        return _buildInvoiceRow(invoices[index]);
      },
    );
  }

  _buildInvoiceRow(Invoice invoice) {
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
