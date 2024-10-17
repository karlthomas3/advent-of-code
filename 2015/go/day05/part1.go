package main

import "strings"

func processPart1(input string) int {
	lines := strings.Split(input, "\n")
	niceStrings := 0

	for _, line := range lines {
		if isNice(line) {
			niceStrings++
		}

	}

	return niceStrings
}

func threeVowels(s string) bool {
	vowels := "aeiou"
	count := 0

	for _, char := range s {
		if strings.ContainsRune(vowels, char) {
			count++
		}
		if count >= 3 {
			return true
		}
	}

	return false
}

func doubles(s string) bool {
	for i := 1; i < len(s); i++ {
		if s[i] == s[i-1] {
			return true
		}
	}

	return false
}

func badStrings(s string) bool {
	badStrings := []string{"ab", "cd", "pq", "xy"}

	for _, str := range badStrings {
		if strings.Contains(s, str) {
			return true
		}
	}
	return false
}

func isNice(s string) bool {
	if !threeVowels(s) {
		return false
	}
	if !doubles(s) {
		return false
	}
	if badStrings(s) {
		return false
	}
	return true
}
