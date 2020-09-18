using Combinatorics

function compute()::Int64
    result = 0
    factorials = Dict(i => factorial(i) for i in 0:9)
    for i in 2:7
        for digits_ in Combinatorics.with_replacement_combinations(0:9, i)
            candidate = sum(factorials[j] for j in digits_)
            if sort([parse(Int, j) for j in string(candidate)]) == sort(digits_)
                result += candidate
            end
        end
    end
    return result
end
