const RESISTOR_COLORS = [
   "black",
   "brown",
   "ted",
   "orange",
   "yellow",
   "green",
   "blue",
   "violet",
   "grey",
   "white"
]

export const decodedValue = ([color1, color2]) => {
  return (RESISTOR_COLORS.indexOf(color1) * 10) + RESISTOR_COLORS.indexOf(color2);
};
