import "dart:convert";

import "package:cobudget/src/tags/tag.dart";
import "package:flutter_test/flutter_test.dart";

void main() {
  const localId = 1;
  const externalId = "id_stub";
  const name = "name_stub";
  const TagKind kind = TagKind.user;
  final int index = TagKind.values.indexOf(kind);

  test("toMap should return a map with same values as entity", () {
    final tag = Tag(
      localId: localId,
      externalId: externalId,
      name: name,
      kind: kind,
      parentId: null,
    );

    final Map<String, dynamic> map = Tag.toMap(tag);

    expect(map[Tag.kLocalId], localId);
    expect(map[Tag.kExternalId], externalId);
    expect(map[Tag.kName], name);
    expect(map[Tag.kKind], index);
  });

  test("fromMap should return an entity with same values", () {
    final Map<String, dynamic> map = {
      Tag.kLocalId: localId,
      Tag.kExternalId: externalId,
      Tag.kName: name,
      Tag.kKind: index,
    };

    final Tag tag = Tag.fromMap(map);

    expect(tag.localId, map[Tag.kLocalId]);
    expect(tag.externalId, map[Tag.kExternalId]);
    expect(tag.name, map[Tag.kName]);
    expect(tag.kind, kind);
  });

  test("toJson should return a json with same values as entity", () {
    final tag = Tag(localId: localId, externalId: externalId, name: name, kind: kind);

    final String jsonStr = json.encode(Tag.toMap(tag));

    expect(
      jsonStr,
      equals(
        '{"local_id":$localId,"external_id":"$externalId","name":"$name","kind":$index,"parent_id":null}',
      ),
    );
  });

  test("fromJson should return an entity with same values", () {
    final jsonStr =
        '{"local_id":$localId,"external_id":"$externalId","name":"$name","kind":$index,"parent_id":null}';

    final Tag tag = Tag.fromMap(json.decode(jsonStr));

    expect(tag.externalId, externalId);
    expect(tag.name, name);
    expect(tag.kind, kind);
  });
}
