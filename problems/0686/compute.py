from math import ceil, log10


def compute(digits: int, n: int) -> int:
    digits_len = ceil(log10(digits))
    number = 2
    repetitions = 0
    result = 1
    while True:
        result += 1
        number *= 2
        if log10(number) > digits_len:
            number /= 10
        if int(number) == digits:
            repetitions += 1
            if repetitions == n:
                break
    return result
