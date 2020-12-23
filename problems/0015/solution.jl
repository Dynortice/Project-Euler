using BenchmarkTools
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100

compute(n::Int64)::Int64 = binomial(2 * n, n)

compute(2)

compute(20)

@benchmark compute(20)