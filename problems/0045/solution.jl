include("euler/euler.jl")
using .Calculus: hexagonal_index, get_hexagonal
using BenchmarkTools
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100

function compute(n::Int)::Int
    i = hexagonal_index(n) + 1
    while ((√(48i ^ 2 - 24i + 1) + 1) / 6) % 1 ≠ 0 i += 1 end
    return get_hexagonal(i)
end

compute(40755)

@benchmark compute(40755)