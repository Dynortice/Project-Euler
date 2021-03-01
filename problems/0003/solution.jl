include("euler/euler.jl")
using .Primes: smallest_prime_factor
using BenchmarkTools
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100

function compute(n::Int)::Int
    while true
        prime = smallest_prime_factor(n)
        if prime < n
            n ÷= prime
        else
            return n
        end
    end
end

compute(13195)

compute(600851475143)

@benchmark compute(600851475143)
