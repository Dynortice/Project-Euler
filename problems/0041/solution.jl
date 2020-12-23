include("euler/Julia/primes.jl")
using .Primes: get_primes
using BenchmarkTools
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100

function compute()::Int64
    prime_numbers = get_primes(7654321)
    for prime ∈ reverse(prime_numbers)
        str_prime = string(prime)
        if sort(parse.(Int64, ∪(str_prime))) == collect(1:length(str_prime))
            return prime
        end
    end
end

compute()

@benchmark compute()