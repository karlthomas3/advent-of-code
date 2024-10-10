/** @format */

export async function processPart1(input) {
	const lines = input
		.trim()
		.split('\n')
		.map((line) => {
			const parts = line.split(' ');
			const prob = parts[0];
			const list = parts[1].split(',').map(Number);
			return [prob, list];
		});
	const allCombos = lines.map(countHits);
	return allCombos.reduce((a, b) => a + b, 0);
}

// generate possible arrays for any string
function generate(string, index = 0) {
	const str = string.split('');

	if (index === str.length) return [str.join('')]; // base case

	if (str[index] !== '?') return generate(str.join(''), index + 1); // no choices to make

	// generate both choices
	let broken =
		str.slice(0, index).join('') + '#' + str.slice(index + 1).join('');
	let working =
		str.slice(0, index).join('') + '.' + str.slice(index + 1).join('');

	return [...generate(broken, index + 1), ...generate(working, index + 1)];
}

// check if a given arrangement is valid
function isValid(string, sizes) {
	let pattern = '^\\.*';
	sizes.forEach((size, index) => {
		pattern += `#{${size}}`;
		if (index < sizes.length - 1) pattern += '\\.+?';
	});
	pattern += '\\.*$';

	let regex = new RegExp(pattern);

	return regex.test(string);
}

function countHits(line) {
	const [string, array] = line;

	const combos = generate(string);
	let hits = 0;
	combos.forEach((combo) => {
		if (isValid(combo, array)) hits++;
	});
	return hits;
}
