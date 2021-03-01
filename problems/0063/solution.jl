include("euler/euler.jl")
using .BigIntegers: BigInteger
using BenchmarkTools
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100

function compute()::Int
    result = 0
    for i ∈ 1:9
        j, n = 1, BigInteger(i)
        while length(n) == j
            result += 1
            j += 1
            n *= i
        end
    end
    return result
end

compute()

@benchmark compute()