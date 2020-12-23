include("euler/Julia/primes.jl")
using .Primes: get_primes
using BenchmarkTools
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100

compute(n::Int64)::Int64 = sum(get_primes(n))

compute(10)

compute(2000000)

@benchmark compute(2000000)