using BenchmarkTools
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100

compute(n::Int)::Int = Int(ceil((log(10) * (n - 1) + 0.5log(5)) / log(0.5(1 + √5))))

compute(3)

compute(1_000)

@benchmark compute(1_000)