from math import factorial


def compute(n: int, digits: list) -> str:
    l = len(digits)
    result = ''
    remain = n - 1
    for i in range(1, l + 1):
        order = factorial(l - i)
        j = remain // order
        result += str(digits[j])
        remain %= order
        del digits[j]
    return result
