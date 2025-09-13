import "package:cobudget/src/entities/budget.dart";
import "package:cobudget/src/entities/tag.dart";
import "package:cobudget/src/entities/transaction_split.dart";

class Transaction {
  Transaction({
    required this.localId,
    required this.name,
    required this.description,
    required this.budget,
    required this.value,
    required this.createdAt,
    required this.tags,
    required this.splits,
    this.externalId,
  }) : assert(
         splits.map((e) => e.percentage).reduce((a, b) => a + b) == 1,
         "splits percentage must sum up to 1 (100% of a transaction value)",
       ),
       assert(description == null || description.isNotEmpty),
       assert(localId > 0);

  final int localId;
  final String? externalId;
  final String name;
  final String? description;
  final Budget budget;
  final double value;
  final DateTime createdAt;
  final List<Tag> tags;
  final List<TransactionSplit> splits;

  bool get isSynced => externalId != null;
  bool get isUnsynced => !isSynced;
}
