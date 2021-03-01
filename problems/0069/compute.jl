include("euler/euler.jl")
using .Primes: prime_numbers

function compute(n::Int)::Int
    result = 1
    for prime ∈ prime_numbers(trunc(Int, √n))
        result *= prime
        if result * prime > n
            return result
        end
    end
end
