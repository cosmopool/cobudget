import "dart:math";

final random = Random.secure();

/// Modification of [package:nanoid] from https://github.com/pd4d10/nanoid-dart
String generateNanoId([int size = 21]) {
  const alphabet = "ModuleSymbhasOwnPr-0123456789ABCDEFGHNRVfgctiUvz_KqYTJkLxpZXIjQW";
  final id = StringBuffer();
  while (0 < size--) {
    id.write(alphabet[random.nextInt(alphabet.length)]);
  }
  return id.toString();
}
