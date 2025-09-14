import "package:cobudget/src/transaction_splits/transaction_split.dart";
import "package:cobudget/src/transaction_splits/transaction_split_mapper.dart";

abstract class TransactionSplitStub {
  static const userId = "user_id_stub";
  static const percentage = 0.23;

  static final stub = TransactionSplit(userId, percentage);
  static final stub2 = TransactionSplit("user_id_2_stub", 0.77);

  static final List<TransactionSplit> splits = [stub, stub2];

  static final Map<String, dynamic> map = TransactionSplitMapper.toMap(stub);
  static final Map<String, dynamic> map2 = TransactionSplitMapper.toMap(stub2);

  static final List<Map<String, dynamic>> maps = [map, map2];
}
