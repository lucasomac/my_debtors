import 'package:flutter/material.dart';
import 'package:my_debtors/model/Invoice.dart';
import 'package:my_debtors/screens/register_debtor_page.dart';

import '../mocks/debtors_list.dart';
import '../model/Debtor.dart';
import '../util/db_helper.dart';
import 'debtor_page.dart';

class DebtorsPage extends StatefulWidget {
  DebtorsPage({super.key});

  DbHelper helper = DbHelper();

  @override
  State<DebtorsPage> createState() => _DebtorsPageState();
}

class _DebtorsPageState extends State<DebtorsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Debtors')),
        body: _getDebtorsFromDatabase(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _goToRegister(context);
          },
          child: const Icon(Icons.add),
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
        _successAddDebtor(result.name);
      });
    }
  }

  _getDebtorsFromDatabase() {
    return FutureBuilder<List>(
        future: widget.helper.getAllDebtors(),
        builder: (context, future) {
          if (!future.hasData) {
            return const Center(
                child: Text("There are no debtors registered!"));
          } else {
            var list = future.data!.toList().map((element) {
              return Debtor.fromJson(element);
            });
            return _buildDebtors(list.toList());
          }
        });
  }

  _buildDebtors(List<Debtor> debtors) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: debtors.length,
      itemBuilder: (context, index) {
        return _buildDebtorRow(debtors[index]);
      },
    );
  }

  _buildDebtorRow(Debtor debtor) {
    return ListTile(
      title: Text(
        debtor.name,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(debtor.city),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return DebtorPage(
            debtor: debtor,
          );
        }));
      },
    );
  }

  _successAddDebtor(String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("$text adicionado com sucesso!"),
      duration: const Duration(seconds: 2),
      width: 180,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ));
  }
}

int countByType(List<Invoice>? invoices, String type) {
  return invoices != null
      ? invoices.where((invoice) => invoice.typePayment == type).length
      : 0;
}
