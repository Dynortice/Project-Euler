include("euler/Julia/primes.jl")
using .Primes: get_primes
using BenchmarkTools
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100

function compute(n::Int64)::Int64
    result = 1
    for prime ∈ get_primes(trunc(Int64, √n))
        result *= prime
        if result * prime > n
            return result
        end
    end
end

compute(10)

compute(1000000)

@benchmark compute(1000000)