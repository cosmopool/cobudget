import "package:cobudget/src/entities/user.dart";

part "credit_card.dart";
part "account.dart";

sealed class PaymentMethod {
  PaymentMethod({required this.id, required this.owner, required this.name});

  final String id;
  final User owner;
  final String name;
}
