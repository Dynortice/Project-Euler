from euler.primes import prime_numbers
from euler.numbers import multiplicative_order


def compute(n: int) -> int:
    max_cycle, result = 0, 0
    for prime in list(prime_numbers(n))[2:]:
        cycle = multiplicative_order(10, prime)
        if cycle > max_cycle:
            max_cycle, result = cycle, prime
    return result
