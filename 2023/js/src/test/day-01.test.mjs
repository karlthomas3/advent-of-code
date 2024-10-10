import assert from "node:assert";
import test from "node:test";

import { processPart1 } from "../day-01/part-1.mjs";
import { processPart2 } from "../day-01/part-2.mjs";

test("day 1", async (t) => {
  const input = "some input\n";

  await t.test("part 1", async (t) => {
    assert.strictEqual(await processPart1(input), "some input\n");
  });

  await t.test("part 2", async (t) => {
    assert.strictEqual(await processPart2(input), "some input\n");
  });
});
