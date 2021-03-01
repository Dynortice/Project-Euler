include("euler/euler.jl")
using .Math: fast_min

function compute(grid::Array{Int,2})::Int
    edge = size(grid)[1]
    for i ∈ edge - 1:-1:1
        grid[edge, i] += grid[edge, i + 1]
        grid[i, edge] += grid[i + 1, edge]
    end
    for i ∈ edge - 1:-1:1 for j ∈ edge - 1:-1:1 grid[i, j] += fast_min(grid[i + 1, j], grid[i, j + 1]) end end
    return grid[1, 1]
end
