def is_palindrome(n: str) -> bool:
    """
    Checking is the number a palindrome
    :param n: integer number converted to string
    :return: boolean value: true if n is palindrome else false
    """
    return n == n[::-1]


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
