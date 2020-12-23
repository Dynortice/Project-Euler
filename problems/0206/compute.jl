include("euler/Julia/big_int.jl")
using .BigIntegers: BigInteger

function compute()::BigInteger
    match(n::BigInteger)::Bool = all(parse(Int64, n.str[i * 2 + 1]) == i + 1 for i ∈ 0:8)

    number = BigInteger(138902663)
    j = 3
    while(!match(number * number))
        if j ≡ 3
            number -= 6
            j = 7
        elseif j ≡ 7
            number -= 4
            j = 3
        end
    end
    return number * 10
end