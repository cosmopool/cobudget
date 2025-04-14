class Budget {
  Budget({
    required this.month,
    required this.year,
    required this.limit,
    required this.name,
    required this.image,
  }) : assert(name.isNotEmpty);

  factory Budget.withDateTime({
    required DateTime date,
    required double amount,
    required String name,
    required String image,
  }) => Budget(year: date.year, month: date.month, limit: amount, name: name, image: image);

  final int month;
  final int year;
  final double limit;
  final String name;
  final String image;

  DateTime get date => DateTime(year, month);
}
