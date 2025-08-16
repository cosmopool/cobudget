import "package:cobudget/src/utils/utils.dart";

class User {
  User({required this.id, required this.name, required this.email});

  /// Create a new [User] with a random generated nano id locally
  /// This user must be synced with remote later
  factory User.withRandomId({required String name, required String email}) {
    return User(id: generateNanoId(), name: name, email: email);
  }

  final String id;
  final String name;
  final String email;
}
