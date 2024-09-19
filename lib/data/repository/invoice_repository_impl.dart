import '../../domain/repository/invoice_repository.dart';
import '../../model/Invoice.dart';
import '../../util/db_helper.dart';

class InvoiceRepositoryImpl implements InvoiceRepository {
  DbHelper helper;

  InvoiceRepositoryImpl(this.helper);

  @override
  Future<int> deleteInvoice(int id) {
    return helper.deleteInvoice(id);
  }

  @override
  Future<List> getAllInvoicesByDebtor(int debtorId) {
    return helper.getAllInvoicesByDebtor(debtorId);
  }

  @override
  Future<int> getCountInvoicesByDebtor(int debtorId) {
    return helper.getCountInvoicesByDebtor(debtorId);
  }

  @override
  Future<int> insertInvoice(Invoice invoice) {
    return insertInvoice(invoice);
  }

  @override
  Future<int> updateInvoice(Invoice invoice) {
    return updateInvoice(invoice);
  }
}
