class Calculator {
  double add(double a, double b) {
    //either a or b is NaN, the result of the operation will also be NaN.
    if (a.isNaN || b.isNaN) {
      return double.nan;
    }
    return a + b;
  }

  double subtract(double a, double b) {
    return a - b;
  }

  double multiply(double a, double b) {
    return a * b;
  }

  double divide(double a, double b) {
    if (b == 0) {
      throw ArgumentError('Cannot divide by zero.');
    }
    return a / b;
  }
}
