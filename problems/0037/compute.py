from euler.primes import get_primality


def compute() -> int:
    def check_truncatable_prime(n: int) -> bool:
        p = 10
        while p < n:
            if sieve[n % p] and sieve[n // p]:
                p *= 10
            else:
                return False
        return True
    sieve = get_primality(1000000)
    primes = [i for (i, is_prime) in enumerate(sieve) if is_prime and i > 10]
    truncatable_primes = 0
    i = 0
    result = 0
    while truncatable_primes < 11:
        if check_truncatable_prime(primes[i]):
            truncatable_primes += 1
            result += primes[i]
        i += 1
    return result
