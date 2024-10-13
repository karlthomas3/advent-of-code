package main

import "strconv"

func processPart1(input string) int {
	x, y := 0, 0
	visited := make(map[string]bool)
	visited["0,0"] = true

	for _, c := range input {
		switch c {
		case '^':
			y++
		case 'v':
			y--
		case '>':
			x++
		case '<':
			x--
		}

		visited[strconv.Itoa(x)+","+strconv.Itoa(y)] = true
	}
	return len(visited)
}
