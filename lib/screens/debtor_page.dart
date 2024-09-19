import 'package:flutter/material.dart';
import 'package:my_debtors/domain/repository/debtor_repository.dart';
import 'package:my_debtors/domain/repository/invoice_repository.dart';
import 'package:my_debtors/screens/register_invoice_page.dart';

import '../di/injector.dart';
import '../model/Debtor.dart';
import '../model/Invoice.dart';
import '../model/menu_type.dart';

class DebtorPage extends StatefulWidget {
  final Debtor debtor;

  DebtorRepository debtorRepository = Injector.instance.get<DebtorRepository>();
  InvoiceRepository invoiceRepository =
      Injector.instance.get<InvoiceRepository>();

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
          _goToRegister(context, null);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  _getInvoicesFromDatabase() {
    return FutureBuilder<List>(
        future:
            widget.invoiceRepository.getAllInvoicesByDebtor(widget.debtor.id!),
        builder: (context, future) {
          if (future.data?.isNotEmpty ?? false) {
            var list = future.data!.toList().map((element) {
              return Invoice.fromJson(element);
            });
            return _buildInvoices(list.toList());
          } else {
            return const Center(child: Text("Nao ha dividas registradas!"));
          }
        });
  }

  _goToRegister(BuildContext context, Invoice? invoice) async {
    var result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return RegisterInvoicePage(widget.debtor, invoice: invoice);
        },
      ),
    );
    if (result is Invoice) {
      setState(() {
        _successSaveInvoice(result.value.toString(), invoice?.id != null);
      });
    }
  }

  _successSaveInvoice(String text, bool isUpdate) {
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
                _goToRegister(context, invoice);
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
                                  widget.invoiceRepository
                                      .deleteInvoice(invoice.id!);
                                  Navigator.pop(context);
                                  setState(() {
                                    _successDeleteInvoice(
                                        invoice.value.toString());
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

  _successDeleteInvoice(String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Lançamento no valor de $text excluído com sucesso!"),
      duration: const Duration(seconds: 2),
      width: 180,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ));
  }
}
