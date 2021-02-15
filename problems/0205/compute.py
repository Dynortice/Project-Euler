from math import prod
from scipy.special import comb


def compute(a: (int, int), b: (int, int)) -> float:
    def get_combinations(p, n, s):
        return int(sum([(-1) ** k * comb(n, k) * comb(p - 1 - s * k, n - 1) for k in range((p - n) // s + 1)]))
    limit = max([prod(a), prod(b)])
    looses = [0] * (limit + 1)
    result = 0
    for i in range(b[0], prod(b) + 1):
        looses[i] = get_combinations(i, *b) + looses[i - 1]
    for i in range(a[0], prod(a) + 1):
        result += get_combinations(i, *a) * looses[i - 1]
    return round(result / a[1] ** a[0] / b[1] ** b[0], 7)

compute((9, 4), (6, 6))