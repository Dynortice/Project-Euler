function compute(n::Int64, grid::String)::Int64
    grid = [[parse(Int, number) for number ∈ split(line, " ")] for line ∈ split(grid, "\n")]
    width, height = length(grid[1]), length(grid)
    result = 0
    function grid_product(coordinate, direction)
        product = 1
        for i ∈ 0:n - 1
            number = grid[coordinate[2] + direction[2] * i][coordinate[1] + direction[1] * i]
            if number == 0
                return 0
            end
            product *= number
        end
        return product
    end
    for y ∈ 1:height
        for x ∈ 1:width
            if x + n - 1 ≤ width
                result = max(result, grid_product([x, y], [1, 0]))
            end
            if y + n - 1 ≤ height
                result = max(result, grid_product([x, y], [0, 1]))
                if x + n - 1 ≤ width
                    result = max(result, grid_product([x, y], [1, 1]))
                end
                if x - n ≥ 0
                    result = max(result, grid_product([x, y], [-1, 1]))
                end
            end
        end
    end
    return result
end
