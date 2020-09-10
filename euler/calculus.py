import math


def sum_arithmetic_series(a: float, d: float, n: int) -> float:
    """
    Find the sum of arithmetic sequence
    :param a: first number in sequence
    :param d: common difference of series
    :param n: number of terms in sequence
    :return: sum of n first terms in arithmetic sequence
    """
    return n * (2 * a + d * (n - 1)) / 2


def fibonacci_number(n: int) -> int:
    """
    Get nth Fibonacci number
    :param n: index of Fibonacci number
    :return: Fibonacci number with index n
    """
    return int((((1 + math.sqrt(5)) / 2) ** n - ((1 - math.sqrt(5)) / 2) ** n) / math.sqrt(5))


def fibonacci_index(n: int) -> int:
    """
    Get index of closest Fibonacci number
    :param n: integer number
    :return: index of closest Fibonacci number below n
    """
    return int(math.log(n * math.sqrt(5) + 0.5, (math.sqrt(5) + 1) / 2))


def len_collatz_chain(n: int, hashmap: dict) -> int:
    """
    Get length of Collatz chain
    :param n: starting number
    :param hashmap: dictionary with Collatz chains lengths
    :return: length of Collatz chain for n
    """
    if n not in hashmap:
        hashmap[n] = 1 + len_collatz_chain(n // 2, hashmap) if n % 2 == 0 else 2 + len_collatz_chain((3 * n + 1) // 2, hashmap)
    return hashmap[n]
