from euler.primes import get_primality
from euler.numbers import is_perfect_square


def compute() -> int:
    sieve = get_primality(6000)
    primes = [i for (i, is_prime) in enumerate(sieve) if is_prime]
    i = 9
    while True:
        if not sieve[i]:
            j = 0
            while primes[j] < i:
                if is_perfect_square((i - primes[j]) // 2):
                    break
                j += 1
            else:
                return i
        i += 2
