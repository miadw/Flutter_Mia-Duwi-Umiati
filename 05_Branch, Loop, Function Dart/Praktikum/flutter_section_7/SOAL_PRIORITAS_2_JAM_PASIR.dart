import 'dart:io';

void main() {
  int i, j, k, n = 10;

  for (i = n; i >= 1; i--) {
    for (j = 1; j <= n - i; j++) {
      stdout.write(" ");
    }
    for (k = 1; k <= 2 * i - 1; k++) {
      stdout.write("*");
    }
    stdout.writeln("");
  }
  for (i = 1; i <= n; i++) {
    for (j = 1; j <= n - i; j++) {
      stdout.write(" ");
    }
    for (k = 1; k <= 2 * i - 1; k++) {
      stdout.write("*");
    }
    stdout.writeln("");
  }
}