include("euler/euler.jl")
using .Primes: prime_numbers
using BenchmarkTools
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100

compute(n::Int)::Int = prime_numbers(20n)[n]

compute(6)

compute(10001)

@benchmark compute(10001)