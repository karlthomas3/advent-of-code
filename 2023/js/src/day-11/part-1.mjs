/** @format */

export async function processPart1(input) {
	const sky = input
		.trim()
		.split('\n')
		.map((line) => line.split(''));

	const emptyRows = checkEmptyRows(sky);
	const emptyCols = checkEmptyCols(sky);
	expandRows(sky, emptyRows);
	expandCols(sky, emptyCols);

	const [count, locations] = findGalaxies(sky);
	const distances = countSteps(locations);

	// showSky(sky);
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
	const emptyLine = sky.at(0).map((_) => '.');
	// console.log(emptyLine.join(''));
	for (let i = rows.length - 1; i >= 0; i--) {
		sky.splice(rows.at(i), 0, [...emptyLine]);
	}
}

function expandCols(sky, cols) {
	for (let i = cols.length - 1; i >= 0; i--) {
		for (let row = 0; row < sky.length; row++) {
			sky.at(row).splice(cols.at(i), 0, '.');
		}
	}
}

function findGalaxies(sky) {
	let count = 1;
	const locations = [];
	for (let row = 0; row < sky.length; row++) {
		for (let col = 0; col < sky.at(row).length; col++) {
			if (sky[row][col] === '#') {
				sky[row][col] = count;
				count++;
				locations.push([row, col]);
			}
		}
	}
	// console.log('count:', count, 'locations:', locations);
	return [count, locations];
}

function countSteps(locations) {
	let distances = [];
	locations.forEach((location, index) => {
		const [lat, long] = location;

		for (let i = index + 1; i < locations.length; i++) {
			const distance =
				Math.abs(lat - locations[i][0]) + Math.abs(long - locations[i][1]);
			distances.push(distance);
		}
	});
	// console.log('distances:', distances);
	return distances;
}
