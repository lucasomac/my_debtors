import '../domain/model/debt.dart';
import 'debtors_list.dart';

final debts = [
  Debt(1,
      datePayment: DateTime.now().toString(),
      typePayment: "C",
      description: "Celular",
      value: 15003.23,
      debtor: debtors[0].id!),
  Debt(2,
      datePayment: DateTime.now().toString(),
      typePayment: "D",
      description: "Celular",
      value: 1503.23,
      debtor: debtors[0].id!),
  Debt(3,
      datePayment: DateTime.now().toString(),
      typePayment: "C",
      description: "Calca",
      value: 200,
      debtor: debtors[1].id!),
  Debt(4,
      datePayment: DateTime.now().toString(),
      typePayment: "D",
      description: "Calca",
      value: 100,
      debtor: debtors[1].id!)
];
