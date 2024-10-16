export function processPart2(input: string): number {
	const trimmed = input.trim();
	const lines = trimmed.split('\n');

	let niceStrings = 0;

	for (const line of lines) {
		if (isNice(line)) {
			niceStrings++;
		}
	}
	return niceStrings;
}

function isNice(s: string): boolean {
	if (!twoPairs(s)) {
		return false;
	}
	if (!sepRepeat(s)) {
		return false;
	}
	return true;
}

function twoPairs(s: string): boolean {
	const pairs = new Map<string, number>();
	for (let i = 0; i < s.length - 1; i++) {
		const pair = s.substring(i, i + 2);
		if (pairs.has(pair)) {
			if (i - pairs.get(pair)! > 1) {
				return true;
			}
		} else {
			pairs.set(pair, i);
		}
	}
	return false;
}

function sepRepeat(s: string): boolean {
	for (let i = 2; i < s.length; i++) {
		if (s[i] === s[i - 2]) {
			return true;
		}
	}
	return false;
}
