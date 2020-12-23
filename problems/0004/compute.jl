include("../euler/Julia/numbers.jl")
using .Numbers: is_palindrome

function compute(n::Int64)::Int64
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
