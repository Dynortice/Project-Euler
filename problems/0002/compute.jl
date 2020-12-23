include("../euler/Julia/calculus.jl")
using .Calculus: fibonacci_index, fibonacci_number

compute(n::Int64)::Int64 = trunc(Int, fibonacci_number(fibonacci_index(n) + 2) / 2)
