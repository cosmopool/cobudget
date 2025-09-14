import "package:cobudget/src/budgets/budget.dart";
import "package:sqlite3/sqlite3.dart";

Future<void> createBudget(Budget budget, Database db) async {
  // to prevent creating duplicates
  assert(budget.isUnsaved, "must be a new unsaved entity");
  assert(budget.isUnsynced, "must be a new unsynced & unsaved entity");

  // now we transform budget data to a valid format so it can be saved in database
  // sqlite needs strings surrounded by double quotes in a insert query
  final nameToSave = '"${budget.name}"';
  assert(budget.name.isNotEmpty);

  final int amountToSave = (budget.amount * 100).toInt();
  assert(
    amountToSave.toString() == budget.amount.toString().replaceFirst(".", ""),
    "amount is saved in database as an integer by removing the decimal place",
  );

  String? imageToSave;
  if (budget.image != null) imageToSave = '"$imageToSave"';

  final sql =
      """
      INSERT INTO budgets (
        month,
        year,
        amount,
        name,
        image
      ) VALUES (
        ${budget.month},
        ${budget.year},
        $amountToSave,
        $nameToSave,
        $imageToSave
      )
    """;

  db.execute(sql);
  // TODO: make INSERT and LAST_INSERTED_ROW on the same transaction to prevent returning wrong id
  budget.localId = db.lastInsertRowId;
}
