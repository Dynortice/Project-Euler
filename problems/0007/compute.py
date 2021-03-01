from euler.primes import prime_numbers


def compute(n: int) -> int:
    return list(prime_numbers(n * 20))[n - 1]
