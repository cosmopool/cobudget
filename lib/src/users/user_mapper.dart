import "dart:convert";

import "package:cobudget/src/users/user.dart";

abstract class UserMapper {
  static Map<String, dynamic> toMap(User user) {
    return {
      "localId": user.localId,
      "externalId": user.externalId,
      "name": user.name,
      "email": user.email,
    };
  }

  static User fromMap(Map<String, dynamic> map) {
    return User(
      localId: map["localId"] as int,
      externalId: map["externalId"] as String,
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
