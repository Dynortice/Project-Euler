from euler.big_int import BigInt


def compute() -> int:
    return pow(BigInt(2), 7_830_457, 10_000_000_000) * 28_433 % 10_000_000_000 + 1
