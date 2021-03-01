include("euler/euler.jl")
using .Numbers: get_digits
using Combinatorics: with_replacement_combinations
using StatsBase: countmap
using BenchmarkTools
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100

function compute(n::Int)::Int
    squares = (0:9) .* (0:9)
    result = 0
    for i ∈ with_replacement_combinations(0:9, n)
        combination = parse(Int, join(i))
        while true
            combination = sum(squares[get_digits(combination) .+ 1])
            if combination == 89
                result += factorial(n) ÷ prod(factorial.(values(countmap(i))))
                break
            elseif combination ≤ 1
                break
            end
        end
    end
    return result
end

compute(7)

@benchmark compute(7)