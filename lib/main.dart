import 'package:flutter/material.dart';
import 'package:my_debtors/mocks/debtors_list.dart';
import 'package:my_debtors/screens/debtors_page.dart';
import 'package:my_debtors/util/db_helper.dart';

import 'mocks/invoices_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Instanciar o dbhelper:
    DbHelper helper = DbHelper();
    // for (var debtor in debtors) {
    //   Future id = helper.insertDebtor(debtor);
    //   id.then( (value) => debugPrint(value.toString()) );
    // }
    for (var invoice in invoices) {
      Future id = helper.insertInvoice(invoice );
      id.then((value) => debugPrint(value.toString()));
    }
    return MaterialApp(
      title: 'My Debtors',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const DebtorsPage(),
    );
  }
}
