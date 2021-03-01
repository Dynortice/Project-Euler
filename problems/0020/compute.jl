include("euler/euler.jl")
using .BigIntegers: BigInteger
using .Numbers: digits_sum

compute(n::Int)::Int = digits_sum(prod(map(BigInteger, 1:n)))
