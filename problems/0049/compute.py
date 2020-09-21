from euler.primes import get_primality


def compute() -> str:
    sieve = get_primality(10000)
    primes = [i for (i, is_prime) in enumerate(sieve) if is_prime and i > 4817]
    for prime in primes:
        first, third = prime - 3330, prime + 3330
        if sieve[first] and sieve[third] and set(str(first)) == set(str(prime)) == set(str(third)):
            return str(first) + str(prime) + str(third)
