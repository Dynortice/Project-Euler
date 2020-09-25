from math import sqrt


def compute(n: float) -> int:
    def is_prime(x: int) -> bool:
        if x == 3:
            return True
        if not ((x % 6 == 1) or (x % 6 == 5)):
            return False
        for i in range(6, int(sqrt(x)), 12):
            if (x % (i - 1) == 0) or (x % (i + 1) == 0) or (x % (i + 7) == 0):
                return False
        return True
    j = 3
    primes = 0
    while True:
        k = (j - 3) * j + 3
        primes += sum([is_prime(k), is_prime(k + j - 1), is_prime(k + 2 * j - 2)])
        if primes / (2 * j - 1) < n:
            return j
        j += 2
