from math import sqrt
from euler.primes import get_primes
from euler.numbers import sum_proper_factors


def compute(n: int) -> int:
    sum_factors = [0] * (n + 1)
    primes = get_primes(int(sqrt(n)))
    result = 0
    for i in range(1, n + 1):
        sum_factors[i] = int(sum_proper_factors(i, primes))
    for i in range(2, n + 1):
        j = sum_factors[i]
        if j != i and j <= n and sum_factors[j] == i:
            result += i
    return result
