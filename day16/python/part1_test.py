import unittest
import part1


class TestStringMethods(unittest.TestCase):
    def test_calculate(self):
        self.assertEqual(part1.calculate("../example.txt"), "fixme")


if __name__ == "__main__":
    unittest.main()
