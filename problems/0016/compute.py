from euler.big_int import BigInt


def compute(n: int, p: int):
    return sum(map(int, (BigInt(str(n)) ** p).str))
