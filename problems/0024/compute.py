from math import factorial


def compute(n: int, digits: list) -> str:
    k = len(digits)
    result = ''
    remain = n - 1
    for i in range(1, k + 1):
        order = factorial(k - i)
        j = remain // order
        result += str(digits[j])
        remain %= order
        del digits[j]
    return result
