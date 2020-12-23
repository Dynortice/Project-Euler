from euler.big_int import BigInt


def compute() -> int:
    return pow(BigInt(2), 7830457, 10000000000) * 28433 % 10000000000 + 1
