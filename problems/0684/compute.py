from euler.big_int import BigInt
from euler.calculus import fibonacci_numbers


def compute(n: int, m: int) -> BigInt:
    inverted_modulo = pow(2, -1, m)
    result = BigInt(-1)
    for f in fibonacci_numbers(n):
        a, b = f % 9 + 2, f // 9
        result += (((a * (a - 1) + 10) * pow(BigInt(10), b, m) - 2 * (a + 9 * b + 4)) * inverted_modulo) % m
    return result % m
