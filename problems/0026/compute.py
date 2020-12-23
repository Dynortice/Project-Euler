from euler.primes import get_primes
from euler.numbers import multiplicative_order


def compute(n: int) -> int:
    primes = get_primes(n)[2:]  # get primes from 7
    max_cycle, result = 0, 0
    for prime in primes:
        cycle = multiplicative_order(10, prime)
        if cycle > max_cycle:
            max_cycle, result = cycle, prime
    return result
