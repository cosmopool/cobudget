import "package:cobudget/src/entities/user.dart";

abstract class UserStub {
  static const localId = 1;
  static const externalId = "id";
  static const name = "name";
  static const email = "email";

  static final User stub = User(localId: localId, externalId: externalId, name: name, email: email);
}
