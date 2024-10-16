import { processPart1 } from './part-1.ts';
import { processPart2 } from './part-2.ts';

const input = await Deno.readTextFile('input.txt');

const part1Result = await processPart1(input);
console.log(`Part 1: ${part1Result}`);

const part2Result = await processPart2(input);
console.log(`Part 2: ${part2Result}`);
