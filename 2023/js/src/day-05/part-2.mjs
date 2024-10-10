export async function processPart2(input) {
  const sections = input.split("\n\n");

  const seedData = sections[0].split(": ")[1].split(" ").map(Number);
  const maps = sections.slice(1).map((section) =>
    section
      .split("\n")
      .slice(1)
      .map((line) => line.split(" ").map(Number))
      .sort((a, b) => a[1] - b[1])
  );
  // console.log(seeds, "\n", maps);

  function mapNum(num, map) {
    let low = 0;
    let high = map.length - 1;

    while (low <= high) {
      let mid = Math.floor((low + high) / 2);
      let [destStart, srcStart, rangeLength] = map[mid];

      if (num >= srcStart && num < srcStart + rangeLength) {
        return destStart + (num - srcStart);
      } else if (num < srcStart) {
        high = mid - 1;
      } else {
        low = mid + 1;
      }
    }
    return num;
  }

  function findLocation(seed, maps) {
    return maps.reduce((currNum, map) => mapNum(currNum, map), seed);
  }

  function lowestLocation(seeds) {
    return seeds.reduce((lowest, seed) => {
      const location = findLocation(seed, maps);
      return Math.min(lowest, location);
    }, Infinity);
  }

  function runSeedList(seed, range) {
    console.log("seed", seed, "range", range);
    let current = seed;
    for (let i = 0; i < range; i++) {
      const location = findLocation(seed + i, maps);
      current = Math.min(current, location);
      console.log("current lowest: ", current);
    }
    return current;
  }

  let lowestArr = [];
  for (let i = 0; i < seedData.length; i += 2) {
    const lowest = runSeedList(seedData[i], seedData[i + 1]);
    lowestArr.push(lowest);
  }

  return lowestLocation(lowestArr);
}
