function compute(coins::Vector{Int}, n::Int)::Int
    combinations = vcat([1], repeat([0], n))
    for i ∈ 1:length(coins)
        for j ∈ coins[i] + 1:n + 1
            combinations[j] += combinations[j - coins[i]]
        end
    end
    return combinations[end]
end
