from math import sqrt
from euler.primes import get_primes


def compute(n: int) -> int:
    result = 1
    for prime in get_primes(int(sqrt(n))):
        result *= prime
        if result * prime >= n:
            return result
