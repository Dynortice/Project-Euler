include("euler/Julia/numbers.jl")
using .Numbers: BigInteger, is_palindrome
using BenchmarkTools
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100

function compute(n::Int64)::Int64
    result = 0
    for i ∈ 1:n
        number = BigInteger(i)
        number += BigInteger(reverse(number.str))
        j = 1
        while (j ≤ 50) & (!is_palindrome(number))
            number += BigInteger(reverse(number.str))
            j += 1
        end
        if j > 50
            result += 1
        end
    end
    return result
end

compute(10000)

@benchmark compute(10000)