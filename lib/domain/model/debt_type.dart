enum DebtType { credit, debit }

extension MenuTypeExtension on DebtType {
  String getName() {
    return switch (this) {
      DebtType.credit => "Crédito",
      DebtType.debit => "Débito",
    };
  }
}
