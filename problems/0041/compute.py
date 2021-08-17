from euler.primes import prime_numbers


def compute() -> int:
    for prime in reversed(list(prime_numbers(7_654_321))):
        str_prime = str(prime)
        if set(str_prime) == set(map(str, range(1, len(str_prime) + 1))):
            return prime
