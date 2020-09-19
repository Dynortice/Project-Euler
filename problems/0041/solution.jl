include("euler/Julia/primes.jl")
using BenchmarkTools
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100

function compute()::Int64
    prime_numbers = primes.get_primes(7654321)
    for prime in reverse(prime_numbers)
        str_prime = string(prime)
        if sort(parse.(Int64, ∪(str_prime))) == collect(1:length(str_prime))
            return prime
        end
    end
end

compute()

@benchmark compute()