include("euler/Julia/calculus.jl")
using BenchmarkTools
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100

function compute()::Int64
    pentagonals = [1]
    j = 1
    for i in pentagonals
        for k in pentagonals
            if calculus.is_pentagonal(i - k) & calculus.is_pentagonal(abs(i - 2 * k))
                return abs(i - 2 * k)
            end
        end
        j += 3
        append!(pentagonals, i + j)
    end
end

compute()

@benchmark compute()