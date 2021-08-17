include("euler/euler.jl")
using .BigIntegers: BigInteger
using .Numbers: digits_sum
using BenchmarkTools
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100

compute(n::Int, p::Int)::Int = digits_sum(BigInteger(n) ^ p)

compute(2, 15)

compute(2, 1_000)

@benchmark compute(2, 1_000)