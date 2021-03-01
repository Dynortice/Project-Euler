using BenchmarkTools
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100

compute(n::Int)::Int = (n - 5) ÷ 7 * 3 + 2

compute(8)

compute(1000000)

@benchmark compute(1000000)