include("euler/euler.jl")
using .Numbers: get_digits
using Combinatorics: with_replacement_combinations

function compute(n::Int)::Int
    max_len = 2
    result = 0
    powers = Dict(i => i ^ n for i in 0:9)
    while length(string(max_len * 9 ^ n)) >= max_len
        for digits ∈ with_replacement_combinations(0:9, max_len)
            candidate = sum(map(x -> powers[x], digits))
            if sort(get_digits(candidate)) == sort(digits)
                result += candidate
            end
        end
        max_len += 1
    end
    return result
end
