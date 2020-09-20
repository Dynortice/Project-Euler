from euler.calculus import is_pentagonal


def compute() -> int:
    pentagonals = [1]
    j = 1
    for i in pentagonals:
        for k in pentagonals:
            if is_pentagonal(i - k) and is_pentagonal(abs(i - 2 * k)):
                return abs(i - 2 * k)
        j += 3
        pentagonals += [i + j]
