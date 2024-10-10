/** @format */

export async function processPart1(input) {
	const [key, mapStrings] = input.trim().split('\n\n');
	const directions = key.split('');
	const maps = {};

	mapStrings.split('\n').forEach((line) => {
		const parts = line.split(' = ');
		const location = parts[0];
		const [L, R] = parts[1].replace('(', '').replace(')', '').split(', ');
		maps[location] = { L, R };
	});
	return wander(directions, maps);
}

function wander(directions, maps) {
	let currentLocation = 'AAA';
	let steps = 0;
	let index = 0;

	while (currentLocation !== 'ZZZ') {
		currentLocation = maps[currentLocation][directions[index]];
		steps++;
		index = (index + 1) % directions.length;
	}
	console.log('steps/direcetions.length:', steps / directions.length);
	return steps;
}
