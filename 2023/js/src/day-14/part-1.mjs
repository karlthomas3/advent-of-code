/** @format */

export async function processPart1(input) {
	const board = input
		.trim()
		.split('\n')
		.map((line) => line.split(''));
	// board.forEach((line) => console.log(line.join(''))); // print for debugging

	// 'tilt' board shifting all O up
	const shiftedBoard = tilt(board);
	// reverse board, count '0' and multiply index+1
	const counts = shiftedBoard
		.reverse()
		.map(
			(row, index) => row.filter((char) => char == 'O').length * (index + 1)
		);
	return counts.reduce((acc, cur) => acc + cur, 0);
	// console.log('\n');
	// shiftedBoard.forEach((line) => console.log(line.join(''))); //print for debugging
}

function tilt(oldBoard) {
	const board = [...oldBoard];
	for (let row = 0; row < board.length; row++) {
		for (let index = 0; index < board[row].length; index++) {
			if (board[row][index] === 'O') shift(board, row, index);
		}
	}
	return board;
}
function shift(board, row, index) {
	if (row === 0 || board[row - 1][index] !== '.') return; // base case

	if (row > 0 && board[row - 1][index] === '.') {
		board[row][index] = '.';
		board[row - 1][index] = 'O';
		shift(board, row - 1, index);
	}
}
