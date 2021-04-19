#include "hamming.h"

int compute(const char *lhs, const char *rhs) {
  int hamming_distance = 0;

  if (!lhs || !rhs || (strlen(lhs) != strlen(rhs)))
    return -1;

  for(int i=0; lhs[i]; i++) {
    if (lhs[i] != rhs[i]) {
      hamming_distance++;
    }
  }
  return hamming_distance;
}
