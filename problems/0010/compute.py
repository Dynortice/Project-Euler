from euler.primes import prime_numbers


def compute(n: int) -> int:
    return sum(prime_numbers(n))
