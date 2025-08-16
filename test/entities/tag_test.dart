import "package:cobudget/src/entities/tag.dart";
import "package:flutter_test/flutter_test.dart";

void main() {
  /// to prevent breaking tags and messing up with database results
  test("tag declaration should remain in an specific order", () {
    expect(TagKind.values[0], TagKind.transaction);
    expect(TagKind.values[1], TagKind.user);
  });
}
