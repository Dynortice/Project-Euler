using BenchmarkTools
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100

compute(n::Int)::Int = n * (n + 1) * (3n ^ 2 - n - 2) ÷ 12

compute(10)

compute(100)

@benchmark compute(100)
