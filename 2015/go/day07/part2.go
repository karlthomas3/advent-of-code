package main

import (
	"fmt"
	"strconv"
	"strings"
)

func part2(input string, a int) int {
	bSep := strings.Split(input, " -> b\n")
	if len(bSep) != 2 {
		fmt.Println("Error: invalid input format")
		return 0
	}

	// Replace the last element in the split string with the new value of 'a'
	splitString := strings.Split(bSep[0], "\n")
	if len(splitString) == 0 {
		fmt.Println("Error: invalid input format before '-> b'")
		return 0
	}
	clipped := strings.Join(splitString[:len(splitString)-1], "\n")
	fixed := fmt.Sprintf("%s -> b\n%s", strconv.Itoa(a), bSep[1])

	// Join the fixed string with the rest of the input
	joined := fmt.Sprintf("%s\n%s", clipped, fixed)
	// fmt.Println("Modified input for part1:", joined)

	return part1(joined)
}
