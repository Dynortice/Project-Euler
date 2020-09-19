from math import prod


def compute(d: int) -> int:
    def digits_number(k: int) -> int:
        return (10 ** k * (9 * k - 1) + 1) // 9

    def get_digit(n: int) -> int:
        k = 0
        while digits_number(k + 1) < n:
            k += 1
        k += 1
        rem = n - digits_number(k - 1)
        num = 10 ** (k - 1) + rem // k - 1
        if rem % k == 0:
            return int(str(num)[-1])
        else:
            return int(str(num + 1)[rem % k - 1])
    return prod(get_digit(10 ** i) for i in range(d))
