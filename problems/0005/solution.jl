include("euler/euler.jl")
using .Primes: prime_numbers
using BenchmarkTools
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100

compute(n::Int)::Int = prod([prime ^ trunc(Int, log(prime, n)) for prime ∈ prime_numbers(n)])

compute(10)

compute(20)

@benchmark compute(20)
