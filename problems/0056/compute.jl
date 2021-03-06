include("euler/euler.jl")
using .BigIntegers: BigInteger
using .Math: fast_max
using .Numbers: digits_sum

function compute(n::Int)::Int
    result = 0
    for a ∈ n - 5:n - 1
        number = BigInteger(a)
        for b ∈ 1:n - 1
            number *= BigInteger(a)
            result = fast_max(result, digits_sum(number))
        end
    end
    return result
end