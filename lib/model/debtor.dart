import 'invoice.dart';

class Debtor {
  late String _name;

  Debtor({
    required String name,
    List<Invoice>? invoices,
  }) {
    _name = name;
  }

  Debtor.fromJson(dynamic json) {
    _name = json['name'];
  }

  String get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    return map;
  }
}
