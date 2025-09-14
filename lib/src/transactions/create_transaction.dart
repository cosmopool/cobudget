import "package:cobudget/src/transactions/transaction.dart";
import "package:cobudget/src/utils/aliases.dart";
import "package:sqlite3/sqlite3.dart";

Future<void> createTransaction(Transaction transaction, Database db) async {
  // to prevent creating duplicates
  assert(transaction.isUnsaved, "must be a new unsaved transaction");
  assert(transaction.isUnsynced, "must be a new unsynced & unsaved transaction");

  // now we transform transaction data to a valid format so it can be saved in database
  // sqlite needs strings surrounded by double quotes in a insert query
  final nameToSave = '"${transaction.name}"';
  assert(transaction.name.isNotEmpty);

  String? descriptionToSave;
  if (transaction.description != null) descriptionToSave = '"$descriptionToSave"';

  final LocalId budgetIdToSave = transaction.budget;
  assert(budgetIdToSave > 0, "this budget must be saved before saving this transaction");

  final int valueToSave = (transaction.value * 100).toInt();
  assert(
    valueToSave.toString() == transaction.value.toString().replaceFirst(".", ""),
    "value is saved in database as an integer by removing the decimal place",
  );

  final int createdAtToSave = transaction.createdAt.millisecondsSinceEpoch;
  assert(createdAtToSave > 0);

  final sql =
      """
      INSERT INTO transactions (
        name,
        description,
        budget_id,
        value,
        created_at
      ) VALUES (
        $nameToSave,
        $descriptionToSave,
        $budgetIdToSave,
        $valueToSave,
        $createdAtToSave
      )
    """;

  db.execute(sql);
  transaction.localId = db.lastInsertRowId;
}
