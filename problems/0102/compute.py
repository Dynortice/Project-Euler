from euler.geometry import triangle_area


def compute(path: str) -> int:
    triangles = [tuple(map(int, line.split(','))) for line in open(path).read().split('\n')]
    x = (0, 0)
    result = 0
    for triangle in triangles:
        a, b, c = triangle[:2], triangle[2:4], triangle[4:]
        if triangle_area(a, b, x) + triangle_area(a, x, c) + triangle_area(x, b, c) == triangle_area(a, b, c):
            result += 1
    return result
