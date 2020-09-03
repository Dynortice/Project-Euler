include("euler/Julia/numbers.jl")
using BenchmarkTools
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100

function compute(n::Integer)::Array
    result = 0
    result_numbers = [0, 0]
    for i in 10 ^ n ÷ 11 * 11:-11:10 ^ (n - 1)
        for j in 10 ^ n - 1:-1:10 ^ (n - 1)
            candidate = i * j
            if candidate ≤ result
                break
            elseif numbers.is_palindrome(string(candidate))
                result = candidate
                result_numbers = [i, j]
            end
        end
    end
    return [result, result_numbers]
end

compute(2)

compute(3)

@benchmark compute(3)
