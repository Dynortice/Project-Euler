from math import isqrt, sqrt


def compute(n: int) -> int:
    perimeters = {}
    for a in range(3, n // 3):
        for b in range(a, n // 2):
            k = a * a + b * b
            if sqrt(k) % 1 == 0:
                p = a + b + isqrt(k)
                if p in perimeters:
                    perimeters[p] += 1
                else:
                    perimeters[p] = 1
    return max(perimeters, key=perimeters.get)
