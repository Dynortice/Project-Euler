include("../euler/Julia/primes.jl")

function compute(n::Integer)::Integer
    while true
        prime = primes.smallest_prime_factor(n)
        if prime < n
            n ÷= prime
        else
            return n
        end
    end
end
