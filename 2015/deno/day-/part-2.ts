export function processPart2(input: string): number {
	const trimmed = input.trim();
	const directions = trimmed.split('');

	let floor = 0;

	for (let i = 0; i < directions.length; i++) {
		if (directions[i] === '(') {
			floor++;
		} else if (directions[i] === ')') {
			floor--;
		}
		if (floor < 0) {
			return i + 1;
		}
	}
	return 0;
}
