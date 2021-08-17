from euler.big_int import BigInt
from euler.numbers import digits_sum


def compute(n: int, p: int) -> int:
    return digits_sum(BigInt(n) ** p)
