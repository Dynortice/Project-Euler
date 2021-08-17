include("euler/euler.jl")
using .BigIntegers: BigInteger
using BenchmarkTools
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100

compute()::BigInteger = 28_433 * powermod(BigInteger(2), 7_830_457, 10_000_000_000) % 10_000_000_000 + 1

compute()

@benchmark compute()