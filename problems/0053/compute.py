from math import pi, sqrt


def compute(n_max: int, limit: int) -> int:
    def comb_approx(n: int, k: int) -> float:
        return n ** (n + 0.5) / sqrt(2 * pi) / k ** (k + 0.5) / (n - k) ** (n - k + 0.5)

    result = 0
    for i in range(1, n_max + 1):
        for j in range(1, i // 2):
            if comb_approx(i, j) > limit:
                result += i - 2 * j + 1
                break
    return result
