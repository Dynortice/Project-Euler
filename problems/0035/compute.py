from euler.primes import get_primality


def compute(n: int) -> int:
    sieve = get_primality(n)
    primes = [i for (i, is_prime) in enumerate(sieve) if is_prime]
    result = 0
    for prime in primes:
        str_prime = str(prime)
        is_circular_prime = True
        for _ in range(len(str_prime)):
            str_prime = str_prime[1::] + str_prime[0]
            if not sieve[int(str_prime)]:
                is_circular_prime = False
                break
        if is_circular_prime:
            result += 1
    return result
