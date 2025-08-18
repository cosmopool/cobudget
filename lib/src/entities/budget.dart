import "package:cobudget/src/entities/tag.dart";

class Budget {
  Budget({
    required this.id,
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
    required String id,
    required DateTime date,
    required double amount,
    required String name,
    required String image,
    required List<Tag> tags,
  }) => Budget(
    id: id,
    year: date.year,
    month: date.month,
    amount: amount,
    name: name,
    image: image,
    tags: tags,
  );

  final String id;
  final int month;
  final int year;
  final double amount;
  final String name;
  final String image;
  final List<Tag> tags;

  DateTime get date => DateTime(year, month);
}
