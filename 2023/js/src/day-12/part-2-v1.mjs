/** @format */

export async function processPart2(input) {
	const lines = input
		.trim()
		.split('\n')
		.map((line) => {
			const parts = line.split(' ');
			const prob = parts[0];
			const list = (parts[1] + ',').split(',').map(Number);
			return [prob, list];
		});
	let combos = 0;
	lines.forEach((line, index) => {
		const [combo, sizes] = expand(line);
		combos += generate(combo, sizes);
		console.log(`line ${index}:`, line, 'total:', combos, '\n', combo, sizes);
	});
	return combos;
}

// generate possible arrays for any string
// gets an array with a string and a size array '[ '?#.?..?.##.###?', [ 2, 1, 2, 3, 0 ] ]'
function generate(string, sizes, index = 0) {
	if (index === string.length) return isValid(string, sizes) ? 1 : 0; // base case

	if (string[index] !== '?') return generate(string, sizes, index + 1); // no choices to make

	// generate both choices
	let broken = replaceAt(string, index, '#');
	let working = replaceAt(string, index, '.');

	return (
		generate(broken, sizes, index + 1) + generate(working, sizes, index + 1)
	);
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

function expand(line) {
	const combo = line[0].repeat(5);
	const sizes = (line[1].join(',') + ',').repeat(5).split(',').map(Number);
	sizes.pop();
	return [combo, sizes];
}

function replaceAt(string, index, char) {
	return string.slice(0, index) + char + string.slice(index + 1);
}
