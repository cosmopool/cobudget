import "package:sqlite3/sqlite3.dart";

class SqliteDatabase {
  SqliteDatabase([Database? database]) : db = database ?? sqlite3.open(name);

  final Database db;

  static String name = "cobudget_database";

  void init() {
    db.execute("""
    CREATE TABLE IF NOT EXISTS users (
      id INTEGER NOT NULL PRIMARY KEY,
      name TEXT NOT NULL,
      email TEXT NOT NULL
    );
  """);

    db.execute("""
    CREATE TABLE IF NOT EXISTS transactions (
      id INTEGER NOT NULL PRIMARY KEY,
      name TEXT NOT NULL,
      description TEXT,
      budget_id INTEGER NOT NULL,
      value INTEGER NOT NULL,
      created_at INTEGER NOT NULL,
      FOREIGN KEY(budget_id) REFERENCES budgets(id)
    );
  """);

    db.execute("""
    CREATE TABLE IF NOT EXISTS transactions_external_id (
      local_id INTEGER NOT NULL,
      external_id TEXT,
      FOREIGN KEY(local_id) REFERENCES transactions(id)
    );
  """);
    db.execute(
      """CREATE INDEX IF NOT EXISTS transactions_local_id_index ON transactions_external_id (local_id)""",
    );
    db.execute(
      """CREATE INDEX IF NOT EXISTS transactions_external_id_index ON transactions_external_id (external_id)""",
    );

    db.execute("""
    CREATE TABLE IF NOT EXISTS tags (
      id INTEGER NOT NULL PRIMARY KEY,
      name TEXT NOT NULL,
      kind INTEGER NOT NULL
    );
  """);

    db.execute("""
    CREATE TABLE IF NOT EXISTS tags_relationship (
      tag_id INTEGER NOT NULL,
      parent_tag_id INTEGER NOT NULL
    );
  """);

    db.execute("""
    CREATE TABLE IF NOT EXISTS budgets (
      id INTEGER NOT NULL PRIMARY KEY,
      month INTEGER NOT NULL,
      year INTEGER NOT NULL,
      amount INTEGER NOT NULL,
      name TEXT NOT NULL,
      image TEXT NOT NULL,
      tag_id INTEGER NOT NULL
    );
  """);

    db.execute("""
    CREATE TABLE IF NOT EXISTS entity_tags (
      entity_id INTEGER NOT NULL,
      tag_id INTEGER NOT NULL
    );
  """);

    db.execute(
      """CREATE INDEX IF NOT EXISTS entity_tags_index_1 ON entity_tags (entity_id)""",
    );
    db.execute(
      """CREATE INDEX IF NOT EXISTS entity_tags_index_2 ON entity_tags (tag_id)""",
    );

    db.execute("""
    CREATE TABLE IF NOT EXISTS payment_methods_kind (
      id INTEGER NOT NULL PRIMARY KEY,
      name TEXT NOT NULL
    );
  """);

    db.execute("""
    CREATE TABLE IF NOT EXISTS payment_methods (
      id INTEGER NOT NULL PRIMARY KEY,
      owner_id INTEGER NOT NULL,
      name TEXT NOT NULL,
      kind_id INTEGER NOT NULL,
      FOREIGN KEY(owner_id) REFERENCES users(id),
      FOREIGN KEY(kind_id) REFERENCES payment_methods_kind(id)
    );
  """);
  }

  void dispose() => db.dispose();
}
