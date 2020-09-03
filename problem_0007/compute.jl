include("../euler/Julia/primes.jl")

compute(n::Integer)::Integer = primes.get_primes(n * 20)[n]
