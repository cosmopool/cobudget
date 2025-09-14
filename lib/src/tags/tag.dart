/*
  TODO: create test to make sure all new [TagKind] are inserted in db
  if we alter the order of the enumerators everything breaks. the parser of db
  results will be all messed up. 
*/
import "package:cobudget/src/utils/aliases.dart";

enum TagKind { transaction, user }

class Tag {
  Tag({
    required this.localId,
    required this.externalId,
    required this.name,
    required this.kind,
    this.parentId,
  }) : assert(
         localId != 0,
         "should be a negative integer (not saved) or positive (saved in database)",
       ),
       assert(externalId.isNotEmpty),
       assert(name.isNotEmpty);

  final LocalId localId;
  final ExternalId externalId;
  final String name;
  final TagKind kind;
  final String? parentId;
}
