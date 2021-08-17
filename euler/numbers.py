from typing import Iterable, Iterator, Union
from math import isqrt
from euler.big_int import BigInt
from euler.calculus import sum_geometric_series
from euler.primes import prime_numbers


def is_palindrome(n: Union[int, BigInt]) -> bool:
    """Check if number is palindrome

    Args:
        n: Number

    Returns:
        True if number is palindrome, False otherwise

    Examples:
        >>> print(is_palindrome(123321))
        True
        >>> print(is_palindrome(123456))
        False
        >>> print(is_palindrome(BigInt(123321)))
        True
        >>> print(is_palindrome(BigInt(123456)))
        False
    """
    if isinstance(n, int):
        n = str(n)
        return n == n[::-1]
    elif isinstance(n, BigInt):
        return n.str == n.str[::-1]


def count_divisors(n: int) -> int:
    """Get number of divisors of `n`

    Args:
        n: Number

    Returns:
        Number of divisors of n

    Examples:
        >>> print(count_divisors(23))
        2
        >>> print(count_divisors(284))
        6
    """
    divisors = 1
    i = 2
    while i * i <= n:
        f = 1
        while n % i == 0:
            n /= i
            f += 1
        i += 1
        divisors *= f
    if n > 1:
        divisors *= 2
    return divisors


def sum_proper_divisors(n: int, primes: Iterable[int] = None) -> int:
    """Get sum of proper divisors of `n`

    Args:
        n: Number
        primes: Generator of prime numbers below at least isqrt(n)

    Returns:
        Sum of proper divisors of n (except n)

    Examples:
        >>> print(sum_proper_divisors(23))
        1
        >>> n = 284
        >>> primes = prime_numbers(isqrt(n))
        >>> print(sum_proper_divisors(n, primes))
        6
    """
    if primes is None:
        primes = prime_numbers(isqrt(n))
    result = 1
    number = n
    for prime in primes:
        j = 1
        while number % prime == 0:
            number //= prime
            j += 1
        result *= int(sum_geometric_series(1, prime, j))
    if number > 1:
        result *= number + 1
    return result - n


def get_digits(n: Union[int, BigInt]) -> Iterator[int]:
    """Get digits of number

    Args:
        n: Number

    Yields:
        Next digit of number n

    Examples:
        >>> print(list(get_digits(123)))
        [1, 2, 3]
        >>> print(list(BigInt(123456)))
        [1, 2, 3, 4, 5, 6]
    """
    return map(int, str(n))


def digits_sum(n: Union[int, BigInt]) -> int:
    """Get sum of digits in number

    Args:
        n: Number

    Returns:
        Sum of digits in number

    Examples:
        >>> digits_sum(123)
        6
        >>> digits_sum(BigInt(123456))
        21

    """
    return sum(get_digits(n))


def multiplicative_order(n: int, m: int) -> int:
    """Get multiplicative order of `n` modulo `m`

    Args:
        n, m: Numbers

    Returns:
        Order of n in the multiplicative group of the units in the ring of the integers modulo m

    Examples:
        >>> print(multiplicative_order(16, 7))
        3

    """
    i, k = 1, n
    while k != 1 and i < m:
        k = k * n % m
        i += 1
    return i


def gcd(a: int, b: int) -> int:
    """Get greater common divisor (GCD) of two numbers

    Args:
        a, b: Numbers

    Returns:
        GCD of a and b

    Examples:
        >>> gcd(16, 28)
        4
    """
    return gcd(b, a % b) if b else a


def is_s_number(a: int, b: int) -> bool:
    """Check if number is S-number, that is a perfect square and its square root can be obtained by splitting the
    decimal representation of `n` into 2 or more numbers then adding the numbers.

    Args:
        a: Number
        b: Square of a

    Examples:
        >>> print(is_s_number(99, 9801))
        True
        >>> print(is_s_number(5, 25))
        False
    """
    if a > b:
        return False
    elif a == b:
        return True
    m = 10
    while m < b:
        quotient, remainder = b // m, b % m
        if remainder < a and is_s_number(a - remainder, quotient):
            return True
        m *= 10
    else:
        return False
