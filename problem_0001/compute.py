from euler.calculus import sum_arithmetic_series


def compute(a: int, b: int, n: int) -> int:
    n -= 1
    return int(sum([sum_arithmetic_series(a, a, n // a),
                    sum_arithmetic_series(b, b, n // b),
                    - sum_arithmetic_series(a * b, a * b, n // (a * b))]))
