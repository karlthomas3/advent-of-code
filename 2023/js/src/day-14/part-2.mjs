/** @format */

export async function processPart2(input) {
	const board = input
		.trim()
		.split('\n')
		.map((line) => line.split(''));
	// board.forEach((line) => console.log(line.join(''))); // print for debugging
	return cycle(board);
}

// shift the board north, west, east, south. then score and return score
function spin(board) {
	// need to iterate the board from the 'end' for each direction

	// north
	for (let row = 0; row < board.length; row++) {
		for (let index = 0; index < board[row].length; index++) {
			if (board[row][index] === 'O') north(board, row, index);
		}
	}
	// west
	for (let index = 0; index < board[0].length; index++) {
		for (let row = 0; row < board.length; row++) {
			if (board[row][index] === 'O') west(board, row, index);
		}
	}
	// south
	for (let row = board.length - 1; row >= 0; row--) {
		for (let index = 0; index < board[row].length; index++) {
			if (board[row][index] === 'O') south(board, row, index);
		}
	}
	// east
	for (let index = board[0].length - 1; index >= 0; index--) {
		for (let row = 0; row < board.length; row++) {
			if (board[row][index] === 'O') east(board, row, index);
		}
	}
	return score(board);
}

function north(board, row, index) {
	if (row === 0 || board[row - 1][index] !== '.') return; // base case

	if (row > 0 && board[row - 1][index] === '.') {
		board[row][index] = '.';
		board[row - 1][index] = 'O';
		north(board, row - 1, index);
	}
}

function west(board, row, index) {
	if (index === 0 || board[row][index - 1] !== '.') return; // base case

	if (index > 0 && board[row][index - 1] === '.') {
		board[row][index] = '.';
		board[row][index - 1] = 'O';
		west(board, row, index - 1);
	}
}

function south(board, row, index) {
	if (row === board.length - 1 || board[row + 1][index] !== '.') return; // base case

	if (row < board.length && board[row + 1][index] === '.') {
		board[row][index] = '.';
		board[row + 1][index] = 'O';
		south(board, row + 1, index);
	}
}

function east(board, row, index) {
	if (index === board[row].length - 1 || board[row][index + 1] !== '.') return; // base case

	if (index < board[row].length && board[row][index + 1] === '.') {
		board[row][index] = '.';
		board[row][index + 1] = 'O';
		east(board, row, index + 1);
	}
}

function score(board) {
	let count = 0;
	let index = 1;
	for (let row = board.length - 1; row >= 0; row--) {
		count += board[row].filter((char) => char === 'O').length * index;
		index++;
	}
	return count;
}

function cycle(board) {
	let currentScore = 0;
	let count = 0;
	let cycles = 0;
	const maxCycles = 1000000000;
	const goal = 10;

	while (count < goal) {
		cycles++;
		const score = spin(board);
		if (score == currentScore) {
			count++;
		} else {
			count = 0;
			currentScore = score;
		}
		if (cycles % 10000 === 0) console.log('cycles:', cycles);
		if (cycles > maxCycles) return `Final score: ${currentScore}`;
	}
	return `Stable score: ${currentScore}`;
}
