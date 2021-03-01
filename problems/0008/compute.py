from math import prod


def compute(n: int, digits: str) -> int:
    digits = list(map(int, digits.replace('\n', '')))
    max_product = 0
    for i in range(len(digits) - n + 2):
        if 0 in digits[i: i + n]:
            continue
        cur_product = prod(digits[i: i + n])
        if cur_product > max_product:
            max_product = cur_product
    return max_product
