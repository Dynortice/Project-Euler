include("euler/euler.jl")
using .Calculus: fibonacci_index, get_fibonacci

compute(n::Int)::Int = trunc(Int, get_fibonacci(fibonacci_index(n) + 2) / 2)
