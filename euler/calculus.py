from typing import Iterator, Union
from math import isqrt, log, sqrt
from euler.big_int import BigInt


def sum_arithmetic_series(a: Union[int, float], d: Union[int, float], n: int) -> float:
    """Get sum of first `n` terms of arithmetic series

    Args:
        a: First number in series
        d: Common difference of series
        n: Number of terms in series

    Examples:
        >>> print(sum_arithmetic_series(1, 2, 3))
        9.0
        >>> print(sum_arithmetic_series(0.5, 0.75, 3))
        3.75
    """
    return n * (2 * a + d * (n - 1)) / 2


def sum_geometric_series(a: Union[int, float], r: Union[int, float], n: int) -> float:
    """Get sum of `n` first terms of geometric series

    Args:
        a: First number in series
        r: Common ratio of series
        n: Number of terms in series

    Examples:
        >>> print(sum_geometric_series(1, 2, 3))
        7.0
        >>> print(sum_geometric_series(0.5, 0.75, 3))
        1.15625
    """
    return a * (r ** n - 1) / (r - 1)


def fibonacci_numbers(n: int, t: type = int) -> Iterator[Union[int, BigInt]]:
    """Generate `n` first Fibonacci numbers `OEIS A000045 <https://oeis.org/A000045>`_

    Args:
        n: Number of Fibonacci numbers
        t: Type of numbers

    Yields:
        The next Fibonacci number in the range of 0 to `n`

    Examples:
        >>> print(list(fibonacci_numbers(10)))
        [0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55]
        >>> print(list(fibonacci_numbers(10, BigInt)))
        [0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55]
    """
    f_previous, f_current = t(0), t(1)
    yield f_previous
    yield f_current
    for i in range(2, n + 1):
        f_previous, f_current = f_current, f_previous + f_current
        yield f_current


def get_fibonacci(n: int) -> int:
    """Get `n`-th Fibonacci number

    Args:
        n: Index of Fibonacci number

    Examples:
        >>> print(get_fibonacci(10))
        55
    """
    return int(((1 + sqrt(5)) / 2) ** n / sqrt(5) + 0.5)


def fibonacci_index(n: int) -> int:
    """Get index of `n` in Fibonacci sequence

    Returns:
        Index of Fibonacci number n. If n isn't Fibonacci number, returns index of closest Fibonacci number below n

    Examples:
        `n` is Fibonacci number

        >>> print(fibonacci_index(55))
        10

        `n` isn't Fibonacci number

        >>> print(fibonacci_index(54))
        9
    """
    return int(log(n * sqrt(5) + 0.5, (sqrt(5) + 1) / 2))


def len_collatz_chain(n: int, hashmap: dict[int, int]) -> int:
    """Get length of Collatz chain

    Args:
        n: Starting number
        hashmap: Collatz chains lengths

    Examples:
        >>> print(len_collatz_chain(13, {1: 1}))
        10

    Notes:
        The functions uses memoization, so hashmap is required.
    """
    if n not in hashmap:
        if n % 2:
            hashmap[n] = 2 + len_collatz_chain((3 * n + 1) // 2, hashmap)
        else:
            hashmap[n] = 1 + len_collatz_chain(n // 2, hashmap)
    return hashmap[n]


def triangular_numbers(n: int) -> Iterator[int]:
    """Generate `n` first numbers in triangular numbers sequence `OEIS A000217 <https://oeis.org/A000217>`_

    Args:
        n: Number of triangular numbers

    Yields:
        The next triangular number in the range of 0 to `n`

    Examples:
        >>> print(list(triangular_numbers(10)))
        [0, 1, 3, 6, 10, 15, 21, 28, 36, 45, 55]
    """
    t = 0
    yield t
    for i in range(1, n + 1):
        t += i
        yield t


def get_triangular(n: int) -> int:
    """Get `n`-th triangular number

    Args:
        n: Index of triangular number

    Examples:
        >>> print(get_triangular(10))
        55
    """
    return n * (n + 1) // 2


def triangular_index(n: int) -> int:
    """Get index of `n` in triangular sequence

    Returns:
        Index of triangular number n. If n isn't triangular number, returns index of closest triangular number below n

    Examples:
        `n` is triangular number

        >>> print(triangular_index(55))
        10

        `n` isn't triangular number

        >>> print(triangular_index(54))
        9
    """
    return (isqrt(8 * n + 1) - 1) // 2


def is_triangular(n: int) -> bool:
    """Check if number is triangular

    Returns:
        True if number is triangular, False otherwise

    Examples:
        >>> is_triangular(55)
        True
        >>> is_triangular(54)
        False
    """
    return sqrt(8 * n + 1) % 2 == 1


def square_numbers(n: int) -> Iterator[int]:
    """Generate `n` first numbers in square numbers sequence `OEIS A000290 <https://oeis.org/A000290>`_

    Args:
        n: Number of square numbers

    Yields:
        The next square number in the range of 0 to `n`

    Examples:
        >>> print(list(square_numbers(10)))
        [0, 1, 4, 9, 16, 25, 36, 49, 64, 81, 100]
    """
    t = 0
    yield t
    for i in range(1, 2 * n + 1, 2):
        t += i
        yield t


def get_square(n: int) -> int:
    """Get `n`-th square number

    Args:
        n: Index of square number

    Examples:
        >>> print(get_square(100))
        100
    """
    return n * n


def square_index(n: int) -> int:
    """Get index of `n` in square sequence

    Returns:
        Index of square number n. If n isn't square number, returns index of closest square number below n

    Examples:
        `n` is square number

        >>> print(square_index(100))
        10

        `n` isn't square number

        >>> print(triangular_index(99))
        9
    """
    return isqrt(n)


def is_square(n: int) -> bool:
    """Check if number is square

    Returns:
        True if number is square, False otherwise

    Examples:
        >>> is_square(55)
        True
        >>> is_square(54)
        False
    """
    return sqrt(n) % 1 == 0


def pentagonal_numbers(n: int) -> Iterator[int]:
    """Generate `n` first numbers in pentagonal numbers sequence `OEIS A000326 <https://oeis.org/A000326>`_

    Args:
        n: Number of pentagonal numbers

    Yields:
        The next pentagonal number in the range of 0 to `n`

    Examples:
        >>> print(list(pentagonal_numbers(10)))
        [0, 1, 5, 12, 22, 35, 51, 70, 92, 117, 145]
    """
    p = 0
    yield p
    for i in range(1, 3 * n + 1, 3):
        p += i
        yield p


def get_pentagonal(n: int) -> int:
    """Get `n`-th pentagonal number

    Args:
        n: Index of pentagonal number

    Examples:
        >>> print(get_pentagonal(10))
        145
    """
    return n * (3 * n - 1) // 2


def pentagonal_index(n: int) -> int:
    """Get index of `n` in pentagonal sequence

    Returns:
        Index of pentagonal number n. If n isn't pentagonal number, returns index of closest pentagonal number below n

    Examples:
        `n` is pentagonal number

        >>> print(pentagonal_index(145))
        10

        `n` isn't triangular number

        >>> print(pentagonal_index(144))
        9
    """
    return (isqrt(24 * n + 1) + 1) // 6


def is_pentagonal(n: int) -> bool:
    """Check if number is pentagonal

    Returns:
        True if number is pentagonal, False otherwise

    Examples:
        >>> is_pentagonal(145)
        True
        >>> is_pentagonal(144)
        False
    """
    return sqrt(24 * n + 1) % 6 == 5


def hexagonal_numbers(n: int) -> Iterator[int]:
    """Generate `n` first numbers in hexagonal numbers sequence `OEIS A000384 <https://oeis.org/A000384>`_

    Args:
        n: Number of hexagonal numbers

    Yields:
        The next hexagonal number in the range of 0 to `n`

    Examples:
        >>> print(list(hexagonal_numbers(10)))
        [0, 1, 6, 15, 28, 45, 66, 91, 120, 153, 190]
    """
    p = 0
    yield p
    for i in range(1, 4 * n + 1, 4):
        p += i
        yield p


def get_hexagonal(n: int) -> int:
    """Get `n`-th hexagonal number

    Args:
        n: Index of hexagonal number

    Examples:
        >>> print(get_hexagonal(10))
        190
    """
    return n * (2 * n - 1)


def hexagonal_index(n: int) -> int:
    """Get index of `n` in hexagonal sequence

    Returns:
        Index of hexagonal number n. If n isn't hexagonal number, returns index of closest hexagonal number below n

    Examples:
        `n` is hexagonal number

        >>> print(hexagonal_index(190))
        10

        `n` isn't hexagonal number

        >>> print(hexagonal_index(189))
        9
    """
    return (isqrt(8 * n + 1) + 1) // 4


def is_hexagonal(n: int) -> bool:
    """Check if number is hexagonal

    Returns:
        True if number is hexagonal, False otherwise

    Examples:
        >>> is_hexagonal(190)
        True
        >>> is_hexagonal(189)
        False
    """
    return sqrt(8 * n + 1) % 4 == 3


def champernowne_digits(n: int) -> int:
    """Get number of digits formed by `n`-digit numbers in Champernowne constant

    Examples:
        >>> print(champernowne_digits(3))
        2889
    """
    return (10 ** n * (9 * n - 1) + 1) // 9
