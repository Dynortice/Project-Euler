using BenchmarkTools
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100

function compute(coins::Array{Int,1}, n::Int)::Int
    combinations = vcat([1], repeat([0], n))
    for i ∈ 1:length(coins)
        for j ∈ coins[i] + 1:n + 1
            combinations[j] += combinations[j - coins[i]]
        end
    end
    return combinations[end]
end

coin_list = [1, 2, 5, 10, 20, 50, 100, 200]

compute(coin_list, 200)

@benchmark compute(coin_list, 200)