def compute(triangle: str) -> int:
    triangle = [[int(i) for i in line.split(" ")] for line in triangle.split("\n")]
    while len(triangle) > 1:
        for i in range(len(triangle) - 1):
            triangle[-2][i] += max(triangle[-1][i:i + 2])
        triangle = triangle[:-1]
    return triangle[0][0]
