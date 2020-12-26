using BenchmarkTools
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100

compute(n::Int64, k::Int64)::Float64 = round(7(1 - prod(1 .- k ./ (6n ÷ 7 + 1:n))), digits=9)

compute(70, 20)

@benchmark compute(70, 20)