include("../euler/Julia/primes.jl")

compute(n::Integer)::Integer = prod([prime ^ trunc(Int, log(prime, n)) for prime in primes.get_primes(n)])
