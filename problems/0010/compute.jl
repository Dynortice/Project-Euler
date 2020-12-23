include("../euler/Julia/primes.jl")
using .Primes: get_primes

compute(n::Int64)::Int64 = sum(get_primes(n))
