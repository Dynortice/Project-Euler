from euler.big_int import BigInt


def compute() -> int:
    result = 0
    for i in range(1, 10):
        j, n = 1, BigInt(i)
        while len(n) == j:
            result += 1
            j += 1
            n *= i
    return result
