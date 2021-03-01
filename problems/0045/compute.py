from math import sqrt
from euler.calculus import hexagonal_index, get_hexagonal


def compute(n: int) -> int:
    i = hexagonal_index(n) + 1
    while ((sqrt(48 * i ** 2 - 24 * i + 1) + 1) / 6) % 1 != 0:
        i += 1
    return get_hexagonal(i)
