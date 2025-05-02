enum TagKind { transaction, user }

sealed class Tag {
  Tag({required this.id, required this.name, required this.kind})
      : assert(id.isNotEmpty),
        assert(name.isNotEmpty);

  final String id;
  final String name;
  final TagKind kind;
}

class ParentTag implements Tag {
  ParentTag({required this.id, required this.name, required this.kind})
      : assert(id.isNotEmpty),
        assert(name.isNotEmpty);

  final String id;
  final String name;
  final TagKind kind;
}

class SubTag implements Tag {
  SubTag({required this.id, required this.name, required this.parentId, required this.kind})
      : assert(id.isNotEmpty),
        assert(name.isNotEmpty),
        assert(parentId.isNotEmpty);

  final String id;
  final String name;
  final String parentId;
  final TagKind kind;
}
