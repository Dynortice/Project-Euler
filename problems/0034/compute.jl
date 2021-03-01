using Combinatorics: with_replacement_combinations

function compute()::Int
    result = 0
    factorials = Dict(i => factorial(i) for i ∈ 0:9)
    for i ∈ 2:7
        for digits ∈ with_replacement_combinations(0:9, i)
            candidate = sum(factorials[j] for j ∈ digits)
            if sort(parse.(Int, collect(string(candidate)))) == sort(digits)
                result += candidate
            end
        end
    end
    return result
end
