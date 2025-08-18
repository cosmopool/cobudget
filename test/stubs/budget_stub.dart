import "package:cobudget/src/entities/budget.dart";
import "package:cobudget/src/mappers/budget_mapper.dart";

import "tag_stub.dart";

abstract class BudgetStub {
  static const month = 1;
  static const year = 1990;
  static const amount = 109.99;
  static const name = "budget name";
  static const image = "budget image";

  static final stub = Budget(
    month: month,
    year: year,
    amount: amount,
    name: name,
    image: image,
    tags: TagStub.tags,
  );

  static final Map<String, dynamic> map = BudgetMapper.toMap(stub);
}
