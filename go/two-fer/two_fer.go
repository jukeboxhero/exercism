/*
	Package twofer returns a string with the following message including a given name:
	"One for X, one for me."
	If no name is given, we default to the following message:
	"One for you, one for me."
*/
package twofer

import (
	"fmt"
)

func ShareWith(name string) string {
	if !(len(name) > 0) {
		name = "you"
	}
	return fmt.Sprintf("One for %s, one for me.", name)
}
