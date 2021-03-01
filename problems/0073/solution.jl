using BenchmarkTools
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100

function compute(n::Int)::Int
    sieve = zeros(Int, n)
    for i ∈ 2:n
        sieve[i] += i - 1 - i ÷ 2 - i ÷ 3
        j = 2i
        sieve[j:i:n] .-= sieve[i]
    end
    return sum(sieve)
end

compute(8)

compute(12000)

@benchmark compute(12000)