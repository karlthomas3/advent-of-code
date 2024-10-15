package main

import (
	"crypto/md5"
	"encoding/hex"
	"fmt"
	"strconv"
)

func main() {
	input := "iwrupvqb"

	answer1 := part1(input)
	fmt.Println("Part 1:", answer1)

	answer2 := part2(input)
	fmt.Println("Part 2:", answer2)
}

func part1(input string) int {
	for i := 1; ; i++ {
		hash := getHash(input + strconv.Itoa(i))
		if fiveZeroes(hash) {
			return i
		}
	}
}

func part2(input string) int {
	for i := 1; ; i++ {
		hash := getHash(input + strconv.Itoa(i))
		if hash[:6] == "000000" {
			return i
		}
	}
}

func getHash(input string) string {
	hash := md5.Sum([]byte(input))
	return hex.EncodeToString(hash[:])
}
func fiveZeroes(hash string) bool {
	return hash[:5] == "00000"
}
