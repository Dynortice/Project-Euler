using BenchmarkTools
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100

compute(n::Int)::Int = (((4n + 3)n + 8)n - 9) ÷ 6

compute(5)

compute(1001)

@benchmark compute(1001)