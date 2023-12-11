import unittest
import part2


class TestStringMethods(unittest.TestCase):
    def test_calculate(self):
        self.assertEqual(part2.calculate("../example.txt"), 4)


if __name__ == "__main__":
    unittest.main()
