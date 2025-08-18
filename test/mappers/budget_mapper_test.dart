import "dart:convert";

import "package:cobudget/src/entities/budget.dart";
import "package:cobudget/src/entities/tag.dart";
import "package:cobudget/src/mappers/budget_mapper.dart";
import "package:cobudget/src/mappers/tag_mapper.dart";
import "package:flutter_test/flutter_test.dart";

void main() {
  const id = "budget id";
  const month = 1;
  const year = 1990;
  const amount = 109.99;
  const name = "name";
  const image = "image";
  final tag = Tag(id: "id", name: "tag_name", kind: TagKind.transaction);
  final tags = [tag];
  final List<Map<String, dynamic>> tagsMap = tags.map(TagMapper.toMap).toList();

  final budgetStub = Budget(
    id: id,
    month: month,
    year: year,
    amount: amount,
    name: name,
    image: image,
    tags: tags,
  );

  final String tagsK = json.encode(tagsMap);
  final budgetJsonStub =
      '''{"${BudgetMapper.kId}":"$id","${BudgetMapper.kMonth}":$month,"${BudgetMapper.kYear}":$year,"${BudgetMapper.kAmount}":$amount,"${BudgetMapper.kName}":"$name","${BudgetMapper.kImage}":"$image","${BudgetMapper.kTags}":$tagsK}''';

  test("toMap should return a map with same values as entity", () {
    final Map<String, dynamic> map = BudgetMapper.toMap(budgetStub);

    expect(map[BudgetMapper.kId], id);
    expect(map[BudgetMapper.kMonth], month);
    expect(map[BudgetMapper.kYear], year);
    expect(map[BudgetMapper.kAmount], amount);
    expect(map[BudgetMapper.kName], name);
    expect(map[BudgetMapper.kImage], image);
    expect(map[BudgetMapper.kTags], [TagMapper.toMap(tag)]);
  });

  test("fromMap should return an entity with same values", () {
    final Map<String, dynamic> map = {
      BudgetMapper.kId: id,
      BudgetMapper.kMonth: month,
      BudgetMapper.kYear: year,
      BudgetMapper.kAmount: amount,
      BudgetMapper.kName: name,
      BudgetMapper.kImage: image,
      BudgetMapper.kTags: tagsMap,
    };

    final Budget budget = BudgetMapper.fromMap(map);

    expect(budget.id, map[BudgetMapper.kId]);
    expect(budget.month, map[BudgetMapper.kMonth]);
    expect(budget.year, map[BudgetMapper.kYear]);
    expect(budget.amount, map[BudgetMapper.kAmount]);
    expect(budget.name, map[BudgetMapper.kName]);
    expect(budget.image, map[BudgetMapper.kImage]);
    expect(tagsMap, map[BudgetMapper.kTags]);
  });

  test("toJson should return a json with same values as entity", () {
    final String jsonStr = BudgetMapper.toJson(budgetStub);

    expect(jsonStr, equals(budgetJsonStub));
  });

  test("fromJson should return an entity with same values", () {
    final Budget budget = BudgetMapper.fromJson(budgetJsonStub);

    expect(budget.id, budgetStub.id);
    expect(budget.month, budgetStub.month);
    expect(budget.year, budgetStub.year);
    expect(budget.amount, budgetStub.amount);
    expect(budget.name, budgetStub.name);
    expect(budget.image, budgetStub.image);
    expect(budget.tags.first.id, tag.id);
    expect(budget.tags.first.name, tag.name);
    expect(budget.tags.first.kind, tag.kind);
    expect(budget.tags.first.parentId, tag.parentId);
  });
}
