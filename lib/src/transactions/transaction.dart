import "package:cobudget/src/tags/tag.dart";
import "package:cobudget/src/transaction_splits/transaction_split.dart";
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
       ),
       assert(
         budget != 0,
         "should be a negative integer (not saved) or positive (saved in database)",
       );

  // Factory method for creating new unsaved transactions
  factory Transaction.unsaved({
    required String name,
    required double value,
    required List<Tag> tags,
    required List<TransactionSplit> splits,
    required LocalId budget,
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
  final LocalId budget;
  final double value;
  final DateTime createdAt;
  final List<Tag> tags;
  final List<TransactionSplit> splits;


  /// Returns `true` if this entity has been persisted to the database.
  ///
  /// A positive `localId` indicates the entity has been saved and assigned
  /// a permanent identifier by the database.
  bool get isSaved => localId > 0;

  /// Returns `true` if this entity has not been persisted to the database yet.
  /// The entity exists only in memory.
  ///
  /// Unsaved entities typically have negative `localId` values used as
  /// temporary identifiers during creation.
  bool get isUnsaved => !isSaved;

  /// Returns `true` if this entity has been synchronized with the backend server.
  ///
  /// A non-null `externalId` indicates the backend has processed this entity
  /// and assigned it a permanent identifier in the remote system.
  bool get isSynced => externalId != null;

  /// Returns `true` if this entity has not been synchronized with the backend server yet.
  /// It exists only locally.
  ///
  /// Unsynchronized entities are on a queue waiting for syncronization.
  bool get isUnsynced => !isSynced;
}
