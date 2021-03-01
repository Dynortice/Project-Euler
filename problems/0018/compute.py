from euler.grid import max_path_sum


def compute(triangle: str) -> int:
    return max_path_sum([list(map(int, line.split(" "))) for line in triangle.split("\n")])
