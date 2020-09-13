include("euler/Julia/big_int.jl")

compute(n::Integer, p::Integer) = sum((Big_Int(string(n)) ^ p).digits)
