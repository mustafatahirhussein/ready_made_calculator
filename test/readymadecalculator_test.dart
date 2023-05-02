import 'package:flutter_test/flutter_test.dart';
import 'package:ready_made_calculator/ready_made_calculator.dart';

void main() {
  test('adds two no and returns the total sum', () {
    expect(Validate.addNo(1, 3), 4);
  });
}
