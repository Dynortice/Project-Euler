from math import prod


def compute(n: int, k: int) -> float:
    return round(7 * (1 - prod((i - k) / i for i in range(n // 7 * 6 + 1, n + 1))), 9)
