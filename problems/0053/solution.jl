using BenchmarkTools
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100

function compute(n_max::Int64, limit::Int64)::Int64
    comb_approx(n::Int64, k::Int64)::Float64 = n ^ (n + 0.5) / √(2π) / k ^ (k + 0.5) / (n - k) ^ (n - k + 0.5)

    result = 0
    for i ∈ 1:n_max
        for j ∈ 1:i ÷ 2
            if comb_approx(i, j) > limit
                result += i - 2j + 1
                break
            end
        end
    end
    return result
end

compute(100, 1000000)

@benchmark compute(100, 1000000)