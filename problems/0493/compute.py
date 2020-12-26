def compute(n: int, k: int) -> float:
    result = 1
    for i, j in zip(range(n // 7 * 6 - k + 1, n - k + 1), range(n // 7 * 6 + 1, n + 1)):
        result *= i / j
    return round(7 * (1 - result), 9)
