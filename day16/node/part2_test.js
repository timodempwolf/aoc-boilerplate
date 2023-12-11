import test from 'ava';
import { calculate } from './part2.js';

test('Task 2', t => {
  t.is(calculate("../example.txt"), "1030")
})
