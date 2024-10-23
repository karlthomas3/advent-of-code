package main

import (
	"strconv"
	"strings"
)

func part1(input string) int {
	lines := strings.Split(input, "\n")
	table := make(map[string]int)

	for {
		changed := false
		for index, line := range lines {
			// fmt.Println(line)
			if line == "" {
				continue
			}
			trimmed := strings.TrimSpace(line)
			parts := strings.Split(trimmed, " -> ")
			if len(parts) != 2 {
				continue // Skip invalid lines
			}
			val := parts[1]
			instructions := strings.Split(parts[0], " ")

			if len(instructions) == 1 {
				v, err := strconv.Atoi(instructions[0])
				if err != nil {
					v, exists := table[instructions[0]]
					if !exists {
						continue
					}
					table[val] = v
				} else {
					table[val] = v
				}
				lines = append(lines[:index], lines[index+1:]...)
				changed = true
				break
			}

			if instructions[0] == "NOT" {
				v, exists := table[instructions[1]]
				if exists {
					table[val] = ^v
					lines = append(lines[:index], lines[index+1:]...)
					changed = true
					break
				}
				continue
			}

			lVal, lExists := getValue(instructions[0], table)
			rVal, rExists := getValue(instructions[2], table)
			if !lExists || !rExists {
				continue
			}

			switch instructions[1] {
			case "AND":
				table[val] = lVal & rVal
			case "OR":
				table[val] = lVal | rVal
			case "LSHIFT":
				table[val] = lVal << rVal
			case "RSHIFT":
				table[val] = lVal >> rVal
			}
			lines = append(lines[:index], lines[index+1:]...)
			changed = true
			break
		}
		if !changed {
			break
		}
	}

	return table["a"]
}

func getValue(s string, table map[string]int) (int, bool) {
	if v, exists := table[s]; exists {
		return v, true
	}
	v, err := strconv.Atoi(s)
	if err != nil {
		return 0, false
	}
	return v, true
}
