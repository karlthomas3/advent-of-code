export async function processPart2(input) {
  const lines = input.split("\n");
  const cards = lines.map((line) => {
    const [card, list] = line.split(": ");
    if (!list) return;
    const parts = list.split("| ");

    const id = parseInt(card.replace("Card ", ""));
    const winners = parts[0].split(" ");
    const scratches = parts[1].split(" ");

    let points = 0;
    scratches.forEach((entry) => {
      if (entry == "") return;
      if (winners.includes(entry)) points++;
    });
    if (isFinite(id) && isFinite(points)) {
      return { id, points };
    } else return "wtf";
  });

  return score(cards);
}

function score(cards) {
  let instances = [];

  function process(index, copies) {
    if (index >= cards.length || copies === 0) return;

    let card = cards[index];
    if (!card) return;

    instances[card.id] = (instances[card.id] || 0) + copies;
    for (let i = 1; i <= card.points; i++) {
      process(index + i, copies);
    }
  }

  cards.forEach((card, index) => {
    if (card) process(index, 1);
  });

  return instances.reduce((acc, count) => acc + (count || 0), 0);
}
