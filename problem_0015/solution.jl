using BenchmarkTools
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100

compute(n::Integer)::Integer = binomial(2 * n, n)

compute(2)

compute(20)

@benchmark compute(20)