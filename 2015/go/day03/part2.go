package main

import "strconv"

func processPart2(input string) int {
	x, y := 0, 0
	rX, rY := 0, 0
	visited := make(map[string]bool)
	visited["0,0"] = true
	santa := true

	for _, c := range input {
		if santa {

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
		} else {
			switch c {
			case '^':
				rY++
			case 'v':
				rY--
			case '>':
				rX++
			case '<':
				rX--
			}
			visited[strconv.Itoa(rX)+","+strconv.Itoa(rY)] = true
		}
		santa = !santa
	}
	return len(visited)
}
