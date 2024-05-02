import time


def calculate(path):
    with open(path, "r") as f:
        lines = f.readlines()
        result = 0
        for line in lines:
            # BEGIN TO DELETE
            result = len(line)
            # END TO DELETE
        return str(result)


if __name__ == "__main__":
    start = time.time_ns()
    result = calculate("../input.txt")
    end = time.time_ns()

    print(f"Result:\n{result.rstrip(" \t\r\n")}")
    print(f"Execution time: {(end - start)/1000000:.3f} ms")
