import { expect, test } from "bun:test";
import { calculate } from "./part2";

test('it works', async () => {
  const expected = "fixme"
  const actual = await calculate("../example2.txt")
  expect(actual).toBe(expected)
})
