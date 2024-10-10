export async function processPart1(input) {
  const lines = input.split("\n");
  const numbers = lines.map((line) => {
    const matches = line.match(/\d+/g);
    return matches ? matches.map(Number) : [];
  });

  const races = numbers[0].map((number, index) => {
    const raceTime = number;
    const recordDistance = numbers[1][index];
    return { raceTime, recordDistance };
  });

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
  const winArr = races.map((race) => countWins(race));
  const marginOfError = winArr.reduce((a, b) => a * b, 1);
  return marginOfError;
}
