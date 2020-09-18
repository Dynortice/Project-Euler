include("euler/Julia/primes.jl")
using BenchmarkTools
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100

function compute(n::Int64)::Int64
    sieve = primes.get_primality(n)
    prime_numbers = findall(sieve)
    result = 0
    for prime in prime_numbers
        str_prime = string(prime)
        is_circular_prime = true
        for _ in 1:length(str_prime)
            str_prime = string(str_prime[2:end], str_prime[1])
            if !sieve[parse(Int, str_prime)]
                is_circular_prime = false
                break
            end
        end
        if is_circular_prime
            result += 1
        end
    end
    return result
end

compute(100)

compute(1000000)

@benchmark compute(1000000)