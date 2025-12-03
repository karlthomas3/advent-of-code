package main

import (
	"fmt"
	"log"
	"os"
	"path/filepath"
)

func main() {
	fileName := "REPLACE ME"

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

	return 42
}
func processPart2(input string) int {

	return 42
}
