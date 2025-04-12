part of "payment_method.dart";

class CreditCard extends PaymentMethod {
  CreditCard({
    required super.id,
    required super.name,
    required super.owner,
    required this.dueDate,
    required this.closingDate,
  });

  final DateTime dueDate;
  final DateTime closingDate;
}
