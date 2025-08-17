import "package:cobudget/src/entities/transaction_split.dart";
import "package:cobudget/src/mappers/transaction_split_mapper.dart";
import "package:flutter_test/flutter_test.dart";

void main() {
  const userId = "user_id_stub";
  const percentage = 0.23;

  test("toMap should return a map with same values as entity", () {
    final tag = TransactionSplit(userId, percentage);

    final Map<String, dynamic> map = TransactionSplitMapper.toMap(tag);

    expect(map["user_id"], userId);
    expect(map["percentage"], percentage);
  });

  test("fromMap should return an entity with same values", () {
    final Map<String, dynamic> map = {
      "user_id": userId,
      "percentage": percentage,
    };

    final TransactionSplit transaction = TransactionSplitMapper.fromMap(map);

    expect(transaction.userId, map["user_id"]);
    expect(transaction.percentage, map["percentage"]);
  });

  test("toJson should return a json with same values as entity", () {
    final tag = TransactionSplit(userId, percentage);

    final String json = TransactionSplitMapper.toJson(tag);

    expect(json, equals('{"user_id":"$userId","percentage":$percentage}'));
  });

  test("fromJson should return an entity with same values", () {
    const json = '{"user_id":"$userId","percentage":$percentage}';

    final TransactionSplit transaction = TransactionSplitMapper.fromJson(json);

    expect(transaction.userId, userId);
    expect(transaction.percentage, percentage);
  });
}
