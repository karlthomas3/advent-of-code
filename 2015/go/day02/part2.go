package main

import (
	"sort"
	"strconv"
	"strings"
)

func processPart2(input string) int {
	lines := strings.Split(input, "\n")

	total := 0
	for _, line := range lines {
		sides := strings.Split(line, "x")

		l, _ := strconv.Atoi(sides[0])
		w, _ := strconv.Atoi(sides[1])
		h, _ := strconv.Atoi(sides[2])

		sortedSides := []int{l, w, h}
		sort.Ints(sortedSides)

		ribbon := 2*sortedSides[0] + 2*sortedSides[1]
		bow := l * w * h

		total += ribbon + bow
	}
	return total
}
