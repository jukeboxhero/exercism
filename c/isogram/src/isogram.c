#include "isogram.h"

bool is_isogram(const char phrase[]) {
  if (!phrase) {
    return false;
  }
  char *letter;

  for (letter = (char *)phrase; *letter; letter++) {
    if (*letter == '-' || *letter == ' ') {
      continue;
    }

    if (letter_found(letter)) {
      return false;
    }
  }
  return true;
}

bool letter_found(char *letter) {
  char lower = tolower(*letter);
  char upper = toupper(*letter);
  return strchr(letter + 1, lower) || strchr(letter + 1, upper);
}
