export async function processPart1(input) {
  const max = {
    red: 12,
    green: 13,
    blue: 14,
  };

  const lines = input.split("\n");

  const gameHighs = lines.map((line) => {
    const parts = line.split(": ");
    const id = parts[0].split(" ")[1];
    const game = parts[1]?.split("; ") || [];

    let maxG = 0,
      maxR = 0,
      maxB = 0;

    game.forEach((pair) => {
      const sets = pair.split(", ");
      sets.forEach((set) => {
        const [countStr, color] = set.split(" ");
        const count = parseInt(countStr);

        if (color === "green") maxG = Math.max(maxG, count);
        if (color === "red") maxR = Math.max(maxR, count);
        if (color === "blue") maxB = Math.max(maxB, count);
      });
    });
    return { id: parseInt(id), green: maxG, red: maxR, blue: maxB };
  });

  let total = 0;
  gameHighs.forEach((game) => {
    if (game.green > max.green || game.red > max.red || game.blue > max.blue) return;
    if (game.id) total += game.id;
  });
  return total;
}
