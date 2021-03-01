include("euler/euler.jl")
using .Math: fast_min
using BenchmarkTools
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100

function compute(grid::Array{Int,2})::Int
    edge = size(grid)[1]
    for i ∈ edge - 1:-1:1
        grid[edge, i] += grid[edge, i + 1]
        grid[i, edge] += grid[i + 1, edge]
    end
    for i ∈ edge - 1:-1:1 for j ∈ edge - 1:-1:1 grid[i, j] += fast_min(grid[i + 1, j], grid[i, j + 1]) end end
    return grid[1, 1]
end

matrix = [131 673 234 103 18;
          201 96 342 965 150;
          630 803 746 422 111;
          537 699 497 121 956;
          805 732 524 37 331]

path = "problems/0081/p081_matrix.txt"

compute(matrix)

compute(parse.(Int, hcat(split.(split(read(path, String), "\n"), ",")...)))

@benchmark compute(parse.(Int, hcat(split.(split(read(path, String), "\n"), ",")...)))