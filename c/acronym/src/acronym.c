#include "acronym.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

char * abbreviate(const char *phrase) {
   if (phrase == NULL || phrase[0] == '\0') return NULL;
  char pch[100];

  strcpy(pch, phrase);
  // char *words[100];
  int n = 0;
  int i = 0;

  char *words[100];
  char *acronym = (char*) malloc(n*sizeof(char));
  //printf("%s\n", pch);

  words[i] = strtok(pch, " ");

  // words[0] = "";
  while (words[i] != NULL) {
    //printf("%c\n", words[i][0]);
    acronym[i] = toupper(words[i][0]);
    words[++i] = strtok(NULL, " ");
    //*words = strtok(pch, " ");
    // words[n] = pch;
    n++;
  }

  return acronym;
}
