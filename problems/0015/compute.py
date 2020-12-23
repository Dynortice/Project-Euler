from math import comb


def compute(n: int) -> int:
    return comb(2 * n, n)
