/** @format */

export async function processPart1(input) {
	const sets = input
		.trim()
		.split('\n\n')
		.map((set) => set.split('\n').map((line) => line.split('')));

	const scores = sets.map((set, index) => {
		const rows = checkRows(set);
		if (rows !== 0) return rows;
		const cols = columnMaker(set);
		const columns = checkRows(cols, true);
		if (columns !== 0) return columns;
		return [index, set.map((row) => row.join('')).join('\n')];
	});
	// scores.forEach((score) => console.log(score));
	return scores.reduce((acc, cur) => acc + cur, 0);
}
// show sets for debugging
function showSets(sets) {
	sets.forEach((set, index) => {
		console.log(index);
		set.forEach((line) => {
			console.log(line.join(''));
		});
		console.log('\n');
	});
}

function checkRows(set, column = false) {
	// logging for debugging
	// set.forEach((line) => console.log(line.join('')));
	// console.log(set);

	for (let row = 0; row < set.length; row++) {
		if (mirrorCheck(set, row, row + 1)) {
			return column ? row + 1 : (row + 1) * 100;
		}
	}
	return 0;
}

function columnMaker(set) {
	let columns = [];

	for (let col = 0; col < set[0].length; col++) {
		let column = [];
		for (let row = 0; row < set.length; row++) {
			column.push(set[row][col]);
		}
		columns.push(column);
	}
	return columns;
}

function mirrorCheck(set, index1, index2) {
	if (index1 < 0 || index2 > set.length) return;
	// recursively check next outside sets
	if (set?.at(index1)?.join('') !== set?.at(index2)?.join('')) return false; // base case

	if (index1 > 0 && index2 < set.length - 1)
		return mirrorCheck(set, index1 - 1, index2 + 1);

	return true;
}
