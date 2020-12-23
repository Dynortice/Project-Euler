include("../euler/Julia/primes.jl")
using .Primes: get_primes

compute(n::Int64)::Int64 = primes.get_primes(n * 20)[n]
