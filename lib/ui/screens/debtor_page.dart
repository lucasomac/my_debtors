import 'package:flutter/material.dart';

import '../../di/injector.dart';
import '../../domain/model/debt.dart';
import '../../domain/model/debtor.dart';
import '../../domain/model/menu_type.dart';
import '../../domain/repository/debt_repository.dart';
import '../../domain/repository/debtor_repository.dart';
import 'register_debt_page.dart';

class DebtorPage extends StatefulWidget {
  final Debtor debtor;

  DebtorRepository debtorRepository = Injector.instance.get<DebtorRepository>(nominal: Nominal.FIREBASE_DATABASE);
  DebtRepository debtRepository = Injector.instance.get<DebtRepository>();

  DebtorPage({super.key, required this.debtor});

  @override
  State<DebtorPage> createState() => _DebtorPageState();
}

class _DebtorPageState extends State<DebtorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.debtor.name)),
      body: Column(
        children: [
          _getHeadPage(),
          Expanded(child: _getDebtsFromDatabase()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _goToRegister(context, null);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  _getHeadPage() {
    return FutureBuilder(
        future:
            widget.debtRepository.getAllDebtsByDebtorEmail(widget.debtor.email),
        builder: (context, future) {
          if (future.data?.isNotEmpty ?? false) {
            var list = future.data!.toList().map((element) {
              return Debt.fromJson(element);
            });
            var credits = list
                .where((debt) => debt.typePayment == "C")
                .map((debt) => debt.value)
                .reduce((value, debt) => value + debt);
            var debits = list
                .where((debt) => debt.typePayment == "D")
                .map((debt) => debt.value)
                .reduce((value, debt) => value + debt);
            return Text("O saldo deste devedor é R\$ ${credits - debits}");
          } else {
            return Text("O saldo deste devedor é R\$ 0");
          }
        });
  }

  _getDebtsFromDatabase() {
    return FutureBuilder<List>(
        future:
            widget.debtRepository.getAllDebtsByDebtorEmail(widget.debtor.email),
        builder: (context, future) {
          if (future.data?.isNotEmpty ?? false) {
            var list = future.data!.toList().map((element) {
              return Debt.fromJson(element);
            });
            return _buildDebts(list.toList());
          } else {
            return const Center(child: Text("Nao ha dividas registradas!"));
          }
        });
  }

  _goToRegister(BuildContext context, Debt? debt) async {
    var result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return RegisterDebtPage(widget.debtor, debt: debt);
        },
      ),
    );
    if (result is Debt) {
      setState(() {
        _successSaveDebt(result.value.toString(), debt?.id != null);
      });
    }
  }

  _successSaveDebt(String text, bool isUpdate) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: isUpdate
          ? const Text("Lançamento alterado com sucesso!")
          : Text("Lançamento de $text foi contabilizado com sucesso!"),
      duration: const Duration(seconds: 2),
      width: 180,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ));
  }

  _buildDebts(List<Debt> debts) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: debts.length,
      itemBuilder: (context, index) {
        return _buildDebtRow(debts[index]);
      },
    );
  }

  _buildDebtRow(Debt debt) {
    return Card(
      elevation: 8,
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        trailing: PopupMenuButton<MenuType>(
          itemBuilder: (BuildContext context) => <PopupMenuEntry<MenuType>>[
            const PopupMenuItem<MenuType>(
              value: MenuType.edit,
              child: Text('Editar'),
            ),
            const PopupMenuItem<MenuType>(
              value: MenuType.delete,
              child: Text('Deletar'),
            ),
          ],
          onSelected: (MenuType menu) {
            switch (menu) {
              case MenuType.edit:
                _goToRegister(context, debt);
              case MenuType.delete:
                showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => Dialog(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Text('Confirma a exclusão deste lançamento?'),
                          const SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('Cancelar'),
                              ),
                              TextButton(
                                onPressed: () {
                                  widget.debtRepository.deleteDebt(debt.id!);
                                  Navigator.pop(context);
                                  setState(() {
                                    _successDeleteDebt(debt.value.toString());
                                  });
                                },
                                child: const Text('Confirmar'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
            }
          },
        ),
        tileColor:
            debt.typePayment == "C" ? Colors.redAccent : Colors.greenAccent,
        title: Text(
          debt.description,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text("R\$ ${debt.value} - ${debt.datePayment}"),
        onTap: () {},
      ),
    );
  }

  _successDeleteDebt(String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Lançamento no valor de $text excluído com sucesso!"),
      duration: const Duration(seconds: 2),
      width: 180,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ));
  }
}
