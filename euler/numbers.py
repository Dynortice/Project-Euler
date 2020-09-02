def is_palindrome(n: str) -> bool:
    """
    Checking is the number a palindrome
    :param n: integer number converted to string
    :return: boolean value: true if n is palindrome else false
    """
    return n == n[::-1]
