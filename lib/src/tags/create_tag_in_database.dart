import "package:cobudget/src/tags/tag.dart";
import "package:sqlite3/sqlite3.dart";

/// Persists a new [Tag] entity to the local SQLite database.
///
/// This function is intended for creating new, transient tags. The provided [tag]
/// must be unsaved, and must not reference itself as a parent.
///
/// Usage:
/// ```dart
/// final newTag = Tag.unsaved(name: "Groceries", kind: TagKind.transaction);
/// print(newTag.localId); // null
/// await createTagInDatabase(newTag, database);
/// print("Tag created with ID: ${newTag.localId}");
/// ```
Future<void> createTagInDatabase(Tag tag, Database db) async {
  // to prevent creating duplicates
  assert(tag.isUnsaved, "must be a new unsaved entity");
  assert(tag.localId != tag.parentId, "cannot reference it self");

  // now we transform tag data to a valid format so it can be saved in database
  // sqlite needs strings surrounded by double quotes in a insert query
  final nameToSave = '"${tag.name}"';
  assert(tag.name.isNotEmpty);

  final int kindToSave = tag.kind.index;

  // TODO: deal with parentId for sub tags
  final sql =
      """
      INSERT INTO tags (
        name,
        kind
      ) VALUES (
        $nameToSave,
        $kindToSave
      )
    """;

  db.execute(sql);
  tag.localId = db.lastInsertRowId;
}
