import assert from 'node:assert';
import test from 'node:test';
import { calculate } from './part1.js';

test('it works', () => {
  assert.strictEqual(calculate("../example.txt"), "fixme")
})
