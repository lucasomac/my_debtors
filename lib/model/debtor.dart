import 'invoice.dart';

class Debtor {
  late String _name;
  List<Invoice>? _invoices;

  Debtor({
    required String name,
    List<Invoice>? invoices,
  }) {
    _name = name;
    _invoices = invoices;
  }

  Debtor.fromJson(dynamic json) {
    _name = json['name'];
    _invoices =
        json['invoices'] != null ? json['invoices'] as List<Invoice>? : null;
  }

  String get name => _name;

  List<Invoice>? get invoices => _invoices;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['invoices'] = _invoices?.map((invoice) => invoice.toJson());
    return map;
  }
}
