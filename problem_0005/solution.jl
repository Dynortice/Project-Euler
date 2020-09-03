include("euler/Julia/primes.jl")
using BenchmarkTools
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100

compute(n::Integer)::Integer = prod([prime ^ trunc(Int, log(prime, n)) for prime in primes.get_primes(n)])

compute(10)

compute(20)

@benchmark compute(20)
