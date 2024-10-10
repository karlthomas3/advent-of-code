/** @format */

export async function processPart2(input) {
	const sequence = input.trim().replace('\n', '').split(',');

	const boxes = boxMaker();
	// console.log(boxes);
	sequence.forEach((string) => {
		let label, length, goto;

		// remove lense from box
		if (string.includes('-')) {
			[label, length] = string.split('-');
			goto = hash(label);

			boxes[goto] = boxes[goto].filter((str) => !str.includes(label));
		}

		if (string.includes('=')) {
			[label, length] = string.split('=');
			goto = hash(label);

			// if box already contains label
			const index = boxes[goto].findIndex((str) => str.includes(label));

			if (index !== -1) boxes[goto][index] = `${label} ${length}`;
			else boxes[goto].push(`${label} ${length}`);
		}
	});
	// console.log(boxes);
	const powers = boxes.map(calcFocus);
	// console.log(powers);
	return powers.reduce((acc, cur) => acc + cur, 0);
}

// decode a string
function hash(string) {
	let curVal = 0;

	for (const char of string) {
		curVal += char.charCodeAt(0);
		curVal *= 17;
		curVal %= 256;
	}
	return curVal;
}

function boxMaker() {
	const boxes = [];
	for (let i = 0; i < 256; i++) {
		boxes.push([]);
	}
	return boxes;
}

function calcFocus(box, boxNum) {
	const powers = [];
	box.forEach((lens, index) => {
		const length = lens.split(' ')[1];
		powers.push((boxNum + 1) * (index + 1) * length);
	});
	return powers.reduce((acc, cur) => acc + cur, 0);
}
