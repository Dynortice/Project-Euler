from euler.primes import get_primes


def compute() -> int:
    primes = get_primes(7654321)
    for prime in reversed(primes):
        str_prime = str(prime)
        if set(str_prime) == set(str(i) for i in range(1, len(str_prime) + 1)):
            return prime
