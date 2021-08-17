include("euler/euler.jl")
using .Primes: prime_sieve

function compute()::String
    sieve = prime_sieve(10_000)
    primes = findall(sieve)
    for prime ∈ primes[primes .> 4_817]
        first, third = prime - 3_330, prime + 3_330
        if sieve[first] && sieve[third] && (sort(∪(string(prime))) == sort(∪(string(first)))) && (sort(∪(string(prime))) == sort(∪(string(third))))
            return string(first, prime, third)
        end
    end
end