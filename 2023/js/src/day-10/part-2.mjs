/** @format */

export async function processPart2(input) {
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
	const [steps, path] = traverse(pipes, paths[0], start);
	// mark the path through the map
	// flood fill outside
	// iterate map and count tiles not path or flooded
	const innerCount = countInnerTiles(pipes, path);

	return innerCount;
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
	return [steps, path];
}

function markPath(arr, path) {
	path.forEach((loc) => (arr[loc[0]][loc[1]] = 'P'));
}

function flood(arr, loc) {
	const [row, col] = loc;

	// check within bounds
	if (row < 0 || row >= arr.length || col < 0 || col >= arr[row].length) return;

	// check not already marked
	if (arr[row][col] === 'O' || arr[row][col] === 'P') return;

	// mark tile
	arr[row][col] = 'O';

	// flood all directions
	flood(arr, [row - 1, col]);
	flood(arr, [row + 1, col]);
	flood(arr, [row, col - 1]);
	flood(arr, [row, col + 1]);
}

function countInnerTiles(arr, path) {
	markPath(arr, path);

	// flood from corners
	flood(arr, [0, 0]);
	flood(arr, [0, arr[0].length - 1]);
	flood(arr, [arr.length - 1, 0]);
	flood(arr, [arr.length - 1, arr[0].length - 1]);

	// count remaining tiles
	let count = 0;
	for (let row = 0; row < arr.length; row++) {
		for (let col = 0; col < arr[row].length; col++) {
			// eliminate isolated tiles
			let sides = 0;
			if (arr?.at(row - 1)?.at(col) == 'P') sides++;
			if (arr?.at(row + 1)?.at(col) == 'P') sides++;
			if (arr?.at(row)?.at(col - 1) == 'P') sides++;
			if (arr?.at(row)?.at(col + 1) == 'P') sides++;
			if (sides > 2) arr[row][col] = 'P';

			if (arr[row][col] !== 'P' && arr[row][col] !== 'O') {
				count++;
			}
		}
	}
	arr.forEach((row) => console.log(row.join('')));
	return count;
}
