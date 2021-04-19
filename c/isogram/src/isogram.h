#ifndef ISOGRAM_H
#define ISOGRAM_H

#include <stdio.h>
#include <stdbool.h>
#include <string.h>
#include <ctype.h>
#include <regex.h>

bool is_isogram(const char phrase[]);

bool letter_found(char *letter);

#endif
