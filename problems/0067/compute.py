from euler.grid import max_path_sum


def compute(path: str) -> int:
    triangle = [list(map(int, i.split(' '))) for i in open(path).read().split('\n')]
    return max_path_sum(triangle)
