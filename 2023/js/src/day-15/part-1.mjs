/** @format */

export async function processPart1(input) {
	const sequence = input.trim().replace('\n', '').split(',');
	const hashes = sequence.map(hash);
	return hashes.reduce((acc, cur) => acc + cur, 0);
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
