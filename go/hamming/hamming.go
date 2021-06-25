package hamming

import "errors"

func Distance(a, b string) (int, error) {
  distance := 0

  if len(a) != len(b) {
    return 0, errors.New("hello")
  }

  for i, _ := range a {
    if a[i] != b[i] {
      distance++
    }
  }
  return distance, nil
}
