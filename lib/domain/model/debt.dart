class Debt {
  int? _id;
  late String _datePayment;
  late String _typePayment;
  late String _description;
  late num _value;
  late String _debtor;

  Debt(this._id,
      {required String datePayment,
      required String typePayment,
      required String description,
      required num value,
      required String debtor}) {
    _datePayment = datePayment;
    _typePayment = typePayment;
    _description = description;
    _value = value;
    _debtor = debtor;
  }

  Debt.fromJson(dynamic json) {
    _id = json['id'];
    _datePayment = json['datePayment'];
    _typePayment = json['typePayment'];
    _description = json['description'];
    _value = json['value'];
    _debtor = json['debtor'];
  }

  int? get id => _id;

  String get datePayment => _datePayment;

  String get typePayment => _typePayment;

  String get description => _description;

  num get value => _value;

  String get debtor => _debtor;

  set id(int? value) {
    _id = value;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['datePayment'] = _datePayment;
    map['typePayment'] = _typePayment;
    map['description'] = _description;
    map['value'] = _value;
    map['debtor'] = _debtor;
    return map;
  }

  set datePayment(String value) {
    _datePayment = value;
  }

  set debtor(String value) {
    _debtor = value;
  }

  set value(num value) {
    _value = value;
  }

  set description(String value) {
    _description = value;
  }

  set typePayment(String value) {
    _typePayment = value;
  }
}
