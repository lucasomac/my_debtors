class Invoice {
  late String _datePayment;
  late String _typePayment;
  late String _description;
  late num _value;

  Invoice(
      {required String datePayment,
      required String typePayment,
      required String description,
      required num value}) {
    _datePayment = datePayment;
    _typePayment = typePayment;
    _description = description;
    _value = value;
  }

  Invoice.fromJson(dynamic json) {
    _datePayment = json['datePayment'];
    _typePayment = json['typePayment'];
    _description = json['description'];
    _value = json['value'];
  }

  String get datePayment => _datePayment;

  String get typePayment => _typePayment;

  String get description => _description;

  num get value => _value;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['datePayment'] = _datePayment;
    map['typePayment'] = _typePayment;
    map['description'] = _description;
    map['value'] = _value;
    return map;
  }
}
