include("euler/Julia/big_int.jl")
using .BigIntegers: BigInteger
using BenchmarkTools
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100

compute()::BigInteger = 28433 * powermod(BigInteger(2), 7830457, 10 ^ 10) % 10 ^ 10 + 1

compute()

@benchmark compute()