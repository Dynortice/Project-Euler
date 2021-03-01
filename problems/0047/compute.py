from euler.primes import prime_numbers


def compute(n: int) -> int:
    primes = list(prime_numbers(10 ** n // n))
    consecutive = 0
    i = 10 ** (n - 1)
    while True:
        if i in primes:
            consecutive = 0
        else:
            divisors = 0
            t = i
            for prime in primes:
                if t % prime == 0:
                    divisors += 1
                    t //= prime
                    if prime > t or t == 1 or divisors == n:
                        break
            if divisors == n:
                consecutive += 1
            else:
                consecutive = 0
        if consecutive == n:
            return i - n + 1
        i += 1
