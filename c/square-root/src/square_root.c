#include "square_root.h"

unsigned long square_root(int n) {
  unsigned long op = n;
  unsigned long res = 0;
  unsigned long bit = 1uL << 30;

  while (bit > op) {
    bit >>= 2;
  }

  while (bit != 0) {
    if (op >= res + bit) {
      op = op - (res + bit);
      res = res +  2 * bit;
    }
    res >>= 1;
    bit >>= 2;
  }
  return res;
}
