include("euler/euler.jl")
using .BigIntegers: BigInteger
using .Numbers: digits_sum
using BenchmarkTools
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100

compute(n::Int)::Int = digits_sum(prod(map(BigInteger, 1:n)))

compute(10)

compute(100)

@benchmark compute(100)