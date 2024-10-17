package main

func processPart2(input string) int {
	floor := 0
	for i, c := range input {
		if c == '(' {
			floor++
		} else if c == ')' {
			floor--
		}
		if floor < 0 {
			return i + 1
		}
	}
	return 0
}
