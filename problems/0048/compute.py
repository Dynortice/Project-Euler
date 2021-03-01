def compute(n: int) -> int:
    return sum(pow(i, i, 10000000000) for i in range(1, n + 1)) % 10000000000
