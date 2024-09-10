class Invoice {
  int? _id;
  late DateTime _datePayment;
  late String _typePayment;
  late String _description;
  late num _value;
  late int _debtor;

  Invoice(this._id,
      {required DateTime datePayment,
      required String typePayment,
      required String description,
      required num value,
      required int debtor}) {
    _datePayment = datePayment;
    _typePayment = typePayment;
    _description = description;
    _value = value;
    _debtor = debtor;
  }

  Invoice.fromJson(dynamic json) {
    _id = json['id'];
    _datePayment = json['datePayment'];
    _typePayment = json['typePayment'];
    _description = json['description'];
    _value = json['value'];
    _debtor = json['debtor'];
  }

  int? get id => _id;

  DateTime get datePayment => _datePayment;

  String get typePayment => _typePayment;

  String get description => _description;

  num get value => _value;

  int get debtor => _debtor;

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

  set datePayment(DateTime value) {
    _datePayment = value;
  }

  set debtor(int value) {
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
