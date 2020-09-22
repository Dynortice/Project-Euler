include("euler/Julia/big_int.jl")
using BenchmarkTools
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100

function compute(n::Int64)::Int64
    is_palindrome(x::Big_Int)::Bool = x.str == reverse(x.str)

    result = 0
    for i ∈ 1:n
        number = Big_Int(string(i))
        number += Big_Int(reverse(number.str))
        j = 1
        while (j ≤ 50) & (!is_palindrome(number))
            number += Big_Int(reverse(number.str))
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