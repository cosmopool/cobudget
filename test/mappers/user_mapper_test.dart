import "package:cobudget/src/entities/user.dart";
import "package:cobudget/src/mappers/user_mapper.dart";
import "package:flutter_test/flutter_test.dart";

void main() {
  const localId = 1;
  const externalId = "id_stub";
  const name = "name_stub";
  const email = "email_stub";

  test("toMap should return a map with same values as entity", () {
    final user = User(localId: localId, externalId: externalId, name: name, email: email);

    final Map<String, dynamic> map = UserMapper.toMap(user);

    expect(map["id"], externalId);
    expect(map["name"], name);
    expect(map["email"], email);
  });

  test("fromMap should return an entity with same values", () {
    final map = {"id": externalId, "name": name, "email": email};

    final User user = UserMapper.fromMap(map);

    expect(user.externalId, map["id"]);
    expect(user.name, map["name"]);
    expect(user.email, map["email"]);
  });

  test("toJson should return a json with same values as entity", () {
    final user = User(localId: localId, externalId: externalId, name: name, email: email);

    final String json = UserMapper.toJson(user);

    expect(json, equals('{"id":"$externalId","name":"$name","email":"$email"}'));
  });

  test("fromJson should return an entity with same values", () {
    const json = '{"id":"$externalId","name":"$name","email":"$email"}';

    final User user = UserMapper.fromJson(json);

    expect(user.externalId, externalId);
    expect(user.name, name);
    expect(user.email, email);
  });
}
