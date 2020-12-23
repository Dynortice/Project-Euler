from euler.primes import smallest_prime_factor


def compute(n: int) -> int:
    while True:
        prime = smallest_prime_factor(n)
        if prime < n:
            n //= prime
        else:
            return n
