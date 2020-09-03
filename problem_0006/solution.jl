using BenchmarkTools
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100

compute(n::Integer)::Integer = n * (n + 1) * (3 * n ^ 2 - n - 2) ÷ 12

compute(10)

compute(100)

@benchmark compute(100)
