import "package:cobudget/src/tags/tag.dart";
import "package:cobudget/src/transaction_splits/transaction_split.dart";
import "package:cobudget/src/transactions/transaction.dart";
import "package:cobudget/src/transactions/transaction_mapper.dart";
import "package:flutter_test/flutter_test.dart";

import "../tags/tag_stub.dart";
import "../transaction_splits/transaction_split_stub.dart";
import "../transactions/transaction_stub.dart";

void main() {
  final Transaction stub = TransactionStub.stubSynced;

  test("toMap should return a map with same values as entity", () {
    final Map<String, dynamic> map = TransactionMapper.toMap(stub);

    expect(map[TransactionMapper.kLocalId], stub.localId);
    expect(map[TransactionMapper.kExternalId], stub.externalId);
    expect(map[TransactionMapper.kName], stub.name);
    expect(map[TransactionMapper.kDescription], stub.description);
    expect(map[TransactionMapper.kBudget], stub.budget);
    expect(map[TransactionMapper.kValue], stub.value);
    expect(map[TransactionMapper.kCreatedAt], stub.createdAt.millisecondsSinceEpoch);
    expect(map[TransactionMapper.kTags], TagStub.maps);
    expect(map[TransactionMapper.kSplits], TransactionSplitStub.maps);
  });

  test("fromMap should return an entity with same values", () {
    final Map<String, dynamic> map = {
      TransactionMapper.kLocalId: stub.localId,
      TransactionMapper.kExternalId: stub.externalId,
      TransactionMapper.kName: stub.name,
      TransactionMapper.kDescription: stub.description,
      TransactionMapper.kBudget: stub.localId,
      TransactionMapper.kValue: stub.value,
      TransactionMapper.kCreatedAt: stub.createdAt.millisecondsSinceEpoch,
      TransactionMapper.kTags: TagStub.maps,
      TransactionMapper.kSplits: TransactionSplitStub.maps,
    };

    final Transaction result = TransactionMapper.fromMap(map);

    expect(result.localId, stub.localId);
    expect(result.externalId, stub.externalId);
    expect(result.name, stub.name);
    expect(result.description, stub.description);
    expect(result.budget, stub.localId);
    expect(result.value, stub.value);
    expect(result.createdAt, stub.createdAt);
    expect(result.tags, isA<List<Tag>>());
    expect(result.splits, isA<List<TransactionSplit>>());
  });
}
