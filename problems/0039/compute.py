from math import sqrt


def compute(n: int) -> int:
    perimeters = {}
    for a in range(3, n // 3):
        for b in range(a, n // 2):
            k = a * a + b * b
            if k == int(sqrt(k)) ** 2:
                p = a + b + int(sqrt(k))
                if p in perimeters:
                    perimeters[p] += 1
                else:
                    perimeters[p] = 1
    return max(perimeters, key=perimeters.get)
