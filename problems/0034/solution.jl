using Combinatorics: with_replacement_combinations
using BenchmarkTools
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100

function compute()::Int64
    result = 0
    factorials = Dict(i => factorial(i) for i ∈ 0:9)
    for i ∈ 2:7
        for digits_ ∈ with_replacement_combinations(0:9, i)
            candidate = sum(factorials[j] for j ∈ digits_)
            if sort([parse(Int, j) for j ∈ string(candidate)]) == sort(digits_)
                result += candidate
            end
        end
    end
    return result
end

compute()

@benchmark compute()