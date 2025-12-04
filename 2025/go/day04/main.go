package main

import (
	"fmt"
	"log"
	"os"
	"path/filepath"
	"strings"
)

func main() {
	fileName := "2025_04.txt"

	// get directory for current file
	dir, err := filepath.Abs(filepath.Dir("."))
	if err != nil {
		log.Fatalf("error getting directory: %v", err)
	}
	filePath := filepath.Join(dir, "..", "..", "inputs", fileName)

	// read the input file
	input, err := os.ReadFile(filePath)
	if err != nil {
		log.Fatalf("error reading file: %v", err)
	}

	// Process Part 1 and Part 2
	part1Result := processPart1(string(input))
	fmt.Printf("part 1: %v\n", part1Result)

	part2Result := processPart2(string(input))
	fmt.Printf("part 2: %v\n", part2Result)
}

func processPart1(input string) int {
	count := 0
	// build grid
	grid := buildGrid(input)

	// iterate over grid and count movable @
	for y := range len(grid) {
		for x := 0; x < len(grid[0]); x++ {
			if grid[y][x] == '@' {
				if isMovable(x, y, grid) {
					count++
				}
			}
		}
	}

	return count
}
func processPart2(input string) int {
	count := 0
	// build grid
	grid := buildGrid(input)

	for {
		// keep track of changes
		changes := 0
		// iterate over grid
		for y := range len(grid) {
			for x := 0; x < len(grid[0]); x++ {
				if grid[y][x] == '@' {
					if isMovable(x, y, grid) {
						grid[y][x] = '.'
						count++
						changes++
					}
				}
			}
		}
		// if no changes, break
		if changes == 0 {
			break
		}
	}

	return count
}

func buildGrid(input string) [][]byte {
	// split input into lines
	lines := strings.Split(strings.TrimSpace(input), "\n")
	// break each line into slice of bytes
	grid := make([][]byte, len(lines))
	for i, ln := range lines {
		grid[i] = []byte(ln)
	}

	return grid
}

func getNeighbors(x, y int, grid [][]byte) [][]int {
	var neighbors [][]int
	directions := [][]int{
		{0, -1},  // up
		{0, 1},   // down
		{-1, 0},  // left
		{1, 0},   // right
		{-1, -1}, // up-left
		{1, -1},  // up-right
		{-1, 1},  // down-left
		{1, 1},   // down-right
	}

	for _, dir := range directions {
		nx, ny := x+dir[0], y+dir[1]
		if nx >= 0 && nx < len(grid[0]) && ny >= 0 && ny < len(grid) {
			neighbors = append(neighbors, []int{nx, ny})
		}
	}
	return neighbors
}

func isMovable(x, y int, grid [][]byte) bool {
	neighbors := getNeighbors(x, y, grid)
	count := 0
	for _, n := range neighbors {
		nx, ny := n[0], n[1]
		if grid[ny][nx] == '@' {
			count++
		}
	}
	return count < 4
}
