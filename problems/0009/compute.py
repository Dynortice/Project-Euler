from math import isqrt


def compute(n: int) -> int:
    for c in range(n // 3 + 1, n // 2 + 1):
        s = c * c - n * n + 2 * n * c
        if s > 0:
            t = isqrt(s)
            if t * t == s:
                b = (n - c + t) // 2
                a = n - c - b
                return a * b * c
