include("euler/Julia/big_int.jl")
using .BigIntegers: BigInteger

compute(n::Int64, list_numbers::String)::SubString = sum(map(BigInteger, split(list_numbers, "\n")))[1:n]
