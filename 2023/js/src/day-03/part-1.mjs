export async function processPart1(input) {
  const isSymbol = (char) => char !== "." && isNaN(parseInt(char));

  const lines = input.split("\n");
  const rows = lines.map((line) => {
    const row = line.split("");
    console.log(row);
    return row;
  });
  return "Fuck that noise";
}

function getNum(row) {}
