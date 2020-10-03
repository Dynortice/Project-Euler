include("euler/Julia/big_int.jl")

function compute()::Big_Int
    match(n::Big_Int)::Bool = all(parse(Int64, n.str[i * 2 + 1]) == i + 1 for i ∈ 0:8)

    number = Big_Int("138902663")
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