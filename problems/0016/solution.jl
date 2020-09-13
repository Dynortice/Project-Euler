include("euler/Julia/big_int.jl")
using BenchmarkTools
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100

compute(n::Integer, p::Integer) = sum((Big_Int(string(n)) ^ p).digits)

compute(2, 15)

compute(2, 1000)

@benchmark compute(2, 1000)