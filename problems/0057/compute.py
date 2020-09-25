from euler.big_int import BigInt


def compute(d: int, n: int) -> int:
    numerator, denominator = [BigInt("1")] * 2
    a, b = BigInt(str(d)), BigInt(str(d - 1))
    result = 0
    for _ in range(n):
        numerator, denominator = numerator + a * denominator, numerator + b * denominator
        if len(str(numerator)) != len(str(denominator)):
            result += 1
    return result
