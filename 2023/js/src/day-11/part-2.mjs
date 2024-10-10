/** @format */

const MULTIPLIER = 1000000;

export async function processPart2(input) {
	const sky = input
		.trim()
		.split('\n')
		.map((line) => line.split(''));

	const emptyRows = checkEmptyRows(sky);
	const emptyCols = checkEmptyCols(sky);
	expandRows(sky, emptyRows);
	expandCols(sky, emptyCols);

	const [count, locations] = findGalaxies(sky);
	// console.log('count', count, 'locations:', locations);
	const distances = countSteps(sky, locations);

	// showSky(sky);
	// console.log(extraRows(sky, [1, 19], [9, 22]));
	return distances.reduce((a, b) => a + b, 0);
}

// print out the sky for visual debugging
function showSky(sky) {
	sky.forEach((line) => console.log(line.join('')));
	console.log('height:', sky.length, 'width:', sky.at(-1).length);
}

function checkEmptyRows(arr) {
	const emptyRows = [];

	arr.forEach((row, index) => {
		if (row.includes('#')) return;
		emptyRows.push(index);
	});
	// console.log(emptyRows);
	return emptyRows;
}

function checkEmptyCols(arr) {
	const emptyCols = [];

	for (let col = 0; col < arr.at(0).length; col++) {
		let colIsEmpty = true;

		for (let row = 0; row < arr.length; row++) {
			if (arr.at(row).at(col) === '#') {
				colIsEmpty = false;
				break;
			}
		}
		if (colIsEmpty) emptyCols.push(col);
	}
	// console.log(emptyCols);
	return emptyCols;
}

function expandRows(sky, rows) {
	const emptyLine = sky.at(0).map((_) => '0');
	// console.log(emptyLine.join(''));
	for (let i = rows.length - 1; i >= 0; i--) {
		sky.splice(rows.at(i), 1, [...emptyLine]);
	}
}

function expandCols(sky, cols) {
	for (let i = cols.length - 1; i >= 0; i--) {
		for (let row = 0; row < sky.length; row++) {
			sky.at(row).splice(cols.at(i), 1, '0');
		}
	}
}

function findGalaxies(sky) {
	let count = 1;
	const locations = [];
	for (let row = 0; row < sky.length; row++) {
		for (let col = 0; col < sky.at(row).length; col++) {
			if (sky[row][col] === '#') {
				// sky[row][col] = count;
				count++;
				locations.push([row, col]);
			}
		}
	}
	// console.log('count:', count, 'locations:', locations);
	return [count, locations];
}

function countSteps(sky, locations) {
	let distances = [];
	let combos = [];

	for (let locIndex = 0; locIndex < locations.length; locIndex++) {
		const [row, col] = locations[locIndex];

		for (let curIndex = locIndex + 1; curIndex < locations.length; curIndex++) {
			let distance =
				Math.abs(row - locations[curIndex][0]) +
				Math.abs(col - locations[curIndex][1]);
			const extraR = extraRows(sky, locations[locIndex], locations[curIndex]);
			const extraC = extraCols(sky, locations[locIndex], locations[curIndex]);

			distance += extraR + extraC;
			distances.push(distance);
			// combos.push([locIndex, curIndex]);
		}
	}
	// console.log(combos)
	return distances;
}

// calculate extra rows and columns between any two points
function extraRows(sky, start, end) {
	const [sRow, sCol] = start;
	const [eRow, eCol] = end;
	let extra = 0;
	for (let i = sRow; i <= eRow; i++) {
		if (sky[i][sCol] === '0') extra++;
	}
	// console.log('extra rows:', extra);
	return extra * MULTIPLIER;
}
function extraCols(sky, start, end) {
	const [sRow, sCol] = start;
	const [eRow, eCol] = end;
	let extra = 0;

	for (let i = sCol; i <= eCol; i++) {
		if (sky[sRow][i] === '0') {
			extra++;
		}
	}
	// console.log('extra columns:', extra);
	return extra * MULTIPLIER;
}
