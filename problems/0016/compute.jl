include("euler/euler.jl")
using .BigIntegers: BigInteger
using .Numbers: digits_sum

compute(n::Int, p::Int)::Int = digits_sum(BigInteger(n) ^ p)
