include("euler/Julia/calculus.jl")
using .Calculus: is_pentagonal

function compute()::Int64
    pentagonals = [1]
    j = 1
    for i ∈ pentagonals
        for k ∈ pentagonals
            if is_pentagonal(i - k) & is_pentagonal(abs(i - 2 * k))
                return abs(i - 2 * k)
            end
        end
        j += 3
        append!(pentagonals, i + j)
    end
end