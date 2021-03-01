include("euler/euler.jl")
using .Primes: get_primes

compute(n::Int)::Int = sum(get_primes(n))
