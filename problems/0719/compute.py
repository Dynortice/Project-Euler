from euler.numbers import is_s_number


def compute(n: int) -> int:
    result = 0
    for i in range(2, n + 1):
        if is_s_number(i, i * i):
            result += i * i
    return result
