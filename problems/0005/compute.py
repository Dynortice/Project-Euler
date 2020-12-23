from math import log, prod
from euler.primes import get_primes


def compute(n: int) -> int:
    """
    Getting the smallest number that can be divided by each of the numbers from 1 to n
    :param n: Max divider for number
    :return: smallest number that can be divided by each of the numbers from 1 to n
    """
    return prod([prime ** int(log(n, prime)) for prime in get_primes(n)])
