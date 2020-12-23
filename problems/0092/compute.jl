using Combinatorics: with_replacement_combinations
using StatsBase: countmap

function compute(n::Int64)::Int64
    sum_squares_digits(x::AbstractString)::Int64 = sum(parse.(Int64, collect(x)) .^ 2)

    result = 0
    for i ∈ with_replacement_combinations(0:9, n)
        combination = join(i)
        while true
            combination = sum_squares_digits(combination)
            if combination == 89
                result += factorial(n) ÷ prod(factorial.(values(countmap(i))))
                break
            elseif combination ≤ 1
                break
            else
                combination = string(combination)
            end
        end
    end
    return result
end