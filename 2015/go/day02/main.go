package main

import (
	"fmt"
	"log"
	"os"
	"path/filepath"
	"strings"
)

func main() {
	// get directory for current file
	dir, err := filepath.Abs(filepath.Dir("."))
	if err != nil {
		log.Fatalf("error getting directory: %v", err)
	}
	filePath := filepath.Join(dir, "input.txt")

	// read the input file
	input, err := os.ReadFile(filePath)
	if err != nil {
		log.Fatalf("error reading file: %v", err)
	}
	trimmedInput := strings.TrimSpace(string(input))

	part1Result := processPart1(trimmedInput)
	fmt.Printf("part 1: %v\n", part1Result)

	part2Result := processPart2(trimmedInput)
	fmt.Printf("part 2: %v\n", part2Result)
}
