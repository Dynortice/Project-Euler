include("euler/euler.jl")
using .Numbers: is_s_number
using BenchmarkTools
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100

function compute(n::Int)::Int
    result = 0
    for i ∈ 2:n if is_s_number(i, i * i) result += i * i end end
    return result
end

compute(100)

compute(1_000_000)

@benchmark compute(1_000_000)