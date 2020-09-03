include("euler/Julia/primes.jl")
using BenchmarkTools
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100

function compute(n::Integer)::Integer
    while true
        prime = primes.smallest_prime_factor(n)
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
