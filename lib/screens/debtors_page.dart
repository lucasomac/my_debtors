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
            _goToRegister(context, null);
          },
          child: const Icon(Icons.add),
        ));
  }

  _goToRegister(BuildContext context, Debtor? debtor) async {
    var result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return RegisterDebtorPage(debtor: debtor);
        },
      ),
    );
    if (result is Debtor) {
      setState(() {
        _successSaveDebtor(result.name, debtor?.id != null);
      });
    }
  }

  _getDebtorsFromDatabase() {
    return FutureBuilder<List>(
        future: widget.helper.getAllDebtors(),
        builder: (context, future) {
          debugPrint(future.data.toString());
          if (future.data!.isEmpty) {
            return const Center(
                child: Text("Não há devedores registrados!"));
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
              _goToRegister(context, debtor);
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
                        const Text('Confirma a exclusão deste devedor?'),
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
                                widget.helper.deleteDebtor(debtor.id!);
                                Navigator.pop(context);
                                setState(() {
                                  _successDeleteDebtor(debtor.name);
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
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return DebtorPage(
                debtor: debtor,
              );
            },
          ),
        ).then((_) => setState(() {}));
      },
    );
  }

  _successSaveDebtor(String text, bool isUpdate) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content:
          Text("$text ${isUpdate ? "alterado" : "adicionado"} com sucesso!"),
      duration: const Duration(seconds: 2),
      width: 180,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ));
  }

  _successDeleteDebtor(String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("$text excluído com sucesso!"),
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

enum MenuType { edit, delete }
