include("euler/euler.jl")
using .Calculus: get_fibonacci

compute(n::Int)::Int = get_fibonacci(n + 2)
