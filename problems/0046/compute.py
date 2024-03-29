from euler.primes import prime_sieve
from euler.calculus import is_square


def compute() -> int:
    sieve = prime_sieve(6_000)
    primes = [i for (i, is_prime) in enumerate(sieve) if is_prime]
    i = 9
    while True:
        if not sieve[i]:
            j = 0
            while primes[j] < i:
                if is_square((i - primes[j]) // 2):
                    break
                j += 1
            else:
                return i
        i += 2
