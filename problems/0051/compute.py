from collections import Counter
from euler.primes import prime_sieve


def compute(n: int) -> int:
    sieve = prime_sieve(10 ** (n - 1))
    for number, is_prime in enumerate(sieve):
        if not is_prime or number < 10:
            continue
        most_common = Counter(str(number)[:-1]).most_common(1)
        if most_common[0][1] == 1 or int(most_common[0][0]) > 9 - n:
            continue
        family = [int(str(number).replace(most_common[0][0], str(i))) for i in range(int(most_common[0][0]), 10)]
        if sum([sieve[i] for i in family]) >= n:
            return number
