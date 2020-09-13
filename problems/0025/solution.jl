using BenchmarkTools
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100

compute(n::Int64)::Int64 = Int(ceil((log(10) * (n - 1) + log(5) / 2) / log((1 + √5) / 2)))

compute(3)

compute(1000)

@benchmark compute(1000)