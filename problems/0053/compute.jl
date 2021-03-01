function compute(n::Int, limit::Int)::Int
    result = 0
    for i ∈ 1:n
        for j ∈ 1:i ÷ 2
            if binom(i, j) > limit
                result += i - 2j + 1
                break
            end
        end
    end
    return result
end