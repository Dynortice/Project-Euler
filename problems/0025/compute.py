import math


def compute(n: int) -> int:
    return int(math.ceil((math.log(10) * (n - 1) + math.log(5) / 2) / math.log((1 + math.sqrt(5)) / 2)))
