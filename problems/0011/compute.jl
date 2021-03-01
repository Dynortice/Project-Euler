include("euler/Julia/grid.jl")
include("euler/Julia/math.jl")
using .Grid: adjacent_product
using .Math: fast_max

function compute(n::Int, grid::String)::Int
    grid = [parse.(Int, row) for row in split.(split(grid, "\n"), " ")]
    width, height = length(grid[1]), length(grid)
    result = 0
    for y ∈ 1:height
        for x ∈ 1:width
            if x + n - 1 ≤ width result = fast_max(result, adjacent_product(grid, n, (x, y), (1, 0))) end
            if y + n - 1 ≤ height result = fast_max(result, adjacent_product(grid, n, (x, y), (0, 1)))
                if x + n - 1 ≤ width result = fast_max(result, adjacent_product(grid, n, (x, y), (1, 1))) end
                if x - n ≥ 0 result = fast_max(result, adjacent_product(grid, n, (x, y), (-1, 1))) end
            end
        end
    end
    return result
end
