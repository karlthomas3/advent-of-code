package main

import (
	"fmt"
	"log"
	"os"
	"path/filepath"
	"strconv"
	"strings"
)

type Instr struct {
	Dir string
	Num int
}

func main() {
	// get directory for current file
	dir, err := filepath.Abs(filepath.Dir("."))
	if err != nil {
		log.Fatalf("error getting directory: %v", err)
	}
	filePath := filepath.Join(dir, "..", "..", "inputs", "2025_01.txt")

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
	parts := strings.Split(strings.TrimSpace(input), "\n")
	instructions := make([]Instr, 0, len(parts))

	for _, part := range parts {
		dir := string(part[0])
		num, err := strconv.Atoi(part[1:])
		if err != nil {
			log.Fatalf("invalid number: %v", err)
		}
		instructions = append(instructions, Instr{Dir: dir, Num: num})
	}

	pos := 50
	count := 0
	for _, instr := range instructions {
		if instr.Dir == "L" {
			pos = (pos - instr.Num) % 100
		} else if instr.Dir == "R" {
			pos = (pos + instr.Num) % 100
		}
		if pos == 0 {
			count++
		}
	}

	return count
}
func processPart2(input string) int {
	parts := strings.Split(strings.TrimSpace(input), "\n")
	instructions := make([]Instr, 0, len(parts))

	for _, part := range parts {
		dir := string(part[0])
		num, err := strconv.Atoi(part[1:])
		if err != nil {
			log.Fatalf("invalid number: %v", err)
		}
		instructions = append(instructions, Instr{Dir: dir, Num: num})
	}

	pos := 50
	count := 0

	for _, instr := range instructions {
		var newPos int
		var crossings int

		if instr.Dir == "L" {
			newPos = pos - instr.Num
			crossings = floorDiv(pos-1, 100) - floorDiv(newPos-1, 100)
		} else if instr.Dir == "R" {
			newPos = pos + instr.Num
			crossings = floorDiv(newPos, 100) - floorDiv(pos, 100)
		}

		count += crossings
		pos = ((newPos % 100) + 100) % 100
	}

	return count
}
func floorDiv(a, b int) int {
	q := a / b
	r := a % b
	if (r < 0 && b > 0) || (r > 0 && b < 0) {
		q--
	}
	return q
}
