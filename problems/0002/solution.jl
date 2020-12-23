include("euler/Julia/calculus.jl")
using .Calculus: fibonacci_index, fibonacci_number
using BenchmarkTools
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100

compute(n::Int64)::Int64 = trunc(Int, fibonacci_number(fibonacci_index(n) + 2) / 2)

compute(4000000)

@benchmark compute(4000000)
