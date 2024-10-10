# Advent of Code 2023 - JS Edition

## Getting started

Make sure you have node version 20+ installed. (I recommend using [asdf](https://asdf-vm.com/#/) to manage your node versions if you need to maintain an older version of node).

To write the solutions for the puzzles use the node test runner:

```bash
# runs the tests for day 1 and watches for changes. Change the day number to run the tests for a different day.
node --test --watch --test-name-pattern="day 1"
```

The tests are written in `./src/test/day-<day>.test.mjs`. The solutions are written in `./src/day-<day>/part1.mjs` and `./src/day-<day>/part2.mjs`.
Once you are happy with your solution you can run the puzzle input through it:

```bash
# finds the solution for day 1
node src/day-01/main.mjs
```

`src/day-01/main.mjs` is a wrapper around your solution that reads the puzzle input from `src/day-01/input.txt` and prints the solution to the console.

To work on any other day just duplicate the `src/day-01` folder and rename it to the day you want to work on, you will also need to duplicate the test file and provide the correct input under `input.txt`.
