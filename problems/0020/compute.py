from math import prod
from euler.big_int import BigInt
from euler.numbers import digits_sum


def compute(n: int) -> int:
    return digits_sum(prod(map(BigInt, range(1, n))))
