include("euler/Julia/primes.jl")
using BenchmarkTools
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100

function compute()::AbstractString
    sieve = primes.get_primality(10000)
    prime_numbers = findall(sieve)
    for prime ∈ prime_numbers[prime_numbers .> 4817]
        first, third = prime - 3330, prime + 3330
        if sieve[first] & sieve[third] & (sort(∪(string(first))) == sort(∪(string(prime)))) & (sort(∪(string(prime))) == sort(∪(string(third))))
            return string(first, prime, third)
        end
    end
end

compute()

@benchmark compute()