import { createHash } from 'node:crypto';

export function processPart2(input: string): number {
	let i = 1;
	while (true) {
		if (md5(`${input}${i}`).startsWith('000000')) {
			return i;
		}
		i++;
	}
}

function md5(input: string): string {
	const hash = createHash('md5');
	hash.update(input);
	return hash.digest('hex');
}
