from collections import Counter
from math import factorial
from euler.big_int import BigInt


def compute(n: int, modulo: int) -> BigInt:
    def digit_sum(k: int, limit: int) -> [[int]]:
        result = list()
        if k < 1:
            return result
        if k <= limit:
            result.append([k])
        for i in range(1, limit + 1):
            for j in digit_sum(k - i, i):
                result.append([i] + j)
        return result

    def reverted_factorial(k: int) -> BigInt:
        if k not in factorials:
            result = BigInt(1)
            for i in range(k):
                result *= n - i - 1
            factorials[k] = result
        return factorials[k]

    factorials = dict()
    all_digits = pow(9, -1, modulo) * (pow(10, n, modulo) - 1) % modulo
    total = BigInt(0)
    for digit in range(1, 10):
        for other_digits in digit_sum(digit, digit):
            if n - len(other_digits) - 1 < 0:
                continue
            digits = Counter([digit] + other_digits)
            for m in digits:
                partial_digits = digits.copy()
                partial_digits[m] -= 1
                multinomial = reverted_factorial(len(other_digits))
                for p in partial_digits.values():
                    multinomial //= factorial(p)
                total += all_digits * m * multinomial
                print(digit, other_digits, digits, m, multinomial, all_digits, total)
        total %= modulo
    return total

compute(3, 10 ** 16)
compute(7, 10 ** 16)