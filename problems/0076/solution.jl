using BenchmarkTools
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100

function compute(n::Int64)::Int64
    combinations = vcat([1], repeat([0], n))
    for i ∈ 1:n
        for j ∈ i + 1:n + 1
            combinations[j] += combinations[j - i]
        end
    end
    return combinations[end] - 1
end

compute(5)

compute(100)

@benchmark compute(100)