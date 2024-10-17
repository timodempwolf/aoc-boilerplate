import time
from utils import print_execution_time


def calculate(path: str) -> str:
    with open(path, "r") as f:
        lines = f.readlines()
        result = 0
        for line in lines:
            line = line.rstrip()
            # BEGIN TO DELETE
            result = len(line)
            # END TO DELETE
        return str(result)


if __name__ == "__main__":
    start = time.time_ns()
    result = calculate("../input.txt")
    end = time.time_ns()

    print(f"Result:\n{result.rstrip()}")
    print_execution_time(start, end)
