include("euler/Julia/big_int.jl")

compute(n::Integer, p::Integer) = sum([parse(Int, i) for i in (Big_Int(string(n)) ^ p).str])
