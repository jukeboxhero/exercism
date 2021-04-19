#include "resistor_color_trio.h"
#include <stdio.h>
#include <string.h>
#include <math.h>

resistor_value_t resistor;

resistor_value_t color_code(resistor_band_t colors[]) {
  int color1 = colors[0];
  int color2 = colors[1];
  int color3 = colors[2];

  float factor_of_ten = pow(10, color3);

  int total_number = (color1 * 10 + color2) * factor_of_ten;
  int unit = 0;

  while(total_number > 999) {
    total_number = (total_number / 1000);
    unit++;
  }

  resistor.value = total_number;
  resistor.unit = unit;

  return resistor;
}
