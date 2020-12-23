include("euler/Julia/calculus.jl")
using .Calculus: get_hexagonal, is_pentagonal

function compute()::Int64
    n = get_hexagonal(144)
    i = n - 40755
    while true
        if is_pentagonal(n)
            return n
        end
        i += 4
        n += i
    end
end