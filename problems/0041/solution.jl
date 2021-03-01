include("euler/euler.jl")
using .Primes: prime_numbers
using BenchmarkTools
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100

function compute()::Int
    for prime ∈ reverse(prime_numbers(7654321))
        str_prime = string(prime)
        if sort(parse.(Int, ∪(str_prime))) == collect(1:length(str_prime))
            return prime
        end
    end
end

compute()

@benchmark compute()