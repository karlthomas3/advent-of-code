export async function processPart1(input) {
  return input
    .split("\n")
    .map((str) => {
      const nums = str.match(/\d/g);
      if (nums) return parseInt(nums[0] + nums[nums.length - 1]);
      return 0;
    })
    .reduce((acc, cur) => acc + cur, 0);
}
