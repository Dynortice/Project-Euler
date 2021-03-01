include("euler/euler.jl")
using .Primes: prime_numbers

compute(n::Int)::Int = prime_numbers(20n)[n]
