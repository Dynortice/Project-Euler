using BenchmarkTools
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100

compute(n::Int)::Int = sum(powermod.(1:n, 1:n, 10_000_000_000)) % 10_000_000_000

compute(10)

compute(1_000)

@benchmark compute(1_000)