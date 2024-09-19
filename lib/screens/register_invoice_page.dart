import 'package:flutter/material.dart';
import 'package:my_debtors/model/Debtor.dart';
import 'package:my_debtors/model/Invoice.dart';

import '../di/injector.dart';
import '../domain/repository/debtor_repository.dart';
import '../domain/repository/invoice_repository.dart';

class RegisterInvoicePage extends StatefulWidget {
  Debtor debtor;
  Invoice? invoice;
  InvoiceRepository invoiceRepository =
      Injector.instance.get<InvoiceRepository>();

  RegisterInvoicePage(this.debtor, {this.invoice, super.key});

  @override
  State<RegisterInvoicePage> createState() => _RegisterInvoicePageState();
}

class _RegisterInvoicePageState extends State<RegisterInvoicePage> {
  TextStyle estilo = const TextStyle(fontSize: 25.0);
  TextEditingController descriptionController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController valueController = TextEditingController();

//
// Função que gera um objeto InputDecoration:

//
  InputDecoration decorate(String t) {
    return InputDecoration(
      hintStyle: const TextStyle(fontSize: 25.0),
      hintText: t,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(6.0)),
    );
  }

  @override
  Widget build(BuildContext context) {
    var invoice = widget.invoice;
    if (invoice != null) {
      descriptionController.text = invoice.description;
      dateController.text = invoice.datePayment;
      typeController.text = invoice.typePayment;
      valueController.text = invoice.value.toString();
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Novo lançamento'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: descriptionController,
              decoration: decorate("Descricao"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              keyboardType: TextInputType.datetime,
              controller: dateController,
              decoration: decorate("Data"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: typeController,
              decoration: decorate("Tipo"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: valueController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: decorate("Valor"),
            ),
          ),
          ElevatedButton(
            child: const Text('SALVAR'),
            onPressed: () {
              _saveInvoiceAndGoBack(context, invoice);
            },
          ),
          ElevatedButton(
            child: const Text('CANCELA'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  _saveInvoiceAndGoBack(BuildContext context, Invoice? invoice) {
    if (invoice != null) {
      invoice.description = descriptionController.text;
      invoice.datePayment = dateController.text;
      invoice.typePayment = typeController.text;
      invoice.value = double.parse(valueController.text);

      var id = widget.invoiceRepository.updateInvoice(invoice);
      id.then((value) => debugPrint(value.toString()));
    } else {
      invoice = Invoice(null,
          datePayment: dateController.text,
          typePayment: typeController.text,
          description: descriptionController.text,
          value: double.parse(valueController.text),
          debtor: widget.debtor.id!);

      var id = widget.invoiceRepository.insertInvoice(invoice);
      id.then((value) => debugPrint(value.toString()));
    }
    Navigator.pop(context, invoice);
  }
}
