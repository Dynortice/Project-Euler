include("euler/euler.jl")
using .BigIntegers: BigInteger
using .Numbers: digits_sum

function compute(n::Int)::Int
    current, previous = BigInteger(1), BigInteger(1)
    for i ∈ 2:n + 1
        current, previous = (i % 3 == 1 ? 2i ÷ 3 : 1)current + previous, current
    end
    return digits_sum(current)
end
