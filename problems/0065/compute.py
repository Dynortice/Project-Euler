from euler.big_int import BigInt
from euler.numbers import digits_sum


def compute(n: int) -> int:
    current, previous = BigInt(1), BigInt(1)
    for i in range(2, n + 2):
        current, previous = current * (2 * i // 3 if i % 3 == 1 else 1) + previous, current
    return digits_sum(current)
