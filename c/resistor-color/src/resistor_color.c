#include <stdio.h>
#include "resistor_color.h"

static resistor_band_t bands[] = {
  BLACK, BROWN, RED, ORANGE, YELLOW,
  GREEN, BLUE, VIOLET, GREY, WHITE
};

resistor_band_t color_code(resistor_band_t color) {
  return bands[color];
}

resistor_band_t* colors(void) {
  return bands;
}
