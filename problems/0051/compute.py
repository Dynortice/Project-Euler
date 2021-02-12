from collections import Counter
from euler.primes import get_primality


def compute(n: int) -> int:
    def get_family(candidate: str, digit: str) -> [int]:
        return [int(candidate.replace(digit, str(i))) for i in range(int(digit), 10)]

    def check_prime(candidate: int) -> bool:
        return sieve[candidate]

    sieve = get_primality(10 ** (n - 1))
    for number, is_prime in enumerate(sieve):
        if not is_prime or number < 10:
            continue
        most_common = Counter(str(number)[:-1]).most_common(1)
        if most_common[0][1] == 1 or int(most_common[0][0]) > 9 - n:
            continue
        family = get_family(str(number), most_common[0][0])
        if sum(map(check_prime, family)) >= n:
            return number
