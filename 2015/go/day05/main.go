package main

import (
	"fmt"
	"log"
	"os"
	"path/filepath"
)

func main() {
	// get filepath
	dir, err := filepath.Abs(".")
	if err != nil {
		log.Fatalf("error opening file: %v", err)
	}
	filepath := filepath.Join(dir, "input.txt")

	// read file
	input, err := os.ReadFile(filepath)
	if err != nil {
		log.Fatalf("error reading file: %v", err)
	}

	part1Result := processPart1(string(input))
	fmt.Printf("Part 1: %v\n", part1Result)

	part2Result := processPart2(string(input))
	fmt.Printf("Part 2: %v\n", part2Result)
}
