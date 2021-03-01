from euler.math import fast_min


def compute(grid: [[int]]) -> int:
    edge = len(grid) - 1
    for i in range(edge - 1, -1, -1):
        grid[edge][i] += grid[edge][i + 1]
        grid[i][edge] += grid[i + 1][edge]
    for i in range(edge - 1, -1, -1):
        for j in range(edge - 1, -1, -1):
            grid[i][j] += fast_min(grid[i + 1][j], grid[i][j + 1])
    return grid[0][0]
