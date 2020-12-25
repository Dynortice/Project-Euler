function compute(n::Int64)::Int64
    combinations = vcat([1], repeat([0], n))
    for i ∈ 1:n
        for j ∈ i + 1:n + 1
            combinations[j] += combinations[j - i]
        end
    end
    return combinations[end] - 1
end
