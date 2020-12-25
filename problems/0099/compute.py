from math import log10


def compute(path: str) -> int:
    base_exp = [tuple(map(int, i.split(','))) for i in open(path).read().split('\n')]
    max_exponent = 0
    result = 0
    for i in range(len(base_exp)):
        base, exponent = base_exp[i]
        exponent = log10(base) * exponent
        if exponent > max_exponent:
            max_exponent = exponent
            result = i
    return result
