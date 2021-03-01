from collections.abc import Generator, Iterable
from math import sqrt


def prime_sieve(n: int) -> [bool]:
    """Get the sieve of primes below `n`

    Args:
        n: Index of last prime in list

    Returns:
        Boolean list with length n where index is number and boolean values is whether prime or not

    Examples:
        >>> prime_sieve(10)
        [False, False, True, True, False, True, False, True, False, False, False]
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


def prime_numbers(n: int) -> Generator:
    """Generate prime numbers below `n`

    Args:
        n: Number below of which prime numbers will generate

    Yields:
        Next prime number in range from 0 to n - 1

    Examples:
        >>> print(list(prime_numbers(20)))
        [2, 3, 5, 7, 11, 13, 17, 19]
    """
    for i, prime in enumerate(prime_sieve(n)):
        if prime:
            yield i


def is_prime(n: int) -> bool:
    """Check if number is prime

    Args:
        n: Number

    Returns:
        True if number is prime, False otherwise

    Examples:
        >>> print(is_prime(23))
        True
        >>> print(is_prime(22))
        False
    """
    if n < 2:
        return False
    elif n < 4:
        return True
    elif n % 2 == 0 or n % 3 == 0:
        return False
    for i in range(6, int(sqrt(n)) + 2, 6):
        if n % (i - 1) == 0 or n % (i + 1) == 0:
            return False
    return True


def smallest_prime_factor(n: int, primes: Iterable = None) -> int:
    """Get smallest prime factor of number

    Args:
        n: Number
        primes: Generator of prime numbers below at least sqrt(n)

    Returns:
        Smallest prime number which proper divides n

    Examples:
        >>> print(smallest_prime_factor(23))
        23
        >>> n = 22
        >>> primes = list(prime_numbers(int(sqrt(n))))
        >>> print(smallest_prime_factor(n, primes))
        2
    """
    if primes is None:
        primes = prime_numbers(int(sqrt(n)))
    for prime in primes:
        if n % prime == 0:
            return prime
    return n
