include("euler/Julia/big_int.jl")
using .BigIntegers: BigInteger

function compute(n::Int64)::Int64
    function get_next_term(previous::Array{BigInteger, 1}, k::Int64)::BigInteger
        if k % 3 == 1
            k ÷= 3
            return 2k * previous[1] + previous[2]
        else
            return sum(previous)
        end
    end
    terms = [BigInteger(1), BigInteger(1)]
    for i ∈ 2:n + 1
        terms = [get_next_term(terms, i), terms[1]]
    end
    return sum(parse.(Int64, split(terms[1].str, "")))
end
