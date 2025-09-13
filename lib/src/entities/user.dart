import "package:cobudget/src/utils/utils.dart";

class User {
  User({required this.localId, required this.externalId, required this.name, required this.email})
    : assert(localId != 0),
      assert(externalId.isNotEmpty),
      assert(name.isNotEmpty),
      assert(email.isNotEmpty),
      assert(email.contains("@")),
      assert(email.contains("."));

  /// Create a new [User] with a random generated nano id locally
  /// This user must be synced with remote later
  factory User.withRandomId({required String name, required String email}) {
    return User(
      localId: -DateTime.now().millisecondsSinceEpoch,
      externalId: generateNanoId(),
      name: name,
      email: email,
    );
  }

  final int localId;
  final String externalId;
  final String name;
  final String email;
}
