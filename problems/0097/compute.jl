include("euler/euler.jl")
using .BigIntegers: BigInteger

compute()::BigInteger = 28_433 * powermod(BigInteger(2), 7_830_457, 10_000_000_000) % 10_000_000_000 + 1