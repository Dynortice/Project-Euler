from euler.primes import prime_sieve


def compute() -> int:
    sieve = prime_sieve(1_000_000)
    primes = [i for (i, is_prime) in enumerate(sieve) if is_prime and i > 10]
    i, result, truncatable = 0, 0, 0
    for prime in primes:
        p = 10
        while p < prime:
            if sieve[prime % p] and sieve[prime // p]:
                p *= 10
            else:
                break
        else:
            truncatable += 1
            result += prime
            if truncatable == 11:
                break
        i += 1
    return result
