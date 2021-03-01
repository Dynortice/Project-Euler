from euler.calculus import sum_arithmetic_series


def compute(a: int, b: int, n: int) -> int:
    n -= 1
    ab = a * b
    return int(sum_arithmetic_series(a, a, n // a) + sum_arithmetic_series(b, b, n // b)
               - sum_arithmetic_series(ab, ab, n // ab))
