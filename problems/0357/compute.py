from math import sqrt
from euler.primes import get_primality


def compute(n):
    sieve = get_primality(n)
    candidates = [i - 1 for i, is_prime in enumerate(sieve) if is_prime and (i - 1) % 4 != 0]
    result = 0
    for candidate in candidates:
        if not sieve[candidate // 2 + 2]:
            continue
        for i in range(3, int(sqrt(n)) + 1):
            if candidate % i != 0:
                continue
            elif not sieve[candidate // i + i]:
                break
        else:
            result += candidate
    return result
