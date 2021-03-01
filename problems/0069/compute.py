from math import sqrt
from euler.primes import prime_numbers


def compute(n: int) -> int:
    result = 1
    for prime in prime_numbers(int(sqrt(n))):
        result *= prime
        if result * prime >= n:
            return result
