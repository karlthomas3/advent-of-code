export function processPart1(input: string): number {
	const trimmed = input.trim();
	const lines = trimmed.split('\n');

	let paper = 0;

	for (const line of lines) {
		const [l, w, h] = line.split('x').map(Number);
		const sides = [l * w, w * h, h * l];
		const smallest = Math.min(...sides);

		paper += sides.reduce((acc, side) => acc + 2 * side, 0) + smallest;
	}
	return paper;
}
