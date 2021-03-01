include("euler/euler.jl")
using .Primes: prime_numbers
using BenchmarkTools
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100

function compute(n::Int)::Int
    result = 1
    for prime ∈ prime_numbers(trunc(Int, √n))
        result *= prime
        if result * prime > n
            return result
        end
    end
end

compute(10)

compute(1000000)

@benchmark compute(1000000)