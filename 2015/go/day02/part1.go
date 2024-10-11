package main

import (
	"strconv"
	"strings"
)

func processPart1(input string) int {
	lines := strings.Split(input, "\n")

	total := 0
	for _, line := range lines {
		sides := strings.Split(line, "x")

		l, _ := strconv.Atoi(sides[0])
		w, _ := strconv.Atoi(sides[1])
		h, _ := strconv.Atoi(sides[2])

		lw := l * w
		wh := w * h
		hl := h * l
		extra := min(lw, wh, hl)

		total += 2*lw + 2*wh + 2*hl + extra
	}
	return total
}
