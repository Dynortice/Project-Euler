from collections import Counter
from math import factorial, prod
from euler.big_int import BigInt


def compute(n: int, modulo: int) -> BigInt:
    def get_digits(k: int, limit: int) -> [[int]]:
        result = list()
        if k < 1:
            return result
        if k <= limit:
            result.append([k])
        for i in range(1, limit + 1):
            for j in get_digits(k - i, i):
                result.append([i] + j)
        return result

    factorials = dict()
    all_digits = pow(9, -1, modulo) * (pow(10, n, modulo) - 1) % modulo
    total = BigInt(0)
    for digit in range(1, 10):
        for other_digits in get_digits(digit, digit):
            len_digits = len(other_digits)
            if n - len_digits - 1 < 0:
                continue
            digits = Counter([digit] + other_digits)
            for m in digits:
                partial_digits = digits.copy()
                partial_digits[m] -= 1
                if len_digits not in factorials:
                    factorials[len_digits] = prod(BigInt(n - i - 1) for i in range(len_digits))
                multinomial = factorials[len_digits]
                for p in partial_digits.values():
                    multinomial //= factorial(p)
                total += all_digits * m * multinomial
        total %= modulo
    return total
