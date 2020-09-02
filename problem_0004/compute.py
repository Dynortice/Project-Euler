from euler.numbers import is_palindrome


def compute(n: int) -> [int, [int, int]]:
    """
    :param n: number of digits in numbers that makes palindrome by product
    :return: list of palindrome number and list of two n-digits numbers that produce that product
    """
    result = 0
    numbers = [0, 0]
    for i in reversed(range(10 ** (n - 1), 10 ** n // 11 * 11 + 1)):
        for j in reversed(range(10 ** (n - 1), 10 ** n)):
            candidate = i * j
            if candidate <= result:
                break
            elif is_palindrome(str(candidate)):
                result = candidate
                numbers = [i, j]
    return [result, numbers]
