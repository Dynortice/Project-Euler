include("euler/euler.jl")
using .Calculus: sum_arithmetic_series
using BenchmarkTools
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100

function compute(a::Int, b::Int, n::Int)::Int
    n -= 1
    ab = a * b
    return sum_arithmetic_series(a, a, n ÷ a) + sum_arithmetic_series(b, b, n ÷ b) - sum_arithmetic_series(ab, ab, n ÷ ab)
end

compute(3, 5, 10)

compute(3, 5, 1000)

@benchmark compute(3, 5, 1000)