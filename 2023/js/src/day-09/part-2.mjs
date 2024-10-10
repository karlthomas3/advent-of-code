/** @format */

export async function processPart2(input) {
	// clean input
	const lines = input.trim().split('\n');
	const histories = lines.map((line) => line.split(' ').map(Number));
	// console.log(histories);

	// get predictions for each line
	const predictions = histories.map((history) => predict(history));

	// sum predictions for final number
	const total = predictions.reduce((acc, cur) => acc + cur, 0);
	return total;
}
function getDiffs(arr) {
	let diffArr = [];
	arr.forEach((num, index) => {
		if (index < arr.length - 1) diffArr.push(arr[index + 1] - num);
	});
	return diffArr;
}

function predict(arr) {
	// get diffs for each array till array is all 0
	const diffArrays = [arr];
	while (diffArrays.at(-1).some((num) => num !== 0)) {
		diffArrays.push(getDiffs(diffArrays.at(-1)));
	}
	// only need the first number of each array
	const firstNums = diffArrays.reverse().map((arr) => arr.at(0));
	const prediction = firstNums.reduce((acc, cur) => cur - acc, 0);

	return prediction;
}
