import 'package:cloud_firestore/cloud_firestore.dart';

class Debtor {
  late String _name;
  late String _city;
  late String _email;
  late String _cellphone;

  Debtor({
    required String name,
    required String city,
    required String email,
    required String cellphone,
  }) {
    _name = name;
    _city = city;
    _email = email;
    _cellphone = cellphone;
  }

  Debtor.fromJson(dynamic json) {
    _name = json['name'];
    _city = json['city'];
    _email = json['email'];
    _cellphone = json['cellphone'];
  }

  Debtor.fromDocumentSnapshot(DocumentSnapshot doc) {
    _name = doc['name'] as String;
    _city = doc['city'] as String;
    _email = doc['email'] as String;
    _cellphone = doc['cellphone'] as String;
  }

  String get name => _name;

  String get city => _city;

  String get email => _email;

  String get cellphone => _cellphone;

  set email(String value) {
    _email = value;
  }

  set name(String value) {
    _name = value;
  }

  set city(String value) {
    _city = value;
  }

  set cellphone(String value) {
    _cellphone = value;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['city'] = _city;
    map['email'] = _email;
    map['cellphone'] = _cellphone;
    return map;
  }
}
