include("euler/euler.jl")
using .Calculus: hexagonal_index, get_hexagonal

function compute(n::Int)::Int
    i = hexagonal_index(n) + 1
    while ((√(48i ^ 2 - 24i + 1) + 1) / 6) % 1 ≠ 0 i += 1 end
    return get_hexagonal(i)
end