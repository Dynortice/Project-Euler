from euler.big_int import BigInt


def compute(d: int, n: int) -> int:
    numerator, denominator = BigInt(1), BigInt(1)
    a, b = d, d - 1
    result = 0
    for _ in range(n):
        numerator, denominator = numerator + a * denominator, numerator + b * denominator
        if len(numerator) != len(denominator):
            result += 1
    return result
