import "dart:convert";

import "package:cobudget/src/budgets/budget.dart";
import "package:cobudget/src/tags/tag.dart";
import "package:flutter_test/flutter_test.dart";

void main() {
  const localId = 1;
  const externalId = "budget id";
  const month = 1;
  const year = 1990;
  const amount = 109.99;
  const name = "name";
  const image = "image";
  final tag = Tag(localId: 1, externalId: "id", name: "tag_name", kind: TagKind.transaction);
  final tags = [tag];
  final List<Map<String, dynamic>> tagsMap = tags.map(Tag.toMap).toList();

  final budgetStub = Budget(
    localId: localId,
    externalId: externalId,
    month: month,
    year: year,
    amount: amount,
    name: name,
    image: image,
    tags: tags,
  );

  final String tagsK = json.encode(tagsMap);
  final budgetJsonStub =
      '''{"${Budget.kLocalId}":$localId,"${Budget.kExternalId}":"$externalId","${Budget.kMonth}":$month,"${Budget.kYear}":$year,"${Budget.kAmount}":$amount,"${Budget.kName}":"$name","${Budget.kImage}":"$image","${Budget.kTags}":$tagsK}''';

  test("toMap should return a map with same values as entity", () {
    final Map<String, dynamic> map = Budget.toMap(budgetStub);

    expect(map[Budget.kLocalId], localId);
    expect(map[Budget.kExternalId], externalId);
    expect(map[Budget.kMonth], month);
    expect(map[Budget.kYear], year);
    expect(map[Budget.kAmount], amount);
    expect(map[Budget.kName], name);
    expect(map[Budget.kImage], image);
    expect(map[Budget.kTags], [Tag.toMap(tag)]);
  });

  test("fromMap should return an entity with same values", () {
    final Map<String, dynamic> map = {
      Budget.kLocalId: localId,
      Budget.kExternalId: externalId,
      Budget.kMonth: month,
      Budget.kYear: year,
      Budget.kAmount: amount,
      Budget.kName: name,
      Budget.kImage: image,
      Budget.kTags: tagsMap,
    };

    final Budget budget = Budget.fromMap(map);

    expect(budget.externalId, map[Budget.kExternalId]);
    expect(budget.month, map[Budget.kMonth]);
    expect(budget.year, map[Budget.kYear]);
    expect(budget.amount, map[Budget.kAmount]);
    expect(budget.name, map[Budget.kName]);
    expect(budget.image, map[Budget.kImage]);
    expect(tagsMap, map[Budget.kTags]);
  });

  test("toJson should return a json with same values as entity", () {
    final String jsonStr = json.encode(Budget.toMap(budgetStub));

    expect(jsonStr, equals(budgetJsonStub));
  });

  test("fromJson should return an entity with same values", () {
    final Budget budget = Budget.fromMap(json.decode(budgetJsonStub));

    expect(budget.externalId, budgetStub.externalId);
    expect(budget.month, budgetStub.month);
    expect(budget.year, budgetStub.year);
    expect(budget.amount, budgetStub.amount);
    expect(budget.name, budgetStub.name);
    expect(budget.image, budgetStub.image);
    expect(budget.tags.first.externalId, tag.externalId);
    expect(budget.tags.first.name, tag.name);
    expect(budget.tags.first.kind, tag.kind);
    expect(budget.tags.first.parentId, tag.parentId);
  });
}
