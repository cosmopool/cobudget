import "package:cobudget/src/entities/tag.dart";
import "package:cobudget/src/entities/transaction_split.dart";
import "package:cobudget/src/utils/aliases.dart";

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
         splits.isEmpty || splits.map((e) => e.percentage).reduce((a, b) => a + b) == 1,
         "splits percentage must sum up to 1 (100% of a transaction value)",
       ),
       assert(description == null || description.isNotEmpty),
       assert(
         localId != 0,
         "should be a negative integer (not saved) or positive (saved in database)",
       );

  // Factory method for creating new unsaved transactions
  factory Transaction.unsaved({
    required String name,
    required double value,
    required List<Tag> tags,
    required List<TransactionSplit> splits,
    LocalId? budget,
    String? description,
    DateTime? createdAt,
  }) {
    final DateTime creation = createdAt ?? DateTime.now();
    final int temporaryId = -creation.millisecondsSinceEpoch;
    assert(temporaryId < 0);

    return Transaction(
      localId: temporaryId,
      name: name,
      description: description,
      budget: budget,
      value: value,
      createdAt: creation,
      tags: tags,
      splits: splits,
    );
  }

  LocalId localId;
  final String? externalId;
  final String name;
  final String? description;
  final LocalId? budget;
  final double value;
  final DateTime createdAt;
  final List<Tag> tags;
  final List<TransactionSplit> splits;

  bool get isSaved => localId > 0;
  bool get isUnsaved => !isSaved;

  bool get isSynced => externalId != null;
  bool get isUnsynced => !isSynced;
}
