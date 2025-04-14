class Category {
  Category({
    required this.id,
    required this.name,
    required this.percentage,
    required this.parentId,
    required this.uses,
  });

  final String id;
  final String name;
  final double percentage;
  final String? parentId;
  int uses;

  bool get inUse => uses > 0;
}
