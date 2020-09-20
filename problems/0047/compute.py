from euler.primes import get_primes


def compute(n: int) -> int:
    primes = get_primes(10 ** n // n)
    consecutive = 0
    i = 10 ** (n - 1)
    while True:
        if i not in primes:
            prime_factors = 0
            t = i
            for prime in primes:
                if t % prime == 0:
                    prime_factors += 1
                    t //= prime
                    if prime > t or t == 1 or prime_factors == n:
                        break
            if prime_factors == n:
                consecutive += 1
            else:
                consecutive = 0
        else:
            consecutive = 0
        if consecutive == n:
            return i - n + 1
        i += 1
