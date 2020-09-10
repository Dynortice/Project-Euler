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


def number_to_digits(n: str) -> list:
    """
    Get list of digits of number
    :param n: integer number presented as string
    :return: list of integers digits of n
    """
    return list(map(int, n))


def add(a: str, b: str) -> str:
    """
    Adding two integer string-like numbers (for really big numbers)
    :param a: first term
    :param b: second term
    :return: string-like sum of a and b
    """
    a, b = number_to_digits(a)[::-1], number_to_digits(b)[::-1]
    if len(a) > len(b):
        b += [0] * (len(a) - len(b))
    elif len(b) > len(a):
        a += [0] * (len(b) - len(a))
    result = ''
    carry = 0
    for i in range(len(a)):
        carry += a[i] + b[i]
        result += str(carry % 10)
        carry //= 10
    if carry == 0:
        return result[::-1]
    else:
        return str(carry) + result[::-1]
