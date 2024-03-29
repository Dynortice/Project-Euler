include("euler/euler.jl")
using .Primes: prime_sieve
using BenchmarkTools
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100

function compute(n::Int)::Int
    sieve = prime_sieve(n)
    prime_numbers = findall(sieve)
    result = 0
    for prime ∈ prime_numbers
        str_prime = string(prime)
        result += 1
        for _ ∈ 1:length(str_prime)
            str_prime = string(str_prime[2:end], str_prime[1])
            if !sieve[parse(Int, str_prime)]
                result -= 1
                break
            end
        end
    end
    return result
end

compute(100)

compute(1_000_000)

@benchmark compute(1_000_000)