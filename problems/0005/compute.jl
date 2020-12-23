include("../euler/Julia/primes.jl")
using .Primes: get_primes

compute(n::Int64)::Int64 = prod([prime ^ trunc(Int, log(prime, n)) for prime ∈ get_primes(n)])
