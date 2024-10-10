/** @format */

const globalCounter = {
	high: 0,
	low: 0,
};

export async function processPart1(input) {
	const lines = input.trim().split('\n');

	const broadcastIndex = lines.findIndex((line) =>
		line.startsWith('broadcaster')
	);
	const broadcastTargets = lines.at(broadcastIndex).split('-> ')[1].split(',');

	const clean = [
		...lines.slice(0, broadcastIndex),
		...lines.slice(broadcastIndex + 1),
	];

	const modules = clean.map((line) => {
		let parts = line.split(' -> ');
		const type = parts[0].slice(0, 1);
		const id = parts[0].slice(1);
		const targets = parts[1].split(',');
		return { type, id, targets };
	});
	let modList = [];

	modList = modules.map((module) => {
		if (module.type === '%') {
			return new FlipFlop(module.id, module.targets);
		} else {
			return new Conjunction(module.id, module.targets);
		}
	});
	const broadcaster = new Broadcaster(broadcastTargets);
	modList.forEach((mod) => (mod.modList = modList));

	// showLines(modList);

	function showLines(arr) {
		arr.forEach((line) => console.log(line));
	}

	function FlipFlop(id, targets) {
		this.id = id;
		this.targets = targets;
		this.state = false;

		this.high = function () {
			return;
		};
		this.low = function () {
			if (this.state) {
				// send low to targets
				this.targets.forEach((target) => {
					let cur = modList.find((obj) => obj.id === target);
					cur.low(this.id);
					globalCounter.low++;
				});
			} else {
				// send high to targets
				this.targets.forEach((target) => {
					let cur = modList.find((obj) => obj.id === target);
					cur.high(this.id);
					globalCounter.high++;
				});
			}
			this.state = !this.state;
		};
	}

	function Conjunction(id, targets) {
		this.id = id;
		this.targets = targets;
		this.recent = modList
			.filter((obj) => obj.targets.includes(this.id))
			.map((obj) => ({ id: obj.id, state: 'low' }));

		this.high = function (id) {
			let cur = this.recent.find((obj) => obj.id === id);
			cur.state = 'high';
			this.send(this.id);
		};
		this.low = function (id) {
			let cur = this.recent.find((obj) => obj.id === id);
			cur.state = 'low';
			this.send(this.id);
		};
		this.send = function () {
			if (this.recent.some((obj) => obj.state == 'low')) {
				this.targets.forEach((target) => {
					let cur = modList.find((obj) => obj.id === target);
					cur.high(this.id);
					globalCounter.high++;
				});
			} else {
				this.targets.forEach((target) => {
					let cur = modList.find((obj) => obj.id === id);
					cur.low(this.id);
					globalCounter.low++;
				});
			}
		};
	}

	function Broadcaster(targets) {
		this.id = 'broadcaster';
		this.targets = targets;

		this.high = function () {
			this.targets.forEach((target) => {
				let cur = modList.find((obj) => obj.id === target);
				console.log('current', cur);
				cur.high(this.id);
				globalCounter.high++;
			});
		};
		this.low = function () {
			this.targets.forEach((target) => {
				let cur = modList.find((obj) => obj.id === target);
				console.log('current', cur);

				cur.low(this.id);
				globalCounter.low++;
			});
		};
	}

	function button() {
		globalCounter.low++;
		broadcaster.low();
	}

	button();
	return globalCounter;
}
