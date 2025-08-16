import "package:cobudget/src/entities/tag.dart";
import "package:cobudget/src/mappers/tag_mapper.dart";
import "package:flutter_test/flutter_test.dart";

void main() {
  const id = "id_stub";
  const name = "name_stub";
  const TagKind kind = TagKind.user;
  final int index = TagKind.values.indexOf(kind);

  test("toMap should return a map with same values as entity", () {
    final tag = Tag(id: id, name: name, kind: kind, parentId: null);

    final Map<String, dynamic> map = TagMapper.toMap(tag);

    expect(map["id"], id);
    expect(map["name"], name);
    expect(map["kind"], index);
  });

  test("fromMap should return an entity with same values", () {
    final Map<String, dynamic> map = {"id": id, "name": name, "kind": index};

    final Tag tag = TagMapper.fromMap(map);

    expect(tag.id, map["id"]);
    expect(tag.name, map["name"]);
    expect(tag.kind, kind);
  });

  test("toJson should return a json with same values as entity", () {
    final tag = Tag(id: id, name: name, kind: kind);

    final String json = TagMapper.toJson(tag);

    expect(
      json,
      equals('{"id":"$id","name":"$name","kind":$index,"parent_id":null}'),
    );
  });

  test("fromJson should return an entity with same values", () {
    final json = '{"id":"$id","name":"$name","kind":$index,"parent_id":null}';

    final Tag tag = TagMapper.fromJson(json);

    expect(tag.id, id);
    expect(tag.name, name);
    expect(tag.kind, kind);
  });
}
