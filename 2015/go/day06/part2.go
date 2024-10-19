package main

import (
	"strings"
)

func part2(input string) int {
	lines := strings.Split(input, "\n")
	var intGrid [1000][1000]int

	for _, line := range lines {
		trimmedLine := strings.TrimSpace(line)
		if trimmedLine == "" {
			continue
		}
		current := parse(trimmedLine)

		// for each location in parsed list
		for _, place := range current.locations {
			switch current.do {
			case "on":
				intGrid[place.x][place.y]++
			case "off":
				intGrid[place.x][place.y]--
				if intGrid[place.x][place.y] < 0 {
					intGrid[place.x][place.y] = 0
				}
			case "toggle":
				intGrid[place.x][place.y] += 2
			}
		}
	}

	brightness := 0
	for i := 0; i < 1000; i++ {
		for j := 0; j < 1000; j++ {
			brightness += intGrid[i][j]
		}
	}

	return brightness
}
