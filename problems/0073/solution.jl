using BenchmarkTools
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100

function compute(n::Int64)::Int64
    sieve = zeros(Int64, n)
    for i ∈ 2:n
        sieve[i] += i - 1 - i ÷ 2 - i ÷ 3
        j = 2i
        while j ≤ n
            sieve[j] -= sieve[i]
            j += i
        end
    end
    return sum(sieve)
end

compute(8)
compute(12000)

@benchmark compute(12000)