include("euler/euler.jl")
using .Grid: max_path_sum

compute(triangle::String)::Int = max_path_sum([parse.(Int, split(line, " ")) for line ∈ split(triangle, "\n")])
