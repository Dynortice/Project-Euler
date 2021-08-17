include("euler/euler.jl")
using .Primes: prime_numbers

function compute()::Int
    for prime ∈ reverse(prime_numbers(7_654_321))
        str_prime = string(prime)
        if sort(parse.(Int, ∪(str_prime))) == collect(1:length(str_prime))
            return prime
        end
    end
end
