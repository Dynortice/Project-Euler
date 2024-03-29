include("euler/euler.jl")
using .BigIntegers: BigInteger
using .Numbers: is_palindrome
using BenchmarkTools
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100

function compute(n::Int)::Int
    result = 0
    for i ∈ 1:n
        number = BigInteger(string(i))
        number += BigInteger(reverse(number.str))
        j = 1
        while j ≤ 50 && !is_palindrome(number)
            number += BigInteger(reverse(number.str))
            j += 1
        end
        if j > 50
            result += 1
        end
    end
    return result
end

compute(10_000)

@benchmark compute(10_000)