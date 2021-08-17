include("euler/euler.jl")
using .BigIntegers: BigInteger
using BenchmarkTools
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100

function compute(d::Int, n::Int)::Int
    numerator, denominator = BigInteger(1), BigInteger(1)
    a, b = d, d - 1
    result = 0
    for _ ∈ 1:n
        numerator, denominator = numerator + a * denominator, numerator + b * denominator
        if length(numerator) ≠ length(denominator) result += 1 end
    end
    return result
end

compute(2, 8)

compute(2, 1_000)

@benchmark compute(2, 1_000)