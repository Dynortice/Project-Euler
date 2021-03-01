include("euler/euler.jl")
using .Calculus: get_fibonacci
using BenchmarkTools
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100

compute(n::Int)::Int = get_fibonacci(n + 2)

compute(30)

@benchmark compute(30)