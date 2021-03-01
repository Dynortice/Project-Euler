include("euler/euler.jl")
using .Primes: prime_numbers
using BenchmarkTools
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100

compute(n::Int)::Int = sum(prime_numbers(n))

compute(10)

compute(2000000)

@benchmark compute(2000000)