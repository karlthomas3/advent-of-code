export function processPart2(input: string): number {
	const trimmed = input.trim();
	const lines = trimmed.split('\n');

	let ribbon = 0;

	for (const line of lines) {
		const [l, w, h] = line.split('x').map(Number);
		const sorted = [l, w, h].sort((a, b) => a - b);
		const [shortest, middle] = sorted;

		ribbon += 2 * shortest + 2 * middle + l * w * h;
	}
	return ribbon;
}
