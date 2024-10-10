export async function processPart2(input) {
  const lines = input.split("\n");
  const data = lines.map((line) => {
    if (!line) return;
    return line.split(":")[1].replaceAll(" ", "");
  });

  const race = {
    raceTime: Number(data[0]),
    recordDistance: Number(data[1]),
  };

  function countWins(race) {
    const { raceTime, recordDistance } = race;

    let wins = [];
    for (let i = 0; i < raceTime; i++) {
      const run = raceTime - i;
      const distance = run * i;
      if (distance > recordDistance) wins.push(i);
      // console.log("hold:", i, "run:", run, "distance:", distance);
    }
    return wins.length;
  }
  return countWins(race);
}
