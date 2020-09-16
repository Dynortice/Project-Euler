using Combinatorics

function compute(n::Int64)::Int64
    max_len = 2
    result = 0
    powers = Dict(i => i ^ n for i in 0:9)
    while length(string(max_len * 9 ^ n)) >= max_len
        for digits_ in Combinatorics.with_replacement_combinations(0:9, max_len)
            candidate = sum(powers[i] for i in digits_)
            if sort([parse(Int, i) for i in string(candidate)]) == sort(digits_)
                result += candidate
            end
        end
        max_len += 1
    end
    return result
end
