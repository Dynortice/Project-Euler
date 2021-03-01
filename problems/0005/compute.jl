include("euler/euler.jl")
using .Primes: prime_numbers

compute(n::Int)::Int = prod([prime ^ trunc(Int, log(prime, n)) for prime ∈ prime_numbers(n)])
