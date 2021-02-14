from math import sqrt


def compute(n: int) -> int:
    limit = int(sqrt(n))
    triangles = [0] * limit
    for i in range(1, limit):
        triangles[i] = triangles[i - 1] + i
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
