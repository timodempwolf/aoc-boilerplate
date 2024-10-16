import unittest
import part1


class TestStringMethods(unittest.TestCase):
    def test_calculate(self):
        expected = "fixme"
        self.assertEqual(part1.calculate("../example.txt"), expected)


if __name__ == "__main__":
    unittest.main()
