from math import sqrt
from euler.calculus import triangular_numbers


def compute(n: int) -> int:
    limit = int(sqrt(n))
    triangles = list(triangular_numbers(limit))
    min_difference = n
    nearest = 0
    for i in range(limit):
        for j in range(i + 1):
            rectangles = triangles[i] * triangles[j]
            difference = abs(n - rectangles)
            if difference < min_difference:
                min_difference = difference
                nearest = i * j
            if rectangles > n:
                break
    return nearest
