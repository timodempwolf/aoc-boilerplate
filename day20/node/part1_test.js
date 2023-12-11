import test from 'ava';
import { calculate } from './part1.js';

test('Task 1', t => {
  t.is(calculate("../example.txt"), "374")
})
