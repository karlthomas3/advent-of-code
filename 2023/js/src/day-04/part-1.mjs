export async function processPart1(input) {
  const lines = input.split("\n");
  const cards = lines.map((line) => {
    const [card, list] = line.split(": ");
    if (!list) return;
    const parts = list.split("| ");

    const id = card.replace("Card ", "");
    const winners = parts[0].split(" ");
    const scratches = parts[1].split(" ");

    let points = 0;
    let multiplier = 1;
    scratches.forEach((entry) => {
      if (entry == "") return;
      if (winners.includes(entry)) {
        points = multiplier;
        multiplier *= 2;
      }
    });
    return isFinite(points) ? points : 0;
  });
  // console.log(cards);
  let total = 0;
  cards.forEach((point) => {
    if (isFinite(point)) total += point;
  });
  return total;
}
