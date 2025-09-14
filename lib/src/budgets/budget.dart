import "package:cobudget/src/tags/tag.dart";
import "package:cobudget/src/tags/tag_mapper.dart";

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

  // ------------------------------------------------------
  // mapper
  // ------------------------------------------------------

  static const kLocalId = "local_id";
  static const kExternalId = "external_id";
  static const kMonth = "month";
  static const kYear = "year";
  static const kAmount = "amount";
  static const kName = "name";
  static const kImage = "image";
  static const kTags = "tags";

  static Map<String, dynamic> toMap(Budget budget) {
    return <String, dynamic>{
      kLocalId: budget.localId,
      kExternalId: budget.externalId,
      kMonth: budget.month,
      kYear: budget.year,
      kAmount: budget.amount,
      kName: budget.name,
      kImage: budget.image,
      kTags: budget.tags.map(TagMapper.toMap).toList(),
    };
  }

  static Budget fromMap(Map<String, dynamic> map) {
    final List<Map<String, dynamic>> tagsMap = (map[kTags] as List<dynamic>)
        .cast<Map<String, dynamic>>();

    return Budget(
      localId: map[kLocalId] as int,
      externalId: map[kExternalId] as String,
      month: int.parse(map[kMonth].toString()),
      year: int.parse(map[kYear].toString()),
      amount: double.parse(map[kAmount].toString()),
      name: map[kName] as String,
      image: map[kImage] as String,
      tags: List<Tag>.from(tagsMap.map(TagMapper.fromMap)),
    );
  }
}
