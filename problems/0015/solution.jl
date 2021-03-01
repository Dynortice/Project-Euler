using BenchmarkTools
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100

compute(n::Int)::Int = binomial(2n, n)

compute(2)

compute(20)

@benchmark compute(20)