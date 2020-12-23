include("euler/Julia/big_int.jl")
using .BigIntegers: BigInteger

compute(n::Int64)::Int64 = sum([parse(Int, i) for i ∈ prod(map(BigInteger, 1:n)).str])
