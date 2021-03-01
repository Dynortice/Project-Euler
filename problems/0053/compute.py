from math import comb


def compute(n: int, limit: int) -> int:
    result = 0
    for i in range(1, n + 1):
        for j in range(1, i // 2):
            if comb(i, j) > limit:
                result += i - 2 * j + 1
                break
    return result
