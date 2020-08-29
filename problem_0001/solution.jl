include("euler/Julia/calculus.jl")
using BenchmarkTools
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100

function compute(a::Integer, b::Integer, n::Integer)
    n -= 1
    return sum([calculus.sum_arithmetic_series(a, a, n ÷ a),
                calculus.sum_arithmetic_series(b, b, n ÷ b),
                - calculus.sum_arithmetic_series(a * b, a * b, n ÷ (a * b))])
end

compute(3, 5, 10)

compute(3, 5, 1000)

@benchmark compute(3, 5, 1000)