import { expect, test } from "bun:test";
import { calculate } from "./part1";

test('it works', async () => {
  const expected = "fixme"
  const actual = await calculate("../example.txt")
  expect(actual).toBe(expected)
})
