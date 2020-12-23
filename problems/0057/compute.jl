include("euler/Julia/big_int.jl")
using .BigIntegers: BigInteger

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