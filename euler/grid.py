from euler.math import fast_max


def adjacent_product(grid: [[int]], n: int, coordinate: (int, int), direction: (int, int)) -> int:
    """Get product of `n` adjacent numbers in `grid`

    Args:
        grid: Matrix-like list
        n: Number of adjacent numbers in product
        coordinate: Start position in product
        direction: Direction for getting adjacent numbers (vertical, horizontal, diagonal)

    Examples:
        >>> grid = [[8, 2, 22, 97], [49, 49, 99, 40], [81, 49, 31, 73], [52, 70, 95, 23]]
        Horizontal (8 * 2 * 22 * 97):
        >>> print(adjacent_product(grid, 4, (0, 0), (1, 0)))
        34144
        Vertical (97 * 40 * 73):
        >>> print(adjacent_product(grid, 3, (3, 0), (0, 1)))
        283240
        Up-left to down-right diagonal (49 * 31 * 23)
        >>> print(adjacent_product(grid, 3, (1, 1), (1, 1)))
        34937
        Up-right to down-left diagonal (97 * 99)
        >>> print(adjacent_product(grid, 2, (3, 0), (-1, 1)))
    """
    product = 1
    for i in range(n):
        number = grid[coordinate[1] + direction[1] * i][coordinate[0] + direction[0] * i]
        if number == 0:
            return 0
        product *= number
    return product


def max_path_sum(grid: [[int]]):
    """Get triangle maximum path sum

    Args:
        grid: Triangle-like list

    Examples:
        >>> print(max_path_sum([[3], [7, 4], [2, 4, 6], [8, 5, 9, 3]]))
        23
    """
    while len(grid) > 1:
        for i in range(len(grid) - 1):
            grid[-2][i] += fast_max(*grid[-1][i:i + 2])
        grid = grid[:-1]
    return grid[0][0]
