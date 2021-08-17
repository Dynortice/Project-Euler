include("euler/euler.jl")
using .Primes: prime_sieve
using BenchmarkTools
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100

function compute(max_a::Int, max_b::Int)::Int
    prime = prime_sieve(max_a * max_b)
    prime_numbers = findall(prime[1:max_b])
    append!(prime_numbers, .-prime_numbers)
    max_sequence, result = 0, 0
    for a ∈ -max_a + (max_a % 2 == 0 ? 1 : 2):2:max_a - 1
        for b ∈ prime_numbers
            n = 0
            while true
                candidate = abs(n * (n + a) + b)
                if candidate ≠ 0 && !prime[candidate] break end
                n += 1
            end
            if n > max_sequence max_sequence, result = n, a * b end
        end
    end
    return result
end

compute(1_000, 1_000)

@benchmark compute(1_000, 1_000)