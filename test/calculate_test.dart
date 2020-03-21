import 'package:bmi_app/calculate.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  Calculate calculate;

  setUp((){
    calculate = Calculate();
  });

  test("check setter", (){
    calculate.index = 12;
    expect(12, calculate.index);
    calculate.status = "any status";
    expect("any status", calculate.status);
  });

  test("check setter no args", (){
    expect(12, calculate.index);
    expect("any status", calculate.status);
  });
}