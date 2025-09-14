import "dart:convert";

import "package:cobudget/src/tags/tag.dart";
import "package:cobudget/src/utils/aliases.dart";

abstract class TagMapper {
  static Map<String, dynamic> toMap(Tag tag) {
    final map = <String, dynamic>{
      "id": tag.externalId,
      "name": tag.name,
      "kind": tag.kind.index,
      "parent_id": tag.parentId,
    };

    return map;
  }

  static Tag fromMap(Map<String, dynamic> map) {
    final int kindIndex = map["kind"];
    final TagKind kind = TagKind.values[kindIndex];
    final LocalId localId = map["local_id"];
    final ExternalId externalId = map["external_id"];
    final String name = map["name"];
    final String? parentId = map["parent_id"];

    return Tag(
      localId: localId,
      externalId: externalId,
      name: name,
      kind: kind,
      parentId: parentId,
    );
  }

  static String toJson(Tag subTag) => json.encode(toMap(subTag));

  static Tag fromJson(String source) {
    return fromMap(json.decode(source) as Map<String, dynamic>);
  }
}
