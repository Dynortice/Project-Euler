from euler.big_int import BigInt


def compute(n: int) -> int:
    def is_palindrome(x: BigInt) -> bool:
        return x.str == x.str[::-1]

    result = 0
    for i in range(1, n + 1):
        number = BigInt(str(i))
        number += BigInt(number.str[::-1])
        j = 1
        while (j <= 50) and (not is_palindrome(number)):
            number += BigInt(number.str[::-1])
            j += 1
        if j > 50:
            result += 1
    return result
