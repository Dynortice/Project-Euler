from euler.big_int import BigInt
from euler.numbers import is_palindrome


def compute(n: int) -> int:
    result = 0
    for i in range(1, n + 1):
        number = BigInt(i)
        number += BigInt(number.str[::-1])
        j = 1
        while (j <= 50) and (not is_palindrome(number)):
            number += BigInt(number.str[::-1])
            j += 1
        if j > 50:
            result += 1
    return result
