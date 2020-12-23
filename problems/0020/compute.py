from math import prod
from euler.big_int import BigInt


def compute(n: int) -> int:
    return sum(map(int, prod(map(BigInt, range(1, n))).str))
