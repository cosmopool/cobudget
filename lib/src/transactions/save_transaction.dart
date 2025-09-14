import "package:cobudget/src/transactions/transaction.dart";
import "package:sqlite3/sqlite3.dart";

Future<void> saveTransaction(Transaction transaction, Database db) async {
  // we need to remove the decimal place of value so we can save in database
  final int value = (transaction.value * 100).toInt();
  assert(
    value.toString() == transaction.value.toString().replaceFirst(".", ""),
    "value is saved in database as an integer by removing the decimal place",
  );

  String? description;
  final hasDescription = transaction.description != null;
  if (hasDescription) description = '"${transaction.description}"';

  final sql =
      """
      INSERT INTO transactions (
        id,
        name,
        description,
        budget_id,
        value,
        created_at
      ) VALUES (
        ${transaction.localId},
        "${transaction.name}",
        $description,
        ${transaction.budget},
        $value,
        ${DateTime.now().millisecondsSinceEpoch}
      )
    """;

  db.execute(sql);
}
