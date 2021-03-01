using BenchmarkTools
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100

compute(n::Int)::Int = sum(powermod.(1:n, 1:n, 10000000000)) % 10000000000

compute(10)

compute(1000)

@benchmark compute(1000)