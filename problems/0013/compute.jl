include("euler/euler.jl")
using .BigIntegers: BigInteger

compute(n::Int, list_numbers::String)::SubString = sum(map(BigInteger, split(list_numbers, "\n")))[1:n]
