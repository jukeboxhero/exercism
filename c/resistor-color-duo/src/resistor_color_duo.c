#include "resistor_color_duo.h"
#include <stdio.h>

static resistor_band_t bands[] = {
  BLACK, BROWN, RED, ORANGE, YELLOW,
  GREEN, BLUE, VIOLET, GREY, WHITE
};

int color_code(resistor_band_t colors[]) {
  int color1 = colors[0];
  int color2 = colors[1];
  return (bands[color1] * 10) + bands[color2];
}
