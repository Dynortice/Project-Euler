include("euler/Julia/big_int.jl")
using .BigIntegers: BigInteger

function compute(n::Int64)::Int64
    max_sum = 0
    for a ∈ n - 5:n - 1
        number = BigInteger(a)
        for b ∈ 1:n - 1
            number *= BigInteger(a)
            max_sum = max(max_sum, sum(parse.(Int, collect(number.str))))
        end
    end
    return max_sum
end