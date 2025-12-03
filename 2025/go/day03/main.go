package main

import (
	"fmt"
	"log"
	"os"
	"path/filepath"
	"strings"
)

func main() {
	fileName := "2025_03.txt"

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
	var nums []int
	sum := 0
	lines := parseInput(input)

	// find biggest two-digit number in each line
	for _, line := range lines {
		nums = append(nums, biggestTwo(line))
	}

	// sum them up
	for _, n := range nums {
		sum += n
	}

	return sum
}
func processPart2(input string) int {
	var nums []int
	sum := 0
	lines := parseInput(input)

	// find biggest twelve-digit number in each line
	for _, line := range lines {
		nums = append(nums, biggestTwelve(line))
	}

	// sum them up
	for _, n := range nums {
		sum += n
	}

	return sum

}

func parseInput(input string) []string {
	return strings.Split(strings.TrimSpace(input), "\n")
}

func biggestTwo(str string) int {
	biggest := 0
	for x := 0; x < len(str)-1; x++ {
		// y will always be a digit after x
		for y := x + 1; y < len(str); y++ {
			// parse the digits as a two-digit number
			a := int(str[x] - '0')
			b := int(str[y] - '0')
			cur := 10*a + b
			if cur > biggest {
				biggest = cur
			}
		}
	}
	return biggest
}

func biggestTwelve(str string) int {
	const k = 12
	n := len(str)

	resDigits := make([]int, 0, k)
	start := 0
	remaining := k

	for remaining > 0 {
		maxIdx := start
		maxDigit := -1
		limit := n - remaining

		for i := start; i <= limit; i++ {
			d := int(str[i] - '0')
			if d > maxDigit {
				maxDigit = d
				maxIdx = i
				if maxDigit == 9 {
					break
				}
			}
		}

		resDigits = append(resDigits, maxDigit)
		start = maxIdx + 1
		remaining--
	}

	// build the final number
	result := 0
	for _, d := range resDigits {
		result = result*10 + d
	}
	return result
}
