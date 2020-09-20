include("euler/Julia/calculus.jl")
using BenchmarkTools
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100

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

compute()

@benchmark compute()