using BenchmarkTools
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100

function compute(n::Int, limit::Int)::Int
    result = 0
    for i ∈ 1:n
        for j ∈ 1:i ÷ 2
            if binomial(i, j) > limit
                result += i - 2j + 1
                break
            end
        end
    end
    return result
end

compute(100, 1000000)

@benchmark compute(100, 1000000)