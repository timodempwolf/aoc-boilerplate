import time


def calculate(path):
    with open(path, "r") as f:
        lines = f.readlines()
        result = 0
        for line in lines:
            print(line)
        return str(result)


if __name__ == "__main__":
    start = time.time_ns()
    result = calculate("../input.txt")
    end = time.time_ns()
    if result[len(result) - 1] == "\n":
        result = result[: len(result) - 1]
    print(f"Result:\n{result}")
    print(f"Execution Time: {(end - start)/1000000:.3f} ms")
