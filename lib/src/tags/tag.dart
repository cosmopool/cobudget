/*
  TODO: create test to make sure all new [TagKind] are inserted in db
  if we alter the order of the enumerators everything breaks. the parser of db
  results will be all messed up. 
*/
import "package:cobudget/src/utils/aliases.dart";

enum TagKind { transaction, user }

class Tag {
  Tag({
    required this.localId,
    required this.name,
    required this.kind,
    this.externalId,
    this.parentId,
  }) : assert(
         localId != 0,
         "should be a negative integer (not saved) or positive (saved in database)",
       ),
       assert(externalId == null || externalId.isNotEmpty),
       assert(name.isNotEmpty);

  /// Creates a new [Tag] object that is not yet persisted to the database.
  ///
  /// Generates a unique negative [localId] to serve as a temporary identifier.
  /// This ID ensures the object can be used before being saved and assigned
  /// a permanent, positive ID by the database.
  factory Tag.unsaved({
    required String name,
    required TagKind kind,
    ExternalId? externalId,
    LocalId? parentId,
    DateTime? createdAt,
  }) {
    final DateTime creation = createdAt ?? DateTime.now();
    final int temporaryId = -creation.millisecondsSinceEpoch;
    assert(temporaryId < 0);

    return Tag(
      localId: temporaryId,
      externalId: externalId,
      name: name,
      kind: kind,
      parentId: parentId,
    );
  }

  LocalId localId;
  final ExternalId? externalId;
  final String name;
  final TagKind kind;
  final LocalId? parentId;

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
  static const kName = "name";
  static const kKind = "kind";
  static const kParentId = "parent_id";

  static Map<String, dynamic> toMap(Tag tag) {
    final map = <String, dynamic>{
      kLocalId: tag.localId,
      kExternalId: tag.externalId,
      kName: tag.name,
      kKind: tag.kind.index,
      kParentId: tag.parentId,
    };

    return map;
  }

  static Tag fromMap(Map<String, dynamic> map) {
    final int kindIndex = map[kKind];
    final TagKind kind = TagKind.values[kindIndex];
    final LocalId localId = map[kLocalId];
    final ExternalId externalId = map[kExternalId];
    final String name = map[kName];
    final LocalId? parentId = map[kParentId];

    return Tag(
      localId: localId,
      externalId: externalId,
      name: name,
      kind: kind,
      parentId: parentId,
    );
  }
}
