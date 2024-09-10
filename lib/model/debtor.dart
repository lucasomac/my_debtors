import 'invoice.dart';

class Debtor {
  int? _id;
  late String _name;
  late String _city;

  Debtor(
    this._id, {
    required String name,
    required String city,
  }) {
    _name = name;
    _city = city;
  }

  Debtor.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _city = json['city'];
  }

  int? get id => _id;

  String get name => _name;

  String get city => _city;

  set id(int? value) {
    _id = value;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['city'] = _city;
    return map;
  }

  set name(String value) {
    _name = value;
  }

  set city(String value) {
    _city = value;
  }
}
