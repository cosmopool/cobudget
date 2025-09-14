import "package:cobudget/src/database/sqlite_database.dart";
import "package:cobudget/src/tags/create_tag_in_database.dart";
import "package:cobudget/src/tags/tag.dart";
import "package:flutter_test/flutter_test.dart";
import "package:sqlite3/sqlite3.dart";

import "../users/user_stub.dart";

void main() {
  late Database database;
  late SqliteDatabase sqliteDatabase;

  setUp(() {
    database = sqlite3.openInMemory();
    sqliteDatabase = SqliteDatabase(database);
    sqliteDatabase.init();
    database.execute(
      'INSERT INTO users VALUES (${UserStub.localId}, "${UserStub.name}", "${UserStub.email}")',
    );
  });

  tearDown(() {
    sqliteDatabase.dispose();
  });

  test("returned tag should have positive localId", () async {
    final unsaved = Tag.unsaved(name: "unsaved-name", kind: TagKind.transaction);
    expect(unsaved.localId, isNegative);

    await createTagInDatabase(unsaved, sqliteDatabase.db);
    expect(unsaved.localId, isPositive);
  });
}
