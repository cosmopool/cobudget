import "package:cobudget/src/entities/user.dart";

abstract class UserStub {
  static const id = "id";
  static const name = "name";
  static const email = "email";

  static final User stub = User(id: id, name: name, email: email);
}
