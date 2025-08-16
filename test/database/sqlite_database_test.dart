import "package:cobudget/src/database/sqlite_database.dart";
import "package:flutter_test/flutter_test.dart";

void main() {
  late SqliteDatabase sqliteDatabase;

  setUp(() {
    sqliteDatabase = SqliteDatabase();
  });

  test("tables should be created successfully", () {
    sqliteDatabase.init();
  });

  test("init method should initialize the database instance", () {
    sqliteDatabase.init();
    expect(sqliteDatabase.db, isNotNull);
  });

  test("dispose method should dispose the database instance", () {
    sqliteDatabase.init();
    expect(sqliteDatabase.db, isNotNull);

    sqliteDatabase.dispose();
    expect(() => sqliteDatabase.db.select(""), throwsA(isA<StateError>()));
  });
}
