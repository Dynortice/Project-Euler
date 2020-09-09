include("../euler/Julia/primes.jl")
using BenchmarkTools
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100

compute(n::Integer)::Integer = sum(primes.get_primes(n))

compute(10)

compute(2000000)

@benchmark compute(2000000)