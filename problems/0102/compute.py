def compute(path: str) -> int:
    def get_area(ax: int, ay: int, bx: int, by: int, cx: int, cy: int) -> float:
        return abs((ax - cx) * (by - ay) - (ax - bx) * (cy - ay)) / 2
    triangles = [tuple(map(int, line.split(','))) for line in open(path).read().split('\n')]
    x = (0, 0)
    result = 0
    for triangle in triangles:
        a, b, c = triangle[:2], triangle[2:4], triangle[4:]
        if get_area(*triangle) == sum([get_area(*a, *b, *x), get_area(*a, *x, *c), get_area(*x, *b, *c)]):
            result += 1
    return result
