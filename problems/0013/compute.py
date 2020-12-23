from euler.big_int import BigInt


def compute(n: int, numbers: str) -> str:
    return sum(map(BigInt, numbers.split('\n')))[:n]
