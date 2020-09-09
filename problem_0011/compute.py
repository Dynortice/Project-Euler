def compute(n: int, grid: str) -> int:
    grid = [[int(number) for number in line.split(' ')] for line in grid.split('\n')]
    width, height = len(grid[0]), len(grid)
    result = 0

    def grid_product(coordinate: [int, int], direction: [int, int]) -> int:
        product = 1
        for i in range(n):
            number = grid[coordinate[1] + direction[1] * i][coordinate[0] + direction[0] * i]
            if number == 0:
                return 0
            product *= number
        return product

    for y in range(height):
        for x in range(width):
            if x + n <= width:
                result = max(result, grid_product([x, y], [1, 0]))
            if y + n <= height:
                result = max(result, grid_product([x, y], [0, 1]))
                if x + n <= width:
                    result = max(result, grid_product([x, y], [1, 1]))
                if x - n >= -1:
                    result = max(result, grid_product([x, y], [-1, 1]))
    return result
