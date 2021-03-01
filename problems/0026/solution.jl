include("euler/euler.jl")
using .Primes: prime_numbers
using .Numbers: multiplicative_order
using BenchmarkTools
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100

function compute(n::Int)::Int
    max_cycle, result = 0, 0
    for prime ∈ prime_numbers(n)[3:end]
        cycle = multiplicative_order(10, prime)
        if cycle > max_cycle max_cycle, result = cycle, prime end
    end
    return result
end

compute(10)

compute(1000)

@benchmark compute(1000)