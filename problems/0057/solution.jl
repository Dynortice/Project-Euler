include("euler/Julia/big_int.jl")
using .BigIntegers: BigInteger
using BenchmarkTools
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100

function compute(d::Int64, n::Int64)::Int64
    numerator, denominator = BigInteger(1), BigInteger(1)
    a, b = d, d - 1
    result = 0
    for _ ∈ 1:n
        numerator, denominator = numerator + a * denominator, numerator + b * denominator
        if length(numerator) ≠ length(denominator)
            result += 1
        end
    end
    return result
end

compute(2, 8)

compute(2, 1000)

@benchmark compute(2, 1000)