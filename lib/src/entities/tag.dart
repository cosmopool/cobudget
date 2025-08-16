/*
  TODO: create test to make sure all new [TagKind] are inserted in db
  if we alter the order of the enumerators everything breaks. the parser of db
  results will be all messed up. 
*/
enum TagKind { transaction, user }

class Tag {
  Tag({required this.id, required this.name, required this.kind, this.parentId})
    : assert(id.isNotEmpty),
      assert(name.isNotEmpty);

  final String id;
  final String name;
  final TagKind kind;
  final String? parentId;
}
