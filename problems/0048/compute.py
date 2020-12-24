def compute(n: int) -> int:
    return sum(pow(i, i, 10 ** 10) for i in range(1, n + 1)) % 10 ** 10
