import "package:cobudget/src/entities/tag.dart";
import "package:cobudget/src/mappers/tag_mapper.dart";

abstract class TagStub {
  static const id = "id";
  static const name = "tag_name";
  static const TagKind kind = TagKind.transaction;

  static final stub = Tag(id: id, name: name, kind: kind);

  static final List<Tag> tags = [stub];

  static final Map<String, dynamic> map = TagMapper.toMap(stub);

  static final List<Map<String, dynamic>> maps = [map];
}
