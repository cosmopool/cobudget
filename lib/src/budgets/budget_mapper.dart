import "dart:convert";

import "package:cobudget/src/budgets/budget.dart";
import "package:cobudget/src/tags/tag.dart";
import "package:cobudget/src/tags/tag_mapper.dart";

abstract class BudgetMapper {
  static const kLocalId = "localId";
  static const kExternalId = "externalId";
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

  static String toJson(Budget budget) => json.encode(toMap(budget));

  static Budget fromJson(String source) {
    return fromMap(json.decode(source) as Map<String, dynamic>);
  }
}
