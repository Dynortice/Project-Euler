from euler.numbers import count_divisor


def compute(n: int) -> int:
    i, triangle = 1, 1
    while count_divisor(triangle) < n:
        i += 1
        triangle += i
    return triangle
