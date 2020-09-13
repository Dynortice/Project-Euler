include("euler/Julia/big_int.jl")

function compute(n::Integer, list_numbers::String)::String
    list_numbers = split(list_numbers, "\n")
    result = Big_Int("0")
    for number in list_numbers
        result += Big_Int(number)
    end
    return result[1:n]
end
