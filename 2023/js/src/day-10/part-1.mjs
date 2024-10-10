/** @format */

export async function processPart1(input) {
	// clean the data and parse it into 3d array
	const pipes = input
		.trim()
		.split('\n')
		.map((line) => line.split(''));

	// find the starting point
	const start = findStart(pipes);

	// find initial paths
	const paths = findStartPaths(pipes, start);

	// traverse paths counting steps
	const steps = paths.map((path) => traverse(pipes, path, start));
	return steps.map((count) => Math.ceil(count / 2));
}

function findStart(arr) {
	// iterate rows
	for (let row = 0; row < arr.length; row++) {
		for (let col = 0; col < arr[row].length; col++) {
			if (arr[row][col] === 'S') return [row, col];
		}
	}
	return null;
}

function findStartPaths(arr, position) {
	const [startRow, startCol] = position;
	let paths = [];

	// define possible paths for each direction
	const north = ['|', '7', 'F'];
	const east = ['-', '7', 'J'];
	const west = ['-', 'L', 'F'];
	const south = ['|', 'L', 'J'];

	// check for and return paths
	if (north.includes(arr[startRow - 1][startCol]))
		paths.push([startRow - 1, startCol]);
	if (south.includes(arr[startRow + 1][startCol]))
		paths.push([startRow + 1, startCol]);
	if (east.includes(arr[startRow][startCol + 1]))
		paths.push([startRow, startCol + 1]);
	if (west.includes(arr[startRow][startCol - 1]))
		paths.push([startRow, startCol - 1]);

	return paths;
}

function checkPath(arr, location, entry) {
	const [locR, locC] = location;
	let exits = [];

	// check pipe and define possible exits
	if (arr[locR][locC] === '|')
		exits = [
			[locR - 1, locC],
			[locR + 1, locC],
		];
	if (arr[locR][locC] === '-')
		exits = [
			[locR, locC - 1],
			[locR, locC + 1],
		];
	if (arr[locR][locC] === 'L')
		exits = [
			[locR - 1, locC],
			[locR, locC + 1],
		];
	if (arr[locR][locC] === 'J')
		exits = [
			[locR - 1, locC],
			[locR, locC - 1],
		];
	if (arr[locR][locC] === '7')
		exits = [
			[locR, locC - 1],
			[locR + 1, locC],
		];
	if (arr[locR][locC] === 'F')
		exits = [
			[locR, locC + 1],
			[locR + 1, locC],
		];

	// return the exit you didnt enter from
	const exit = exits.find(
		(exit) => exit[0] !== entry[0] || exit[1] !== entry[1]
	);
	return exit;
}

function traverse(arr, first, start) {
	let last = start;
	let current = first;
	let steps = 1;
	const path = [];

	// keep going till you hit the start again
	while (arr[current[0]][current[1]] != 'S') {
		path.push(current);
		const next = checkPath(arr, current, last);
		steps++;
		last = current;
		current = next;
	}
	return steps;
}
