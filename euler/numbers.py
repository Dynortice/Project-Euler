from math import sqrt
from euler.big_int import BigInt
from euler.calculus import sum_geometric_series


def is_palindrome(n) -> bool:
    """
    Checking is the number a palindrome
    :param n: integer number converted to string
    :return: boolean value: true if n is palindrome else false
    """
    if isinstance(n, str):
        return n == n[::-1]
    elif isinstance(n, BigInt):
        return n.str == n.str[::-1]


def count_divisors(n: int) -> int:
    """
    Counting number of divisors of n
    :param n: integer number
    :return: number of divisors of n
    """
    factors = 1
    i = 2
    while i * i <= n:
        f = 1
        while n % i == 0:
            n /= i
            f += 1
        i += 1
        factors *= f
    if n > 1:
        factors *= 2
    return factors


def sum_proper_factors(n: int, primes: list) -> int:
    """
    Get sum of proper divisors of number
    :param n: integer number
    :param primes: list of primes numbers (until sqrt(n) as minimum)
    :return: sum of proper divisors
    """
    result = 1
    number = n
    for prime in primes:
        j = 1
        while number % prime == 0:
            number //= prime
            j += 1
        result *= sum_geometric_series(1, prime, j)
    if number > 1:
        result *= number + 1
    return result - n


def multiplicative_order(a: int, n: int) -> int:
    """
    Get multiplicative order of a modulo n
    :param a: integer number
    :param n: integer n
    :return: order of a in the multiplicative group of the units in the ring of the integers modulo n
    """
    i, k = 1, a
    while k != 1 and i < n:
        k = k * a % n
        i += 1
    return i


def is_perfect_square(n: int) -> bool:
    return int(sqrt(n)) ** 2 == n


def digits_sum(n: int) -> int:
    return sum(map(int, str(n)))


def gcd(a: int, b: int) -> int:
    if b == 0:
        return a
    else:
        return gcd(b, a % b)
