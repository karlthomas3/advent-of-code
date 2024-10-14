export function processPart1(input: string): number {
	const trimmed = input.trim();
	const directions = trimmed.split('');

	const visited = new Set<string>();
	let x = 0;
	let y = 0;
	visited.add(`${x},${y}`);

	for (const direction of directions) {
		switch (direction) {
			case '^':
				y++;
				break;
			case 'v':
				y--;
				break;
			case '>':
				x++;
				break;
			case '<':
				x--;
				break;
		}
		visited.add(`${x},${y}`);
	}
	return visited.size;
}
