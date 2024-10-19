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
		log.Fatalf("Error getting directory: %v", err)
	}
	filePath := filepath.Join(dir, "input.txt")

	// read file into memory
	input, err := os.ReadFile(filePath)
	if err != nil {
		log.Fatalf("Error reading file: %v", err)
	}

	result1 := part1(string(input))
	fmt.Printf("Part 1: %v\n", result1)

	result2 := part2(string(input))
	fmt.Printf("Part 2: %v\n", result2)
}
