using BenchmarkTools
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100

compute(n::Int64)::Int64 = sum(powermod.(1:n, 1:n, 10 ^ 10)) % 10 ^ 10

compute(10)

compute(1000)

@benchmark compute(1000)