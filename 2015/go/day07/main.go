package main

import (
	"fmt"
	"log"
	"os"
	"path/filepath"
)

func main() {
	// get dir
	dir, err := filepath.Abs(".")
	if err != nil {
		log.Fatalf("Failed to get directory: %v\n", err)
	}
	filePath := filepath.Join(dir, "input.txt")

	input, err := os.ReadFile(filePath)
	if err != nil {
		log.Fatalf("Failed to read file: %v\n", err)
	}

	result1 := part1(string(input))
	fmt.Printf("Part 1: %v\n", result1)

	result2 := part2(string(input), result1)
	fmt.Printf("Part 2: %v\n", result2)
}
