package main

import (
	"fmt"
	"log"
	"os"
	"path/filepath"
	"strconv"
	"strings"
)

type set struct {
	first int
	last  int
}

func main() {
	fileName := "2025_02.txt"

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
	// parse input
	trimmed := strings.TrimSpace(input)
	parts := strings.Split(trimmed, ",")
	sets := make([]set, 0, len(parts))
	var invalid []int
	sum := 0

	// build sets
	for _, part := range parts {
		bounds := strings.Split(part, "-")
		first, err := strconv.Atoi(bounds[0])
		if err != nil {
			log.Fatalf("error converting first bound to int: %v", err)
		}
		last, err := strconv.Atoi(bounds[1])
		if err != nil {
			log.Fatalf("error converting last bound to int: %v", err)
		}

		sets = append(sets, set{first: first, last: last})
	}

	// check each number in each set
	for _, s := range sets {
		r := rangeFromSet(s)
		for _, n := range r {
			if isRepeated(n) {
				invalid = append(invalid, n)
			}
		}
	}

	// sum invalid numbers
	for _, n := range invalid {
		sum += n
	}

	return sum
}
func processPart2(input string) int {
	// parse input
	trimmed := strings.TrimSpace(input)
	parts := strings.Split(trimmed, ",")
	sets := make([]set, 0, len(parts))
	var invalid []int
	sum := 0

	// build sets
	for _, part := range parts {
		bounds := strings.Split(part, "-")
		first, err := strconv.Atoi(bounds[0])
		if err != nil {
			log.Fatalf("error converting first bound to int: %v", err)
		}
		last, err := strconv.Atoi(bounds[1])
		if err != nil {
			log.Fatalf("error converting last bound to int: %v", err)
		}

		sets = append(sets, set{first: first, last: last})
	}

	// check each number in each set
	for _, s := range sets {
		r := rangeFromSet(s)
		for _, n := range r {
			if isMultiRepeat(n) {
				invalid = append(invalid, n)
			}
		}
	}

	// sum invalid numbers
	for _, n := range invalid {
		sum += n
	}

	return sum
}

func isRepeated(n int) bool {
	// make sure its positive
	if n < 0 {
		n = -n
	}

	// can it be split in half?
	s := strconv.Itoa(n)
	if len(s)%2 != 0 {
		return false
	}

	// split and check halves
	mid := len(s) / 2
	firstHalf := s[:mid]
	lastHalf := s[mid:]

	return firstHalf == lastHalf
}

func rangeFromSet(s set) []int {
	out := make([]int, 0, s.last-s.first+1)
	for i := s.first; i <= s.last; i++ {
		out = append(out, i)
	}
	return out
}

func isMultiRepeat(n int) bool {
	//
	if n < 0 {
		n = -n
	}

	// convert to string & check length
	s := strconv.Itoa(n)
	l := len(s)
	if l < 2 {
		return false
	}

	// get divisible substring lengths up to half length
	for subLen := 1; subLen <= l/2; subLen++ {
		if l%subLen != 0 {
			continue
		}
		k := l / subLen
		if k < 2 {
			continue
		}
		// check if repeating substring matches the entire string
		prefix := s[:subLen]
		if strings.Repeat(prefix, k) == s {
			return true
		}
	}
	return false
}
