include("euler/euler.jl")
using .Calculus: fibonacci_index, get_fibonacci
using BenchmarkTools
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100

compute(n::Int)::Int = trunc(Int, get_fibonacci(fibonacci_index(n) + 2) / 2)

compute(4000000)

@benchmark compute(4000000)
