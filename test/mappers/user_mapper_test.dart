import "package:cobudget/src/entities/user.dart";
import "package:cobudget/src/mappers/user_mapper.dart";
import "package:flutter_test/flutter_test.dart";

void main() {
  const id = "id_stub";
  const name = "name_stub";
  const email = "email_stub";

  test("toMap should return a map with same values as entity", () {
    final user = User(id: id, name: name, email: email);

    final Map<String, String> map = UserMapper.toMap(user);

    expect(map["id"], id);
    expect(map["name"], name);
    expect(map["email"], email);
  });

  test("fromMap should return an entity with same values", () {
    final map = {"id": id, "name": name, "email": email};

    final User user = UserMapper.fromMap(map);

    expect(user.id, map["id"]);
    expect(user.name, map["name"]);
    expect(user.email, map["email"]);
  });

  test("toJson should return a json with same values as entity", () {
    final user = User(id: id, name: name, email: email);

    final String json = UserMapper.toJson(user);

    expect(json, equals('{"id":"$id","name":"$name","email":"$email"}'));
  });

  test("fromJson should return an entity with same values", () {
    const json = '{"id":"$id","name":"$name","email":"$email"}';

    final User user = UserMapper.fromJson(json);

    expect(user.id, id);
    expect(user.name, name);
    expect(user.email, email);
  });
}
