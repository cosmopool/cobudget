import "package:cobudget/src/database/sqlite_database.dart";
import "package:cobudget/src/transactions/create_transaction.dart";
import "package:cobudget/src/transactions/transaction.dart";
import "package:flutter_test/flutter_test.dart";
import "package:sqlite3/sqlite3.dart";

import "../budgets/budget_stub.dart";
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

  test("returned transaction should have positive localId", () async {
    final unsaved = Transaction.unsaved(
      name: "unsaved-name",
      value: 15.97,
      tags: [],
      splits: [],
      budget: BudgetStub.stub.localId,
    );
    expect(unsaved.localId, isNegative);

    await createTransaction(unsaved, sqliteDatabase.db);
    expect(unsaved.localId, isPositive);
  });
}
