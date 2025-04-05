sealed class Category {
  Category({required this.id, required this.name});

  final String id;
  final String name;
}

class SubCategory implements Category {
  SubCategory({required this.parent, required this.id, required this.name});

  final Category parent;

  @override
  final String id;

  @override
  final String name;
}
