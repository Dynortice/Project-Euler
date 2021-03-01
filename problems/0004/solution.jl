include("euler/euler.jl")
using .Numbers: is_palindrome
using BenchmarkTools
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100

function compute(n::Int)::Int
    result = 0
    for i ∈ 10 ^ n ÷ 11 * 11:-11:10 ^ (n - 1)
        for j ∈ 10 ^ n - 1:-1:10 ^ (n - 1)
            candidate = i * j
            if candidate ≤ result
                break
            elseif is_palindrome(candidate)
                result = candidate
            end
        end
    end
    return result
end

compute(2)

compute(3)

@benchmark compute(3)
