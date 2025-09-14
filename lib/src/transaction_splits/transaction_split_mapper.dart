import "dart:convert";

import "package:cobudget/src/transaction_splits/transaction_split.dart";

abstract class TransactionSplitMapper {
  static Map<String, dynamic> toMap(TransactionSplit slipt) {
    final map = <String, dynamic>{
      "user_id": slipt.userId,
      "percentage": slipt.percentage,
    };

    return map;
  }

  static TransactionSplit fromMap(Map<String, dynamic> map) {
    final String userId = map["user_id"];
    final double percentage = map["percentage"];
    return TransactionSplit(userId, percentage);
  }

  static String toJson(TransactionSplit split) => json.encode(toMap(split));

  static TransactionSplit fromJson(String source) {
    return fromMap(json.decode(source) as Map<String, dynamic>);
  }
}
