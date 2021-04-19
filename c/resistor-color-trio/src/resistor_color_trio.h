#ifndef RESISTOR_COLOR_TRIO_H
#define RESISTOR_COLOR_TRIO_H

typedef enum {
  BLACK, BROWN, RED, ORANGE, YELLOW,
  GREEN, BLUE, VIOLET, GREY, WHITE
} resistor_band_t;

typedef enum {
  OHMS,
  KILOOHMS
} units;

typedef struct Resistors {
  int value;
  units unit;
} resistor_value_t;

resistor_value_t color_code(resistor_band_t colors[]);

int trailingZeroCount(int n);

#endif
