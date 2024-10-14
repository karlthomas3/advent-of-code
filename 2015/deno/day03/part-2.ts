export function processPart2(input: string): number {
	const trimmed = input.trim();
	const directions = trimmed.split('');

	const visited = new Set<string>();
	let x = 0;
	let y = 0;
	let y1 = 0;
	let x1 = 0;
	let santa = true;
	visited.add(`${x},${y}`);

	for (const direction of directions) {
		if (santa) {
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
			santa = !santa;
		} else if (!santa) {
			switch (direction) {
				case '^':
					y1++;
					break;
				case 'v':
					y1--;
					break;
				case '>':
					x1++;
					break;
				case '<':
					x1--;
					break;
			}
			visited.add(`${x1},${y1}`);
			santa = !santa;
		}
	}
	return visited.size;
}
