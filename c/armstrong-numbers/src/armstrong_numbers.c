#include "armstrong_numbers.h"
#include <stdio.h>
#include <math.h>

bool is_armstrong_number(int candidate) {
  int sum = 0;
  int iterator = candidate;

  while (iterator > 0) {
    int digit = iterator % 10;
    sum += pow(digit, intLength(candidate));
    iterator /= 10;
  }

  return sum == candidate;
}

int intLength(long long num) {
  return floor(log10(num) + 1);
}
