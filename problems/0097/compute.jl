include("euler/euler.jl")
using .BigIntegers: BigInteger

compute()::BigInteger = 28433 * powermod(BigInteger(2), 7830457, 10000000000) % 10000000000 + 1