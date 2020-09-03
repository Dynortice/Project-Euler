include("euler/Julia/primes.jl")
using BenchmarkTools
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100

compute(n::Integer)::Integer = primes.get_primes(n * 20)[n]

compute(6)

compute(10001)

@benchmark compute(10001)