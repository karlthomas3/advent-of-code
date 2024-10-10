export async function processPart2(input) {
  const lines = input.split("\n");

  const gameHighs = lines.map((line) => {
    const parts = line.split(": ");
    const id = parts[0].split(" ")[1];
    const game = parts[1]?.split("; ") || [];

    let curG = 0,
      curR = 0,
      curB = 0;

    game.forEach((pair) => {
      const sets = pair.split(", ");
      sets.forEach((set) => {
        const [countStr, color] = set.split(" ");
        const count = parseInt(countStr);

        if (color === "green") curG = Math.max(curG, count);
        if (color === "red") curR = Math.max(curR, count);
        if (color === "blue") curB = Math.max(curB, count);
      });
    });
    return { id: parseInt(id), green: curG, red: curR, blue: curB };
  });

  let total = 0;
  gameHighs.forEach((game) => {
    const power = game.red * game.green * game.blue;
    total += power;
  });
  return total;
}
