from euler.grid import adjacent_product
from euler.math import fast_max


def compute(n: int, grid: str) -> int:
    grid = [list(map(int, line.split(' '))) for line in grid.split('\n')]
    width, height = len(grid[0]), len(grid)
    result = 0
    for y in range(height):
        for x in range(width):
            if x + n <= width:
                result = fast_max(result, adjacent_product(grid, n, (x, y), (1, 0)))
            if y + n <= height:
                result = fast_max(result, adjacent_product(grid, n, (x, y), (0, 1)))
                if x + n <= width:
                    result = fast_max(result, adjacent_product(grid, n, (x, y), (1, 1)))
                if x - n >= -1:
                    result = fast_max(result, adjacent_product(grid, n, (x, y), (-1, 1)))
    return result
