from euler.calculus import champernowne_digits


def compute(n: int) -> int:
    result = 1
    for i in range(n):
        j, k = 10 ** i, 0
        while champernowne_digits(k + 1) < j:
            k += 1
        k += 1
        remainder = j - champernowne_digits(k - 1)
        number = 10 ** (k - 1) + remainder // k - 1
        if remainder % k == 0:
            result *= int(str(number)[-1])
        else:
            result *= int(str(number + 1)[remainder % k - 1])
    return result
