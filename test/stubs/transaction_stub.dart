import "package:cobudget/src/transaction/transaction.dart";

import "budget_stub.dart";
import "tag_stub.dart";
import "transaction_split_stub.dart";

abstract class TransactionStub {
  static const localId = 1;
  static const externalId = "transaction id";
  static const name = "transaction name";
  static const description = "transaction description";
  static const value = 108.28;
  static final createdAt = DateTime(1990, 4, 8);

  static final stubSynced = Transaction(
    localId: localId,
    externalId: externalId,
    name: name,
    description: description,
    budget: BudgetStub.stub,
    value: value,
    createdAt: createdAt,
    tags: [TagStub.stub],
    splits: [TransactionSplitStub.stub, TransactionSplitStub.stub2],
  );

  static final stubUnsynced = Transaction(
    localId: 2,
    name: name,
    description: description,
    budget: BudgetStub.stub,
    value: value,
    createdAt: createdAt,
    tags: [TagStub.stub],
    splits: [TransactionSplitStub.stub, TransactionSplitStub.stub2],
  );
}
