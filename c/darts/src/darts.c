#include "darts.h"
#include <stdio.h>
#include <math.h>

uint8_t score(coordinate_t landing_position) {
  double distance = sqrt(pow(landing_position.x, 2) + pow(landing_position.y, 2));

  if (distance > 10) {
    return 0;
  } else if ( distance > 5 && distance <= 10 ){
    return 1;
  } else if ( distance > 1 && distance <= 5) {
    return 5;
  } else {
    return 10;
  }
}
