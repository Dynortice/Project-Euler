include("euler/euler.jl")
using .Calculus: is_pentagonal
using BenchmarkTools
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100

function compute()::Int
    pentagonals = [1]
    j = 1
    for i ∈ pentagonals
        for k ∈ pentagonals
            if is_pentagonal(i - k) && is_pentagonal(abs(i - 2k))
                return abs(i - 2k)
            end
        end
        j += 3
        append!(pentagonals, i + j)
    end
end

compute()

@benchmark compute()