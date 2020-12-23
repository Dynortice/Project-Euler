include("euler/Julia/big_int.jl")
using .BigIntegers: BigInteger
using BenchmarkTools
BenchmarkTools.DEFAULT_PARAMETERS.samples = 100

function compute()::BigInteger
    modulo = BigInteger("4503599627370517", true)
    min_value = max_value = result = BigInteger("1504170715041707", true)
    while true
        candidate = (min_value + max_value) % modulo
        if candidate > max_value
            max_value = candidate
        elseif candidate < min_value
            min_value = candidate
            result += candidate
            if candidate == 1
                break
            end
        end
    end
    return result
end

compute()

@benchmark compute()