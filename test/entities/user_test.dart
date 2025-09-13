import "package:cobudget/src/entities/user.dart";
import "package:flutter_test/flutter_test.dart";

void main() {
  test("create a user with random nanoid", () {
    final User user = User.withRandomId(name: "name", email: "email");

    expect(user.externalId, isNotEmpty);
    expect(user.externalId.length, 21);
  });

  test("create multiple users should generate different ids", () {
    final User user1 = User.withRandomId(name: "name", email: "email");
    final User user2 = User.withRandomId(name: "name", email: "email");
    final User user3 = User.withRandomId(name: "name", email: "email");

    expect(user1.externalId, isNot(user2.externalId));
    expect(user2.externalId, isNot(user3.externalId));
    expect(user3.externalId, isNot(user1.externalId));
  });
}
