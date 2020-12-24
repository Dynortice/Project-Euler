include("euler/Julia/primes.jl")
using .Primes: get_primes

function compute(n::Int64)::Int64
    result = 1
    for prime ∈ get_primes(trunc(Int64, √n))
        result *= prime
        if result * prime > n
            return result
        end
    end
end
