from math import sqrt, log
from euler.big_int import BigInt


def sum_arithmetic_series(a: float, d: float, n: int) -> float:
    """
    Find the sum of arithmetic sequence

    :param a: first number in sequence
    :param d: common difference of sequence
    :param n: number of terms in sequence
    :return: sum of n first terms in arithmetic sequence
    """
    return n * (2 * a + d * (n - 1)) / 2


def sum_geometric_series(a: float, r: float, n: int) -> float:
    """
    Find the sum of geometric sequence

    :param a: first term in sequence
    :param r: common ratio of sequence
    :param n: number of terms in sequence
    :return: sum of n first terms in geometric sequence
    """
    return a * (r ** n - 1) / (r - 1)


def fibonacci_number(n: int) -> int:
    """
    Get nth Fibonacci number

    :param n: index of Fibonacci number
    :return: Fibonacci number with index n
    """
    return int((((1 + sqrt(5)) / 2) ** n - ((1 - sqrt(5)) / 2) ** n) / sqrt(5))


def fibonacci_index(n: int) -> int:
    """
    Get index of closest Fibonacci number

    :param n: integer number
    :return: index of closest Fibonacci number below n
    """
    return int(log(n * sqrt(5) + 0.5, (sqrt(5) + 1) / 2))


def fibonacci_generator(n: int):
    f_prev, f_curr = BigInt(), BigInt(1)
    yield f_prev
    yield f_curr
    for i in range(2, n + 1):
        f_prev, f_curr = f_curr, f_prev + f_curr
        yield f_curr


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


def get_triangle(n: int) -> int:
    return n * (n + 1) // 2


def get_pentagonal(n: int) -> int:
    return n * (3 * n - 1) // 2


def get_hexagonal(n: int) -> int:
    return n * (2 * n - 1)


def is_triangle(n: int) -> bool:
    return sqrt(8 * n + 1) % 2 == 1


def is_pentagonal(n: int) -> bool:
    return sqrt(24 * n + 1) % 6 == 5


def is_hexagonal(n: int) -> bool:
    return sqrt(8 * n + 1) % 4 == 3


def triangle_index(n: int) -> int:
    return int(sqrt(8 * n + 1) + 1) // 2


def pentagonal_index(n: int) -> int:
    return int(sqrt(24 * n + 1) + 1) // 6


def hexagonal_index(n: int) -> int:
    return int(sqrt(8 * n + 1) + 1) // 4
