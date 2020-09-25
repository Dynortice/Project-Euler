from math import sqrt


def get_primality(n: int) -> list:
    """
    Get the sieve of primes below n
    :param n: integer number
    :return: boolean list with length n where index is number and boolean values is whether prime or not
    """
    sieve = [True] * (n + 1)
    sieve[0] = sieve[1] = False
    for i in range(4, n + 1, 2):
        sieve[i] = False
    for i in range(3, int(sqrt(n)) + 1, 2):
        if sieve[i]:
            for j in range(i * i, n + 1, 2 * i):
                sieve[j] = False
    return sieve


def get_primes(n: int) -> list:
    """
    Get vector of primes below n
    :param n: integer number
    :return: list with primes below n
    """
    return [i for (i, is_prime) in enumerate(get_primality(n)) if is_prime]


def smallest_prime_factor(n: int) -> int:
    """
    Get smallest prime factor of number
    :param n: integer number
    :return: smallest prime factor of n
    """
    primes = get_primes(int(math.sqrt(n)))
    for prime in primes:
        if n % prime == 0:
            return prime
    return n
