import 'dart:async';
import 'package:test/test.dart';

Future main() async {
  group("Test for group 1", () {
    group("Test for subgroup 1", subgroupTest1);
    group("Test for subgroup 2", subgroupTest2);
  });
}

void subgroupTest1(){
  test("unitTest1", () => …);
}
