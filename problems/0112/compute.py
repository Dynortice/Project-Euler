from euler.numbers import get_digits


def compute(n: float) -> int:
    bouncy = 0
    i = 1
    while bouncy / i < n:
        i += 1
        digits = list(get_digits(i))
        sorted_digits = sorted(digits)
        if not (digits == sorted_digits or digits == sorted_digits[::-1]):
            bouncy += 1
    return i
