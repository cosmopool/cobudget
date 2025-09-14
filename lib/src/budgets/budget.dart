import "package:cobudget/src/tags/tag.dart";
import "package:cobudget/src/utils/aliases.dart";

class Budget {
  Budget({
    required this.localId,
    required this.month,
    required this.year,
    required this.amount,
    required this.name,
    required this.tags,
    this.externalId,
    this.image,
  }) : assert(
         localId != 0,
         "should be a negative integer (not saved) or positive (saved in database)",
       ),
       assert(externalId == null || externalId.isNotEmpty),
       assert(name.isNotEmpty),
       assert(amount > 0),
       assert(month > 0),
       assert(year > 0);

  /// Creates a new [Budget] object that is not yet persisted to the database.
  ///
  /// Generates a unique negative [localId] to serve as a temporary identifier.
  /// This ID ensures the object can be used before being saved and assigned
  /// a permanent, positive ID by the database.
  factory Budget.unsaved({
    required DateTime date,
    required double amount,
    required String name,
    required List<Tag> tags,
    ExternalId? externalId,
    String? image,
    DateTime? createdAt,
  }) {
    final DateTime creation = createdAt ?? DateTime.now();
    final int temporaryId = -creation.millisecondsSinceEpoch;
    assert(temporaryId < 0);

    return Budget(
      localId: temporaryId,
      externalId: externalId,
      year: date.year,
      month: date.month,
      amount: amount,
      name: name,
      image: image,
      tags: tags,
    );
  }

  factory Budget.withDateTime({
    required int localId,
    required String externalId,
    required DateTime date,
    required double amount,
    required String name,
    required List<Tag> tags,
    String? image,
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

  LocalId localId;
  final ExternalId? externalId;
  final int month;
  final int year;
  final double amount;
  final String name;
  final String? image;
  final List<Tag> tags;

  DateTime get date => DateTime(year, month);

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
      kTags: budget.tags.map(Tag.toMap).toList(),
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
      tags: List<Tag>.from(tagsMap.map(Tag.fromMap)),
    );
  }
}
