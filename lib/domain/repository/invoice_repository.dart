import '../../model/Invoice.dart';

abstract class InvoiceRepository {
  Future<int> insertInvoice(Invoice invoice);

  Future<List> getAllInvoicesByDebtor(int debtorId);

  Future<int> getCountInvoicesByDebtor(int debtorId);

  Future<int> updateInvoice(Invoice invoice);

  Future<int> deleteInvoice(int id);
}
