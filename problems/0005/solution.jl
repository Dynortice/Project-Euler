include("euler/Julia/primes.jl")
using .Primes: get_primes
using BenchmarkTools
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100

compute(n::Int64)::Int64 = prod([prime ^ trunc(Int, log(prime, n)) for prime ∈ get_primes(n)])

compute(10)

compute(20)

@benchmark compute(20)
