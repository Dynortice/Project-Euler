include("euler/euler.jl")
using .Primes: prime_sieve
using BenchmarkTools
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100

function compute()::String
    sieve = prime_sieve(10000)
    primes = findall(sieve)
    for prime ∈ primes[primes .> 4817]
        first, third = prime - 3330, prime + 3330
        if sieve[first] && sieve[third] && (sort(∪(string(prime))) == sort(∪(string(first)))) && (sort(∪(string(prime))) == sort(∪(string(third))))
            return string(first, prime, third)
        end
    end
end

compute()

@benchmark compute()