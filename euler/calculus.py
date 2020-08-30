import math


def sum_arithmetic_series(a: float, d: float, n: int) -> float:
    """
    :param a: first number in sequence
    :param d: common difference of series
    :param n: number of terms in sequence
    :return: sum of n first terms in arithmetic sequence
    """
    return n * (2 * a + d * (n - 1)) / 2


def fibonacci_number(n: int) -> int:
    """
    :param n: index of Fibonacci number
    :return: Fibonacci number with index n
    """
    return int((((1 + math.sqrt(5)) / 2) ** n - ((1 - math.sqrt(5)) / 2) ** n) / math.sqrt(5))


def fibonacci_index(n: int) -> int:
    """
    :param n: integer number
    :return: index of closest Fibonacci number below n
    """
    return int(math.log(n * math.sqrt(5) + 0.5, (math.sqrt(5) + 1) / 2))
