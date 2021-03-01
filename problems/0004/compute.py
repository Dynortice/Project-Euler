from euler.numbers import is_palindrome


def compute(n: int) -> int:
    result = 0
    for i in reversed(range(10 ** (n - 1), 10 ** n // 11 * 11 + 1)):
        for j in reversed(range(10 ** (n - 1), 10 ** n)):
            candidate = i * j
            if candidate <= result:
                break
            elif is_palindrome(candidate):
                result = candidate
    return result
