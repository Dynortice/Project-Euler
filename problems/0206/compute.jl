include("euler/euler.jl")
using .BigIntegers: BigInteger

function compute()::BigInteger
    number = BigInteger(138_902_663)
    j = 3
    while(!all(parse(Int, (number * number)[i * 2 + 1]) == i + 1 for i ∈ 0:8))
        if j == 3
            number -= 6
            j = 7
        elseif j == 7
            number -= 4
            j = 3
        end
    end
    return number * 10
end