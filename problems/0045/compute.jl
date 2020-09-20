include("euler/Julia/calculus.jl")

function compute()::Int64
    n = calculus.get_hexagonal(144)
    i = n - 40755
    while true
        if calculus.is_pentagonal(n)
            return n
        end
        i += 4
        n += i
    end
end