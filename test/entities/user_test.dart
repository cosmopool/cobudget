import "package:cobudget/src/entities/user.dart";
import "package:flutter_test/flutter_test.dart";

void main() {
  test("create a user with random nanoid", () {
    final User user = User.withRandomId(name: "name", email: "email");

    expect(user.id, isNotEmpty);
    expect(user.id.length, 21);
  });

  test("create multiple users should generate different ids", () {
    final User user1 = User.withRandomId(name: "name", email: "email");
    final User user2 = User.withRandomId(name: "name", email: "email");
    final User user3 = User.withRandomId(name: "name", email: "email");

    expect(user1.id, isNot(user2.id));
    expect(user2.id, isNot(user3.id));
    expect(user3.id, isNot(user1.id));
  });
}
