import "dart:convert";

import "package:cobudget/src/entities/tag.dart";
import "package:cobudget/src/entities/transaction.dart";
import "package:cobudget/src/entities/transaction_split.dart";
import "package:cobudget/src/mappers/budget_mapper.dart";
import "package:cobudget/src/mappers/tag_mapper.dart";
import "package:cobudget/src/mappers/transaction_split_mapper.dart";

abstract class TransactionMapper {
  static const kId = "id";
  static const kName = "name";
  static const kDescription = "description";
  static const kBudget = "budget";
  static const kValue = "value";
  static const kCreatedAt = "createdAt";
  static const kTags = "tags";
  static const kSplits = "splits";

  static Map<String, dynamic> toMap(Transaction transaction) {
    return <String, dynamic>{
      kId: transaction.id,
      kName: transaction.name,
      kDescription: transaction.description,
      kBudget: BudgetMapper.toMap(transaction.budget),
      kValue: transaction.value,
      kCreatedAt: transaction.createdAt.millisecondsSinceEpoch,
      kTags: transaction.tags.map(TagMapper.toMap).toList(),
      kSplits: transaction.splits.map(TransactionSplitMapper.toMap).toList(),
    };
  }

  static Transaction fromMap(Map<String, dynamic> map) {
    final List<Tag> tagsMap = (map[kTags] as List<Map<String, dynamic>>)
        .map<Tag>(TagMapper.fromMap)
        .toList();

    final List<TransactionSplit> splitsMap =
        (map[kSplits] as List<Map<String, dynamic>>)
            .map<TransactionSplit>(TransactionSplitMapper.fromMap)
            .toList();

    return Transaction(
      id: map[kId] as String,
      name: map[kName] as String,
      description: map[kDescription] as String?,
      budget: BudgetMapper.fromMap(map[kBudget] as Map<String, dynamic>),
      value: double.parse(map[kValue].toString()),
      createdAt: DateTime.fromMillisecondsSinceEpoch(map[kCreatedAt] as int),
      tags: tagsMap,
      splits: splitsMap,
    );
  }

  static String toJson(Transaction transaction) =>
      json.encode(toMap(transaction));

  static Transaction fromJson(String source) {
    return fromMap(json.decode(source) as Map<String, dynamic>);
  }
}
