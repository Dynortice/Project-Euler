include("euler/euler.jl")
using .Primes: smallest_prime_factor

function compute(n::Int)::Int
    while true
        prime = smallest_prime_factor(n)
        if prime < n
            n ÷= prime
        else
            return n
        end
    end
end
