package main

import (
	"fmt"
	"strconv"
	"strings"
)

type loci struct {
	x int
	y int
}
type instruction struct {
	do        string
	locations []loci
}

func part1(input string) int {
	lines := strings.Split(input, "\n")
	var grid [1000][1000]bool

	// for each line
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
				grid[place.x][place.y] = true
			case "off":
				grid[place.x][place.y] = false
			case "toggle":
				grid[place.x][place.y] = !grid[place.x][place.y]
			}
		}
	}

	count := 0
	for i := 0; i < 1000; i++ {
		for j := 0; j < 1000; j++ {
			if grid[i][j] {
				count++
			}
		}
	}

	return count
}

func parse(input string) instruction {
	line := strings.Split(input, " ")
	var parsed instruction

	// 'do' should be on, off, or toggle
	// strip do from instructions
	switch line[0] {
	case "toggle":
		parsed.do = "toggle"
		line = line[1:]
	case "turn":
		parsed.do = line[1]
		line = line[2:]
	default:
		fmt.Println("Error: invalid instruction")
	}

	start := locate(line[0])
	end := locate(line[2])
	parsed.locations = makeList(start, end)

	return parsed
}

func locate(s string) loci {
	nums := strings.Split(s, ",")
	num1, err := strconv.Atoi(nums[0])
	if err != nil {
		fmt.Println(err)
	}
	num2, err := strconv.Atoi(nums[1])
	if err != nil {
		fmt.Println(err)
	}
	return loci{x: num1, y: num2}
}

func makeList(start, end loci) []loci {
	var list []loci
	for x := start.x; x <= end.x; x++ {
		for y := start.y; y <= end.y; y++ {
			list = append(list, loci{x: x, y: y})
		}
	}
	return list
}
