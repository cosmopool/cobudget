import "dart:convert";

import "package:cobudget/src/tags/tag.dart";
import "package:cobudget/src/transaction_splits/transaction_split.dart";
import "package:cobudget/src/transaction_splits/transaction_split_mapper.dart";
import "package:cobudget/src/transactions/transaction.dart";
import "package:cobudget/src/utils/aliases.dart";

abstract class TransactionMapper {
  static const kLocalId = "local_id";
  static const kExternalId = "external_id";
  static const kName = "name";
  static const kDescription = "description";
  static const kBudget = "budget";
  static const kValue = "value";
  static const kCreatedAt = "created_at";
  static const kTags = "tags";
  static const kSplits = "splits";

  static Map<String, dynamic> toMap(Transaction transaction) {
    return <String, dynamic>{
      kLocalId: transaction.localId,
      if (transaction.externalId != null) kExternalId: transaction.externalId,
      kName: transaction.name,
      kDescription: transaction.description,
      kBudget: transaction.budget,
      kValue: transaction.value,
      kCreatedAt: transaction.createdAt.millisecondsSinceEpoch,
      kTags: transaction.tags.map(Tag.toMap).toList(),
      kSplits: transaction.splits.map(TransactionSplitMapper.toMap).toList(),
    };
  }

  static Transaction fromMap(Map<String, dynamic> map) {
    final List<Tag> tagsMap = (map[kTags] as List<Map<String, dynamic>>)
        .map<Tag>(Tag.fromMap)
        .toList();

    final List<TransactionSplit> splitsMap = (map[kSplits] as List<Map<String, dynamic>>)
        .map<TransactionSplit>(TransactionSplitMapper.fromMap)
        .toList();

    return Transaction(
      localId: map[kLocalId] as LocalId,
      externalId: map[kExternalId] as String,
      name: map[kName] as String,
      description: map[kDescription] as String?,
      budget: map[kBudget] as LocalId,
      value: double.parse(map[kValue].toString()),
      createdAt: DateTime.fromMillisecondsSinceEpoch(map[kCreatedAt] as int),
      tags: tagsMap,
      splits: splitsMap,
    );
  }

  static String toJson(Transaction transaction) => json.encode(toMap(transaction));

  static Transaction fromJson(String source) {
    return fromMap(json.decode(source) as Map<String, dynamic>);
  }
}
