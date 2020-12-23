include("../euler/Julia/primes.jl")
using .Primes: smallest_prime_factor

function compute(n::Int64)::Int64
    while true
        prime = smallest_prime_factor(n)
        if prime < n
            n ÷= prime
        else
            return n
        end
    end
end
