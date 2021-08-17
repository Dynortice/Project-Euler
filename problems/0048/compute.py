def compute(n: int) -> int:
    return sum(pow(i, i, 10_000_000_000) for i in range(1, n + 1)) % 10_000_000_000
