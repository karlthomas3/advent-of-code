package main

import "strings"

func processPart2(input string) int {
	lines := strings.Split(input, "\n")
	niceStrings := 0

	for _, line := range lines {
		if isNiceString(line) {
			niceStrings++
		}
	}

	return niceStrings
}

func isNiceString(s string) bool {
	if !splitPair(s) {
		return false
	}
	if !twoPairs(s) {
		return false
	}
	return true
}

func splitPair(s string) bool {
	for i := 2; i < len(s); i++ {
		if s[i] == s[i-2] {
			return true
		}
	}
	return false
}

func twoPairs(s string) bool {
	pairs := make(map[string][2]int)

	for i, j := 0, 1; j < len(s); i, j = i+1, j+1 {
		pair := s[i : j+1]
		if indices, exists := pairs[pair]; exists {
			if indices[1] < i {
				return true
			}
		} else {
			pairs[pair] = [2]int{i, j}
		}

	}

	return false
}
