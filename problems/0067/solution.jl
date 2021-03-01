include("euler/euler.jl")
using .Grid: max_path_sum
using BenchmarkTools
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100

function compute(path::String)::Int
    triangle = map(x -> parse.(Int, split(x, " ")), split(read(path, String), "\n"))
    return max_path_sum(triangle)
end

compute("problems/0067/p067_triangle.txt")

@benchmark compute("problems/0067/p067_triangle.txt")