function compute(n::Int)::Int
    combinations = vcat([1], repeat([0], n))
    for i ∈ 1:n for j ∈ i + 1:n + 1 combinations[j] += combinations[j - i] end end
    return combinations[end] - 1
end
