import "package:cobudget/src/budgets/budget.dart";
import "package:cobudget/src/budgets/create_budget.dart";
import "package:cobudget/src/database/sqlite_database.dart";
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

  test("returned budget should have positive localId", () async {
    final unsaved = Budget.unsaved(
      date: DateTime(2025, 9, 14),
      name: "unsaved-name",
      amount: 1500.97,
      tags: [],
    );
    expect(unsaved.localId, isNegative);

    await createBudget(unsaved, sqliteDatabase.db);
    expect(unsaved.localId, isPositive);
  });
}
