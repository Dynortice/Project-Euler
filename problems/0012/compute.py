from euler.numbers import count_divisors


def compute(n: int) -> int:
    i, triangle = 1, 1
    while count_divisors(triangle) < n:
        i += 1
        triangle += i
    return triangle
