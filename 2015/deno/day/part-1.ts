export function processPart1(input: string): number {
	const trimmed = input.trim();
	const directions = trimmed.split('');

	let floor = 0;
	for (const direction of directions) {
		if (direction === '(') {
			floor++;
		} else if (direction === ')') {
			floor--;
		}
	}
	return floor;
}
