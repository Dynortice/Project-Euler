from euler.calculus import fibonacci_number, fibonacci_index


def compute(n: int) -> int:
    return int(fibonacci_number(fibonacci_index(n) + 2) / 2)
