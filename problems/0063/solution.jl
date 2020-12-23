include("euler/Julia/big_int.jl")
using .BigIntegers: BigInteger
using BenchmarkTools
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100

function compute()::Int64
    result = 0
    i = 1
    while true
        j = 1
        number, n = BigInteger(i), BigInteger(i)
        if length(number) ≠ j
            break
        else
            result += 1
        end
        while true
            j += 1
            number *= n
            if length(number) ≡ j
                result += 1
            else
                break
            end
        end
        i += 1
    end
    return result
end

compute()

@benchmark compute()