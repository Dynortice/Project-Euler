from euler.game import dice_combinations
from euler.math import fast_max


def compute(a: tuple[int, int], b: tuple[int, int]) -> float:
    limit = fast_max(a[0] * a[1], b[0] * b[1])
    looses = [0] * (limit + 1)
    result = 0
    for i in range(b[0], b[0] * b[1] + 1):
        looses[i] = dice_combinations(i, *b) + looses[i - 1]
    for i in range(a[0], a[0] * a[1] + 1):
        result += dice_combinations(i, *a) * looses[i - 1]
    return round(result / a[1] ** a[0] / b[1] ** b[0], 7)
