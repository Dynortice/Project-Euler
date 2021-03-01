from math import sqrt
from euler.primes import prime_numbers
from euler.numbers import sum_proper_divisors


def compute() -> int:
    n = 28123
    primes = list(prime_numbers(int(sqrt(n))))
    abundant_sieve, not_expressible = [False] * (n + 1), [True] * (n + 1)
    result = 0
    for i in range(1, n + 1):
        abundant_sieve[i] = i < sum_proper_divisors(i, primes)
        for j in range(1, i // 2 + 1):
            if abundant_sieve[j] and abundant_sieve[i - j]:
                not_expressible[i] = False
                break
        if not_expressible[i]:
            result += i
    return result
