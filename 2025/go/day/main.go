package main

import (
	"fmt"
	"log"
	"os"
	"path/filepath"
)

func main() {
	// get directory for current file
	dir, err := filepath.Abs(filepath.Dir("."))
	if err != nil {
		log.Fatalf("error getting directory: %v", err)
	}
	filePath := filepath.Join(dir, "..", "..", "2025_01.txt")

	// read the input file
	input, err := os.ReadFile(filePath)
	if err != nil {
		log.Fatalf("error reading file: %v", err)
	}

	part1Result := processPart1(string(input))
	fmt.Printf("part 1: %v\n", part1Result)

	part2Result := processPart2(string(input))
	fmt.Printf("part 2: %v\n", part2Result)
}

func processPart1(input string) int {

	return 42
}
func processPart2(input string) int {

	return 666
}
