from euler.primes import prime_sieve


def compute(n: int) -> int:
    sieve = prime_sieve(n)
    primes = [i for (i, is_prime) in enumerate(sieve) if is_prime]
    result = 0
    for prime in primes:
        str_prime = str(prime)
        for _ in range(len(str_prime)):
            str_prime = str_prime[1::] + str_prime[0]
            if not sieve[int(str_prime)]:
                break
        else:
            result += 1
    return result
