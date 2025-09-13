import "package:cobudget/src/entities/tag.dart";

class Budget {
  Budget({
    required this.localId,
    required this.externalId,
    required this.month,
    required this.year,
    required this.amount,
    required this.name,
    required this.image,
    required this.tags,
  }) : assert(name.isNotEmpty),
       assert(amount > 0),
       assert(month > 0),
       assert(year > 0);

  factory Budget.withDateTime({
    required int localId,
    required String externalId,
    required DateTime date,
    required double amount,
    required String name,
    required String image,
    required List<Tag> tags,
  }) => Budget(
    localId: localId,
    externalId: externalId,
    year: date.year,
    month: date.month,
    amount: amount,
    name: name,
    image: image,
    tags: tags,
  );

  final int localId;
  final String externalId;
  final int month;
  final int year;
  final double amount;
  final String name;
  final String image;
  final List<Tag> tags;

  DateTime get date => DateTime(year, month);
}
