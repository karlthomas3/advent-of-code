/** @format */

export async function processPart2(input) {
	const [key, mapStrings] = input.trim().split('\n\n');
	const directions = key.split('');

	const maps = {};
	mapStrings.split('\n').forEach((line) => {
		const parts = line.split(' = ');
		const location = parts[0];
		const [L, R] = parts[1].replace('(', '').replace(')', '').split(', ');
		maps[location] = { L, R };
	});

	let starts = [];
	mapStrings.split('\n').forEach((line) => {
		const loc = line.split(' = ')[0];
		if (loc[2] === 'A') starts.push(loc);
	});
	console.log('starts', starts);
	return wander(directions, maps, starts);
}

function wander(directions, maps, starts) {
	let currentLocations = starts;
	let steps = 0;
	let index = 0;
	let end = false;

	while (true) {
		[currentLocations, end] = nextStep(
			maps,
			currentLocations,
			directions[index]
		);
		steps++;
		index = (index + 1) % directions.length;
		if (steps % 100000000 === 0) console.log('steps:', steps, currentLocations);
		// console.log(currentLocations, index, directions[index]);

		if (end) break;
	}
	console.log(currentLocations);
	return steps;
}
function nextStep(maps, locations, direction) {
	let newLocations = [];
	let ends = 0;
	locations.forEach((location) => {
		const newLocation = maps[location][direction];
		newLocations.push(newLocation);
		if (newLocation.endsWith('Z')) {
			ends++;
		}
	});
	// console.log(newLocations, ends);
	return [newLocations, ends == locations.length];
}
