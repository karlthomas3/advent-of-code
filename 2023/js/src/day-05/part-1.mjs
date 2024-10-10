export async function processPart1(input) {
  const sections = input.split("\n\n");
  // console.log(sections);

  const seeds = sections[0].split(": ")[1].split(" ").map(Number);
  const maps = sections.slice(1).map((section) =>
    section
      .split("\n")
      .slice(1)
      .map((line) => line.split(" ").map(Number))
  );
  // console.log(seeds, "\n", maps);

  function mapNum(num, map) {
    const mappedNum = map.find(
      ([destStart, srcStart, range]) => num >= srcStart && num < srcStart + range
    );
    return mappedNum ? mappedNum[0] + (num - mappedNum[1]) : num;
  }

  function findLocation(seed, maps) {
    return maps.reduce((currNum, map) => mapNum(currNum, map), seed);
  }

  const lowestLocation = seeds.reduce((lowest, seed) => {
    const location = findLocation(seed, maps);
    return Math.min(lowest, location);
  }, Infinity);

  return lowestLocation;
}
