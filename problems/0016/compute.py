from euler.big_int import BigInt


def compute(n: int, p: int):
    return sum((BigInt(str(n)) ** p).digits)
