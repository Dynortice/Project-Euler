using BenchmarkTools
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100

compute(n::Int64)::Int64 = (n - 5) ÷ 7 * 3 + 2

compute(8)

compute(1000000)

@benchmark compute(1000000)