enum TagKind { transaction, user }

class Tag {
  Tag(this.parentId, {required this.id, required this.name, required this.kind})
    : assert(id.isNotEmpty),
      assert(name.isNotEmpty),
      assert(parentId == null || parentId.isNotEmpty);

  final String id;
  final String name;
  final String? parentId;
  final TagKind kind;

  bool get isSubTag => parentId != null;
}
