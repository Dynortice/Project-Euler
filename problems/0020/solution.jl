include("euler/Julia/big_int.jl")
using .BigIntegers: BigInteger
using BenchmarkTools
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100

compute(n::Int64)::Int64 = sum([parse(Int, i) for i ∈ prod(map(BigInteger, 1:n)).str])

compute(10)

compute(100)

@benchmark compute(100)