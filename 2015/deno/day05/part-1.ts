export function processPart1(input: string): number {
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
	if (!threeVowels(s)) {
		return false;
	}
	if (!doubleLetters(s)) {
		return false;
	}
	if (badStrings(s)) {
		return false;
	}
	return true;
}

function threeVowels(s: string): boolean {
	const vowels = 'aeiou';
	let vowelCount = 0;

	for (const char of s.split('')) {
		if (vowels.includes(char)) {
			vowelCount++;
		}
	}
	if (vowelCount >= 3) {
		return true;
	}
	return false;
}

function doubleLetters(s: string): boolean {
	for (let i = 1; i < s.length; i++) {
		if (s[i] === s[i - 1]) {
			return true;
		}
	}
	return false;
}

function badStrings(s: string): boolean {
	const badStrings = ['ab', 'cd', 'pq', 'xy'];

	for (const badString of badStrings) {
		if (s.includes(badString)) {
			return true;
		}
	}
	return false;
}
