import "dart:convert";

import "package:cobudget/src/entities/user.dart";

abstract class UserMapper {
  static Map<String, String> toMap(User user) {
    return {"id": user.id, "name": user.name, "email": user.email};
  }

  static User fromMap(Map<String, dynamic> map) {
    return User(
      id: map["id"] as String,
      name: map["name"] as String,
      email: map["email"] as String,
    );
  }

  static String toJson(User user) {
    return json.encode(toMap(user));
  }

  static User fromJson(String source) {
    return fromMap(json.decode(source) as Map<String, dynamic>);
  }
}
