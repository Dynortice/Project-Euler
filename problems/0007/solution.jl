include("euler/Julia/primes.jl")
using .Primes: get_primes
using BenchmarkTools
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100

compute(n::Int64)::Int64 = get_primes(n * 20)[n]

compute(6)

compute(10001)

@benchmark compute(10001)