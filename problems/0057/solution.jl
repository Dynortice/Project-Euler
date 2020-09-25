include("euler/Julia/big_int.jl")
using BenchmarkTools
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100

function compute(d::Int64, n::Int64)::Int64
    numerator, denominator = Big_Int("1"), Big_Int("1")
    a, b = Big_Int(string(d)), Big_Int(string(d - 1))
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