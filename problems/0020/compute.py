from euler.big_int import BigInt


def compute(n: int) -> int:
    result = BigInt("1")
    for i in range(1, n):
        result *= BigInt(str(i))
    return sum(map(int, result.str))
