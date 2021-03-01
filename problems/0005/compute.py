from math import log, prod
from euler.primes import prime_numbers


def compute(n: int) -> int:
    return prod([prime ** int(log(n, prime)) for prime in prime_numbers(n)])
