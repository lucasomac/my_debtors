import 'package:flutter/material.dart';
import 'package:my_debtors/screens/register_invoice_page.dart';

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
      body: _getInvoicesFromDatabase(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _goToRegister(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  _getInvoicesFromDatabase() {
    return FutureBuilder<List>(
        future: widget.helper.getAllInvoicesByDebtor(widget.debtor.id!),
        builder: (context, future) {
          if (future.hasData) {
            var list = future.data!.toList().map((element) {
              return Invoice.fromJson(element);
            });
            return _buildInvoices(list.toList());
          } else {
            return const Center(
                child: Text("There are no invoices registered!"));
          }
        });
  }

  _goToRegister(BuildContext context) async {
    var result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return RegisterInvoicePage(widget.debtor);
        },
      ),
    );
    if (result is Invoice) {
      setState(() {
        _successAddInvoice(result.value.toString());
      });
    }
  }

  _successAddInvoice(String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("$text foi contabilizado!"),
      duration: const Duration(seconds: 2),
      width: 180,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ));
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
