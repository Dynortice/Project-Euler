from euler.calculus import fibonacci_index, get_fibonacci


def compute(n: int) -> int:
    return int(get_fibonacci(fibonacci_index(n) + 2) / 2)
