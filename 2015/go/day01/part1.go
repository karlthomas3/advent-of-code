package main

func processPart1(input string) int {
	floor := 0
	for _, c := range input {
		if c == '(' {
			floor++
		} else if c == ')' {
			floor--
		}
	}
	return floor
}

func test() int {
	return 1
}
