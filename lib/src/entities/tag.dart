enum TagKind { transaction, user }

sealed class Tag {
  Tag({required this.id, required this.name, required this.kind})
    : assert(id.isNotEmpty),
      assert(name.isNotEmpty);

  final String id;
  final String name;
  final TagKind kind;
}

class ParentTag extends Tag {
  ParentTag({required super.id, required super.name, required super.kind});
}

class SubTag extends Tag {
  SubTag({
    required super.id,
    required super.name,
    required this.parentId,
    required super.kind,
  }) : assert(parentId.isNotEmpty);

  final String parentId;
}
