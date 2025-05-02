import "tag.dart";

class Budget {
  Budget({
    required this.month,
    required this.year,
    required this.amount,
    required this.name,
    required this.image,
    required this.tag,
  })  : assert(name.isNotEmpty),
        assert(amount > 0),
        assert(month > 0),
        assert(year > 0);

  factory Budget.withDateTime({
    required DateTime date,
    required double amount,
    required String name,
    required String image,
    required ParentTag tag,
  }) =>
      Budget(
        year: date.year,
        month: date.month,
        amount: amount,
        name: name,
        image: image,
        tag: tag,
      );

  final int month;
  final int year;
  final double amount;
  final String name;
  final String image;
  final Tag tag;

  DateTime get date => DateTime(year, month);
}
