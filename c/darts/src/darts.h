#ifndef DARTS_H
#define DARTS_H

#include <inttypes.h>

typedef struct coordinate {
  float x;
  float y;
} coordinate_t;

uint8_t score(coordinate_t landing_position);

#endif
