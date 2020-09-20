from euler.calculus import is_pentagonal, get_hexagonal


def compute() -> int:
    n = get_hexagonal(144)
    i = n - 40755
    while True:
        if is_pentagonal(n):
            return n
        i += 4
        n += i
