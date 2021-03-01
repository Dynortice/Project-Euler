from euler.calculus import is_pentagonal


def compute() -> int:
    pentagonals = [1]
    k = 1
    for i in pentagonals:
        for j in pentagonals:
            if is_pentagonal(i - j) and is_pentagonal(abs(i - 2 * j)):
                return abs(i - 2 * j)
        k += 3
        pentagonals.append(i + k)
