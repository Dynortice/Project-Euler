from math import isqrt
from euler.primes import prime_numbers
from euler.numbers import sum_proper_divisors


def compute(n: int) -> int:
    sum_factors = [0] * (n + 1)
    primes = list(prime_numbers(isqrt(n)))
    result = 0
    for i in range(1, n + 1):
        sum_factors[i] = sum_proper_divisors(i, primes)
    for i in range(2, n + 1):
        j = sum_factors[i]
        if j != i and j <= n and sum_factors[j] == i:
            result += i
    return result
