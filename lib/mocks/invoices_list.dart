import 'package:my_debtors/model/Invoice.dart';

import 'debtors_list.dart';

final invoices = [
  Invoice(
      datePayment: "29/06/1992",
      typePayment: "C",
      description: "Celular",
      value: 15003.23,
      debtor: debtors[0]),
  Invoice(
      datePayment: "29/06/1992",
      typePayment: "D",
      description: "Celular",
      value: 1503.23,
      debtor: debtors[0]),
  Invoice(
      datePayment: "04/06/1992",
      typePayment: "C",
      description: "Calca",
      value: 200,
      debtor: debtors[1]),
  Invoice(
      datePayment: "04/06/1992",
      typePayment: "D",
      description: "Calca",
      value: 100,
      debtor: debtors[1])
];
