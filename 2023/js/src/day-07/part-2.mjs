/** @format */

export async function processPart2(input) {
	const cardValueIndex = [
		'J',
		'2',
		'3',
		'4',
		'5',
		'6',
		'7',
		'8',
		'9',
		'T',
		'Q',
		'K',
		'A',
	];
	const lines = input.split('\n');
	const hands = lines.map((line) => {
		const cards = line.split(' ')[0];
		const bid = Number(line.split(' ')[1]);
		const strength = determineHand(cards);
		return { cards, strength, bid };
	});

	// console.log('before:', hands);
	const sorted = strengthSort(hands, cardValueIndex).reverse();

	function testDetermineHand() {
		const testHands = [
			{ hand: 'AAAAA', expected: 6 }, // Five of a kind
			{ hand: 'JJJJA', expected: 6 }, // Five of a kind with wilds
			{ hand: 'AAAAB', expected: 5 }, // Four of a kind
			{ hand: 'JJJAB', expected: 5 }, // Four of a kind with wilds
			{ hand: 'AAABB', expected: 4 }, // Full house
			{ hand: 'JJABB', expected: 4 }, // Full house with wilds
			{ hand: 'AAABC', expected: 3 }, // Three of a kind
			{ hand: 'JJABC', expected: 3 }, // Three of a kind with wilds
			{ hand: 'AABBC', expected: 2 }, // Two pair
			{ hand: 'JAABC', expected: 3 }, // Three of a kind with wilds
			{ hand: 'AABCD', expected: 1 }, // One pair
			{ hand: 'JABCD', expected: 1 }, // One pair with wilds
			{ hand: 'ABCDE', expected: 0 }, // High card
			// Add more test cases as needed
		];

		testHands.forEach(({ hand, expected }) => {
			const result = determineHand(hand);
			console.log(
				`Hand: ${hand}, Expected: ${expected}, Result: ${result}, Test: ${
					result === expected ? 'Passed' : 'Failed'
				}`
			);
		});
	}
	// testDetermineHand();

	return score(sorted);
}

function countCards(hand) {
	const counts = {};
	for (const card of hand) {
		counts[card] = (counts[card] || 0) + 1;
	}
	return counts;
}

function determineHand(hand) {
	const cards = [...hand];
	const counts = countCards(cards);
	const uniqueCards = Object.keys(counts).length;
	const countValues = Object.values(counts);
	const wilds = cards.filter((letter) => letter === 'J').length || 0;
	// console.log(wilds);

	if (uniqueCards === 1) return 6; // five of a kind
	if (wilds === 4) return 6; // five of a kind
	if (wilds === 3) {
		if (countValues.includes(2)) {
			return 6; // five of a kind
		}
		return 5; // four of a kind
	}
	if (wilds === 2) {
		if (countValues.filter((count) => count === 2).length === 2) {
			return 4; // full house
		}
		if (countValues.includes(3)) {
			return 6; // five of a kind
		}

		return 3; // three of a kind
	}
	if (wilds === 1) {
		if (countValues.includes(2)) {
			return 3; // three of a kind
		}
		return 1; //one pair
	}

	if (uniqueCards === 2) {
		if (countValues.includes(4)) return 5; // four of a kind
		return 4; // full house
	}

	if (uniqueCards === 3) {
		if (countValues.filter((count) => count === 2).length === 2) return 2; // two pair
		return 3; // three of a kind
	}

	if (uniqueCards === 4) {
		return 1; // one pair
	}

	if (uniqueCards === 5) {
		return 0; // high card
	}
}

function compareCards(cardA, cardB, cardValueIndex) {
	return cardValueIndex.indexOf(cardB) - cardValueIndex.indexOf(cardA);
}

function tieBreak(handA, handB, cardValueIndex) {
	for (let i = 0; i < handA.length; i++) {
		const comparison = compareCards(handA[i], handB[i], cardValueIndex);
		if (comparison !== 0) return comparison;
	}
	return 0;
}

function strengthSort(hands, cardValueIndex) {
	return [...hands].sort((a, b) => {
		if (a.strength !== b.strength) {
			return b.strength - a.strength;
		}
		return tieBreak(a.cards, b.cards, cardValueIndex);
	});
}

function score(hands) {
	let score = 0;
	hands.forEach((hand, index) => {
		score += hand.bid * (index + 1);
	});
	return score;
}
