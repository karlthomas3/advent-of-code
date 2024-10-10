/** @format */

export async function processPart1(input) {
	const board = input
		.trim()
		.split('\n')
		.map((line) => line.split(''));

	// view board for debugging
	viewBoard(board);
	return energize(board);
}

function viewBoard(board) {
	board.forEach((line) => console.log(line.join('')));
}

class Beam {
	constructor(x, y, direction) {
		this.x = x;
		this.y = y;
		this.dir = direction;
		this.active = true;
	}
	move(grid) {
		if (this.active) {
			// console.log(`start: ${this.dir}`);

			if (this.dir === 'up') {
				this.y--;
			} else if (this.dir === 'down') {
				this.y++;
			} else if (this.dir === 'left') {
				this.x--;
			} else if (this.dir === 'right') {
				this.x++;
			}
			// if (newX < 0) console.log(`left bound: ${newX},${newY}`);
			// if (newX >= grid[0].length) console.log('right bound:', `${newX},${newY}`);
			// if (newY < 0) console.log('top bound:', `${newX},${newY}`);
			// if (newY >= grid.length) console.log('bottom bound:', `${newX},${newY}`);

			if (
				this.x < 0 ||
				this.x >= grid[0].length ||
				this.y < 0 ||
				this.y >= grid.length
			) {
				this.active = false;
			}
			// console.log(this);
		}
	}

	interact(tile) {
		if (this.active) {
			if (tile === '/') {
				if (this.dir === 'up') {
					this.dir = 'right';
				} else if (this.dir === 'down') {
					this.dir = 'left';
				} else if (this.dir === 'left') {
					this.dir = 'down';
				} else if (this.dir === 'right') {
					this.dir = 'up';
				}
			} else if (tile === '\\') {
				if (this.dir === 'up') {
					this.dir = 'left';
				} else if (this.dir === 'down') {
					this.dir = 'right';
				} else if (this.dir === 'left') {
					this.dir = 'up';
				} else if (this.dir === 'right') {
					this.dir = 'down';
				}
			} else if (tile === '|') {
				if (this.dir === 'left' || this.dir === 'right') {
					this.active = false;
					return [
						new Beam(this.x, this.y, 'up'),
						new Beam(this.x, this.y, 'down'),
					];
				}
			} else if (tile === '-') {
				if (this.dir === 'up' || this.dir === 'down') {
					this.active = false;
					return [
						new Beam(this.x, this.y, 'left'),
						new Beam(this.x, this.y, 'right'),
					];
				}
			}
			return [this];
		}
		return [];
	}
}

function energize(grid) {
	let beams = [new Beam(0, 0, 'right')];
	let energized = new Set();

	const maxRedundant = 10000;
	let cycles = 0;
	let redundants = 0;
	let current = 0;

	while (beams.length > 0) {
		let beam = beams.shift();

		while (beam.active) {
			let tile = grid[beam.y][beam.x];
			// console.log('tile:', tile, beam.x, beam.y);

			if (beam.active) {
				energized.add(`${beam.x},${beam.y}`);
				let splitBeams = beam.interact(tile);
				if (!Array.isArray(splitBeams)) {
					console.error('splitBeams is not an array', splitBeams);
					break;
				}
				splitBeams.forEach((newBeam) => {
					if (newBeam.active) beams.push(newBeam);
				});
			}
			if (beam.active) beam.move(grid);
		}

		// console.log('energized:', energized);
		if (cycles % 1000 === 0)
			console.log(
				'cycles;',
				cycles,
				'energized:',
				energized.size,
				'beams:',
				beams.length,
				'possible:',
				grid.length * grid[0].length
			);
		cycles++;
		if (current === energized.size) redundants++;
		else redundants = 0;
		current = energized.size;
		if (redundants >= maxRedundant) break;
	}
	console.log('total redundants:', redundants);
	console.log('total cycles:', cycles);
	return energized.size;
}
