from math import ceil, log, sqrt


def compute(n: int) -> int:
    return int(ceil((log(10) * (n - 1) + log(5) / 2) / log((1 + sqrt(5)) / 2)))
