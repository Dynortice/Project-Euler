include("euler/euler.jl")
using .Grid: max_grid_path

compute(triangle::String)::Int = max_path_sum([parse.(Int, split(line, " ")) for line ∈ split(triangle, "\n")])
