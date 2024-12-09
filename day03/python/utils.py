def print_execution_time(start, end):
    time = end - start
    if time > 1000 * 1000 * 1000 * 60:
        print(f"Execution time: {time/(1000 * 1000 * 1000 * 60):.3f} min")
    elif time > 1000 * 1000 * 1000:
        print(f"Execution time: {time/(1000 * 1000 * 1000):.3f} s")
    elif time > 1000 * 1000:
        print(f"Execution time: {time/(1000 * 1000):.3f} ms")
    elif time > 1000:
        print(f"Execution time: {time/1000:.3f} μs")
    else:
        print(f"Execution time: {time:.3f} ns")
