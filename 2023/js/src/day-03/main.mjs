import fs from "fs/promises";
import path from "path";

import { processPart1 } from "./part-1.mjs";
import { processPart2 } from "./part-2.mjs";

const __dirname = path.dirname(new URL(import.meta.url).pathname);
const filePath = path.join(__dirname, "input.txt");
console.log(filePath);

const input = await fs.readFile(filePath, "utf8").catch((err) => {
  console.error("Error reading file:", err);
});

const part1Result = await processPart1(input);
console.log(`Part 1: ${part1Result}`);

const part2Result = await processPart2(input);
console.log(`Part 2: ${part2Result}`);
