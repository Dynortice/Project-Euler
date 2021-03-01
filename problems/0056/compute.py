from euler.big_int import BigInt
from euler.math import fast_max
from euler.numbers import digits_sum


def compute(n: int) -> int:
    result = 0
    for a in range(n - 5, n):
        number = BigInt(1)
        for b in range(1, n):
            number *= BigInt(a)
            result = fast_max(result, digits_sum(number))
    return result
