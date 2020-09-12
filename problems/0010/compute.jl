include("../euler/Julia/primes.jl")

compute(n::Integer)::Integer = sum(primes.get_primes(n))
