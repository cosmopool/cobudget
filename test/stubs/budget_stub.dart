import "package:cobudget/src/entities/budget.dart";
import "package:cobudget/src/mappers/budget_mapper.dart";

import "tag_stub.dart";

abstract class BudgetStub {
  static const localId = 1;
  static const externalId = "budget id";
  static const month = 1;
  static const year = 1990;
  static const amount = 109.99;
  static const name = "budget name";
  static const image = "budget image";

  static final stub = Budget(
    localId: localId,
    externalId: externalId,
    month: month,
    year: year,
    amount: amount,
    name: name,
    image: image,
    tags: TagStub.tags,
  );

  static final Map<String, dynamic> map = BudgetMapper.toMap(stub);
}
