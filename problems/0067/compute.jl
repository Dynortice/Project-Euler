include("euler/euler.jl")
using .Grid: max_path_sum

function compute(path::String)::Int
    triangle = map(x -> parse.(Int, split(x, " ")), split(read(path, String), "\n"))
    return max_path_sum(triangle)
end