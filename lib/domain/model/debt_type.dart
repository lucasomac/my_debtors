import 'dart:ffi';

enum DebtType { credit, debit }

extension MenuTypeExtension on DebtType {
  String getName() {
    return switch (this) {
      DebtType.credit => "Crédito",
      DebtType.debit => "Débito",
    };
  }

  String getTypeCode() {
    return switch (this) {
      DebtType.credit => "C",
      DebtType.debit => "D",
    };
  }
}
