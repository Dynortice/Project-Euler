include("euler/Julia/big_int.jl")
using .BigIntegers: BigInteger
using BenchmarkTools
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100

compute(n::Int64, p::Int64)::Int64 = sum([parse(Int, i) for i ∈ (BigInteger(n) ^ p).str])

compute(2, 15)

compute(2, 1000)

@benchmark compute(2, 1000)