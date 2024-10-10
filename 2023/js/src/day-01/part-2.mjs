const replacements = {
  one: "1",
  two: "2",
  three: "3",
  four: "4",
  five: "5",
  six: "6",
  seven: "7",
  eight: "8",
  nine: "9",
  zero: "0",
};

export async function processPart2(input) {
  return input
    .split("\n")
    .map((str) => {
      const translated = str.replace(
        /(one|two|three|four|five|six|seven|eight|nine|zero)/g,
        (match) => replacements[match]
      );
      const nums = translated.match(/\d/g);
      if (nums) return parseInt(nums[0] + nums[nums.length - 1]);
      return 0;
    })
    .reduce((acc, cur) => acc + cur, 0);
}
