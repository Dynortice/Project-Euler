def compute(n: int) -> int:
    return sum(map(lambda x: pow(x, x, 10 ** 10), range(1, n + 1))) % 10 ** 10
